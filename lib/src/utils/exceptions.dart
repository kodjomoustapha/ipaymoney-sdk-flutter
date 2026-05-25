/// Exception thrown when an iPay payment API request fails.
class IpayPaymentException implements Exception {
  /// The error message from the API.
  final String message;

  /// The HTTP status code of the response.
  final int statusCode;

  /// The reason phrase from the HTTP response.
  final String? reasonPhrase;

  const IpayPaymentException({
    required this.message,
    required this.statusCode,
    this.reasonPhrase,
  });

  @override
  String toString() =>
      'IpayPaymentException(statusCode: $statusCode, message: $message)';
}
