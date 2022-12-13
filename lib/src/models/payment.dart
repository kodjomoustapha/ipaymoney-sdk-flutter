// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
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

// Define the `Country` enum
enum Country { ne, bj }

// Define the `PaymentType` enum
enum PaymentType { mobile, alizza, card }

// Define the `TargetEnvironment` enum
enum TargetEnvironment { live, sandbox }
