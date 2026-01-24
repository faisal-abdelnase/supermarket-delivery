
enum PaymentStatus {
  pending,
  success,
  failed,
  canceled,
}


class PaymentResult {
  final PaymentStatus status;
  final String? transactionId;
  final String? message;

  PaymentResult({
    required this.status,
    this.transactionId,
    this.message,
  });
}
