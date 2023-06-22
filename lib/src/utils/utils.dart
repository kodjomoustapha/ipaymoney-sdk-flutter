import 'package:ipay_money_flutter_sdk/src/models/payment.dart';

String convertEnumToString(dynamic o) =>
    o.toString().split('.')[1].toLowerCase();

TransactionStatus getTransactionStatusEnum(String transactionStatus) {
  switch (transactionStatus) {
    case "failed":
      return TransactionStatus.failed;
    case "pending":
      return TransactionStatus.pending;
    default:
      return TransactionStatus.succeeded;
  }
}
