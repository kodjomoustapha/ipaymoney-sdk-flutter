// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_response_ipay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StateResponseIpay _$$_StateResponseIpayFromJson(Map<String, dynamic> json) =>
    _$_StateResponseIpay(
      reference: json['reference'] as String?,
      publicReference: json['public_reference'] as String?,
      state: json['state'] as String?,
      acsUrl: json['acs_url'] as String?,
      base64EncodedCqeq: json['base64_encoded_cqeq'] as String?,
      termUrlGet: json['term_url_get'] as String?,
      notificationUrl: json['notification_url'] as String?,
    );

Map<String, dynamic> _$$_StateResponseIpayToJson(
        _$_StateResponseIpay instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'public_reference': instance.publicReference,
      'state': instance.state,
      'acs_url': instance.acsUrl,
      'base64_encoded_cqeq': instance.base64EncodedCqeq,
      'term_url_get': instance.termUrlGet,
      'notification_url': instance.notificationUrl,
    };
