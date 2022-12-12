// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Payment({
    // Define the properties of the `Payment` class
    String? publicReference,
    String? reference,
    String? authorization,
    String? name,
    String? amount,
    Country? country,
    String? msisdn,
    String? currency,
    PaymentType? paymentType,
    String? pan,
    String? exp,
    String? cvv,
    int? timeOut,
    TargetEnvironment? targetEnvironment,
  }) = _Payment;
}
