// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Payment _$$_PaymentFromJson(Map<String, dynamic> json) => _$_Payment(
      publicReference: json['public_reference'] as String?,
      reference: json['reference'] as String?,
      authorization: json['authorization'] as String?,
      name: json['name'] as String?,
      amount: json['amount'] as String?,
      country: $enumDecodeNullable(_$CountryEnumMap, json['country']),
      msisdn: json['msisdn'] as String?,
      currency: json['currency'] as String?,
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['payment_type']),
      pan: json['pan'] as String?,
      exp: json['exp'] as String?,
      cvv: json['cvv'] as String?,
      timeOut: json['time_out'] as int?,
      targetEnvironment: $enumDecodeNullable(
          _$TargetEnvironmentEnumMap, json['target_environment']),
    );

Map<String, dynamic> _$$_PaymentToJson(_$_Payment instance) =>
    <String, dynamic>{
      'public_reference': instance.publicReference,
      'reference': instance.reference,
      'authorization': instance.authorization,
      'name': instance.name,
      'amount': instance.amount,
      'country': _$CountryEnumMap[instance.country],
      'msisdn': instance.msisdn,
      'currency': instance.currency,
      'payment_type': _$PaymentTypeEnumMap[instance.paymentType],
      'pan': instance.pan,
      'exp': instance.exp,
      'cvv': instance.cvv,
      'time_out': instance.timeOut,
      'target_environment':
          _$TargetEnvironmentEnumMap[instance.targetEnvironment],
    };

const _$CountryEnumMap = {
  Country.ne: 'ne',
  Country.bj: 'bj',
};

const _$PaymentTypeEnumMap = {
  PaymentType.mobile: 'mobile',
  PaymentType.alizza: 'alizza',
  PaymentType.card: 'card',
};

const _$TargetEnvironmentEnumMap = {
  TargetEnvironment.live: 'live',
  TargetEnvironment.sandbox: 'sandbox',
};
