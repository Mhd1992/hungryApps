class ApiError {
  final String message;
  final int code;

  ApiError({required this.message, required this.code});

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message)';
  }
}
