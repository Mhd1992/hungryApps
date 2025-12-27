import 'package:hungry/core/models/response_failure.dart';
import 'package:hungry/core/models/validation_error.dart';

import '../../utils/exported_file.dart';

ResponseFailure handelResponseFailure(Object e, StackTrace stack) {
  if (e is Exception) {
    try {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        String? message =
            e.response?.data?['message'] ?? e.response?.data?['title'];
        message ??= e.response?.statusMessage;

        if (statusCode == null) return const ResponseFailure.unexpected();

        if (statusCode >= 500) {
          return ServerError(message);
        }

        if (statusCode == 401) {
          return ResponseFailure.unauthenticated();
        }

        if (statusCode == 403) {
          return ResponseFailure.forbidden(message ?? '');
        }

        if (statusCode == 409) {
          return Unknown(message ?? '');
        }

        if (statusCode == 400) {
          return BadRequest(ValidationResponse.fromJson(e.response?.data));
        }

        if (statusCode == 404) {
          return NotFound(message ?? "noResults");
        }

        //  FirebaseCrashlytics.instance.recordError(e, stack);

        return Unknown(message ?? "failedSubTitle");
      } else if (e is SocketException) {
        return const ResponseFailure.noNetwork();
      } else {
        // FirebaseCrashlytics.instance.recordError(e, stack);
        return const ResponseFailure.unexpected();
      }
    } on FormatException catch (e, stack) {
      // FirebaseCrashlytics.instance.recordError(e, stack);
      return const ResponseFailure.unexpected();
    } catch (e, stack) {
      //  FirebaseCrashlytics.instance.recordError(e, stack);
      return const ResponseFailure.unexpected();
    }
  } else {
    //  FirebaseCrashlytics.instance.recordError(e, stack);
    return const ResponseFailure.unexpected();
  }
}
