import 'package:hungry/core//models/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_failure.freezed.dart';

@freezed
abstract class ResponseFailure with _$ResponseFailure {
  const factory ResponseFailure.unauthenticated() = Unauthenticated;
  const factory ResponseFailure.unknown(String error) = Unknown;
  const factory ResponseFailure.noNetwork() = NoNetwork;
  const factory ResponseFailure.notFound(String error) = NotFound;
  const factory ResponseFailure.serverError([String? error]) = ServerError;
  const factory ResponseFailure.unexpected() = Unexpected;
  const factory ResponseFailure.badRequest(ValidationResponse validation) =
      BadRequest;
  const factory ResponseFailure.forbidden(String error) = Forbidden;
  const factory ResponseFailure.conflict() = Conflict;

  const ResponseFailure._();

  bool get isForbidden => false;
  bool get isConflict => false;

  String? get errorMessage {
    return switch (this) {
      Unauthenticated() => null,
      Unknown(error: final error) => error,
      NoNetwork() => null,
      NotFound(error: final error) => error,
      ServerError(error: final error) => error,
      Unexpected() => null,
      BadRequest(validation: final validation) => validation.message,
      Forbidden(error: final error) => error,
      Conflict() => null,
      ResponseFailure() => throw UnimplementedError(),
    };
  }
}

abstract final class ErrorCode {
  static const String wrongPinNumber = 'pin-number';
}
