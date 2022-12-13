// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_response_ipay.freezed.dart';
part 'state_response_ipay.g.dart';

@freezed
class StateResponseIpay with _$StateResponseIpay {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory StateResponseIpay({
    // Define the properties of the `StateResponseIpay` class
    String? reference,
    String? publicReference,
    String? state,
    String? acsUrl,
    String? base64EncodedCqeq,
    String? termUrlGet,
    String? notificationUrl,
  }) = _StateResponseIpay;
  // Converts a JSON object to a StateResponseIpay instance.
  factory StateResponseIpay.fromJson(Map<String, dynamic> json) =>
      _$StateResponseIpayFromJson(json);
}
