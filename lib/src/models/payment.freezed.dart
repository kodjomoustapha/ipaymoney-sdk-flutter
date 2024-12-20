// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Payment {
// Define the properties of the `Payment` class
  String? get publicReference => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get authorization => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  Country? get country => throw _privateConstructorUsedError;
  String? get msisdn => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  PaymentType? get paymentType => throw _privateConstructorUsedError;
  String? get pan => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get cvv => throw _privateConstructorUsedError;
  int? get timeOut => throw _privateConstructorUsedError;
  String? get referencePrefix => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  TargetEnvironment? get targetEnvironment =>
      throw _privateConstructorUsedError;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {String? publicReference,
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
      String? referencePrefix,
      String? transactionId,
      TargetEnvironment? targetEnvironment});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicReference = freezed,
    Object? reference = freezed,
    Object? authorization = freezed,
    Object? name = freezed,
    Object? amount = freezed,
    Object? country = freezed,
    Object? msisdn = freezed,
    Object? currency = freezed,
    Object? paymentType = freezed,
    Object? pan = freezed,
    Object? exp = freezed,
    Object? cvv = freezed,
    Object? timeOut = freezed,
    Object? referencePrefix = freezed,
    Object? transactionId = freezed,
    Object? targetEnvironment = freezed,
  }) {
    return _then(_value.copyWith(
      publicReference: freezed == publicReference
          ? _value.publicReference
          : publicReference // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      authorization: freezed == authorization
          ? _value.authorization
          : authorization // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      msisdn: freezed == msisdn
          ? _value.msisdn
          : msisdn // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      pan: freezed == pan
          ? _value.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      cvv: freezed == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String?,
      timeOut: freezed == timeOut
          ? _value.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as int?,
      referencePrefix: freezed == referencePrefix
          ? _value.referencePrefix
          : referencePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetEnvironment: freezed == targetEnvironment
          ? _value.targetEnvironment
          : targetEnvironment // ignore: cast_nullable_to_non_nullable
              as TargetEnvironment?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
          _$PaymentImpl value, $Res Function(_$PaymentImpl) then) =
      __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? publicReference,
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
      String? referencePrefix,
      String? transactionId,
      TargetEnvironment? targetEnvironment});
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
      _$PaymentImpl _value, $Res Function(_$PaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicReference = freezed,
    Object? reference = freezed,
    Object? authorization = freezed,
    Object? name = freezed,
    Object? amount = freezed,
    Object? country = freezed,
    Object? msisdn = freezed,
    Object? currency = freezed,
    Object? paymentType = freezed,
    Object? pan = freezed,
    Object? exp = freezed,
    Object? cvv = freezed,
    Object? timeOut = freezed,
    Object? referencePrefix = freezed,
    Object? transactionId = freezed,
    Object? targetEnvironment = freezed,
  }) {
    return _then(_$PaymentImpl(
      publicReference: freezed == publicReference
          ? _value.publicReference
          : publicReference // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      authorization: freezed == authorization
          ? _value.authorization
          : authorization // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      msisdn: freezed == msisdn
          ? _value.msisdn
          : msisdn // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      pan: freezed == pan
          ? _value.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      cvv: freezed == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String?,
      timeOut: freezed == timeOut
          ? _value.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as int?,
      referencePrefix: freezed == referencePrefix
          ? _value.referencePrefix
          : referencePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetEnvironment: freezed == targetEnvironment
          ? _value.targetEnvironment
          : targetEnvironment // ignore: cast_nullable_to_non_nullable
              as TargetEnvironment?,
    ));
  }
}

/// @nodoc

class _$PaymentImpl implements _Payment {
  const _$PaymentImpl(
      {this.publicReference,
      this.reference,
      this.authorization,
      this.name,
      this.amount,
      this.country,
      this.msisdn,
      this.currency,
      this.paymentType,
      this.pan,
      this.exp,
      this.cvv,
      this.timeOut,
      this.referencePrefix,
      this.transactionId,
      this.targetEnvironment});

// Define the properties of the `Payment` class
  @override
  final String? publicReference;
  @override
  final String? reference;
  @override
  final String? authorization;
  @override
  final String? name;
  @override
  final String? amount;
  @override
  final Country? country;
  @override
  final String? msisdn;
  @override
  final String? currency;
  @override
  final PaymentType? paymentType;
  @override
  final String? pan;
  @override
  final String? exp;
  @override
  final String? cvv;
  @override
  final int? timeOut;
  @override
  final String? referencePrefix;
  @override
  final String? transactionId;
  @override
  final TargetEnvironment? targetEnvironment;

  @override
  String toString() {
    return 'Payment(publicReference: $publicReference, reference: $reference, authorization: $authorization, name: $name, amount: $amount, country: $country, msisdn: $msisdn, currency: $currency, paymentType: $paymentType, pan: $pan, exp: $exp, cvv: $cvv, timeOut: $timeOut, referencePrefix: $referencePrefix, transactionId: $transactionId, targetEnvironment: $targetEnvironment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.publicReference, publicReference) ||
                other.publicReference == publicReference) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.authorization, authorization) ||
                other.authorization == authorization) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.msisdn, msisdn) || other.msisdn == msisdn) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.cvv, cvv) || other.cvv == cvv) &&
            (identical(other.timeOut, timeOut) || other.timeOut == timeOut) &&
            (identical(other.referencePrefix, referencePrefix) ||
                other.referencePrefix == referencePrefix) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.targetEnvironment, targetEnvironment) ||
                other.targetEnvironment == targetEnvironment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      publicReference,
      reference,
      authorization,
      name,
      amount,
      country,
      msisdn,
      currency,
      paymentType,
      pan,
      exp,
      cvv,
      timeOut,
      referencePrefix,
      transactionId,
      targetEnvironment);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {final String? publicReference,
      final String? reference,
      final String? authorization,
      final String? name,
      final String? amount,
      final Country? country,
      final String? msisdn,
      final String? currency,
      final PaymentType? paymentType,
      final String? pan,
      final String? exp,
      final String? cvv,
      final int? timeOut,
      final String? referencePrefix,
      final String? transactionId,
      final TargetEnvironment? targetEnvironment}) = _$PaymentImpl;

// Define the properties of the `Payment` class
  @override
  String? get publicReference;
  @override
  String? get reference;
  @override
  String? get authorization;
  @override
  String? get name;
  @override
  String? get amount;
  @override
  Country? get country;
  @override
  String? get msisdn;
  @override
  String? get currency;
  @override
  PaymentType? get paymentType;
  @override
  String? get pan;
  @override
  String? get exp;
  @override
  String? get cvv;
  @override
  int? get timeOut;
  @override
  String? get referencePrefix;
  @override
  String? get transactionId;
  @override
  TargetEnvironment? get targetEnvironment;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
