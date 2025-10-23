import 'package:hungry/core/networks/exceptions/errors.dart';
import 'package:hungry/core/networks/exceptions/handle_error.dart';

class ApiException implements Exception {
  static HandleError handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return NotFoundError();
      case 401:
        return UnauthorizedError();

      default:
        return UnknownError();
    }
  }
}
