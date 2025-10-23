import 'package:hungry/core/networks/exceptions/handle_error.dart';

class NotFoundError extends HandleError {
  @override
  String get message => 'NotFound Content';
}

class UnauthorizedError extends HandleError {
  @override
  String get message => 'Unauthorized Request';
}

class ForbiddenError extends HandleError {
  @override
  String get message => "Access forbidden.";
}

class BadRequestError extends HandleError {
  @override
  String get message => 'Bad request. Please check your input.';
}

class InternalServerError extends HandleError {
  @override
  String get message => 'Internal server error. Please try again later.';
}

class UnknownError extends HandleError {
  @override
  String get message => 'An unknown error occurred.';
}
