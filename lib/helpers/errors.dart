class AuthAPIError implements Exception {
  String cause;
  AuthAPIError(this.cause);
}
