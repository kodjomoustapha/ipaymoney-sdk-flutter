// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_response_ipay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StateResponseIpay _$StateResponseIpayFromJson(Map<String, dynamic> json) {
  return _StateResponseIpay.fromJson(json);
}

/// @nodoc
mixin _$StateResponseIpay {
// Define the properties of the `StateResponseIpay` class
  String? get reference => throw _privateConstructorUsedError;
  String? get publicReference => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get acsUrl => throw _privateConstructorUsedError;
  String? get base64EncodedCqeq => throw _privateConstructorUsedError;
  String? get termUrlGet => throw _privateConstructorUsedError;
  String? get notificationUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StateResponseIpayCopyWith<StateResponseIpay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateResponseIpayCopyWith<$Res> {
  factory $StateResponseIpayCopyWith(
          StateResponseIpay value, $Res Function(StateResponseIpay) then) =
      _$StateResponseIpayCopyWithImpl<$Res, StateResponseIpay>;
  @useResult
  $Res call(
      {String? reference,
      String? publicReference,
      String? state,
      String? acsUrl,
      String? base64EncodedCqeq,
      String? termUrlGet,
      String? notificationUrl});
}

/// @nodoc
class _$StateResponseIpayCopyWithImpl<$Res, $Val extends StateResponseIpay>
    implements $StateResponseIpayCopyWith<$Res> {
  _$StateResponseIpayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = freezed,
    Object? publicReference = freezed,
    Object? state = freezed,
    Object? acsUrl = freezed,
    Object? base64EncodedCqeq = freezed,
    Object? termUrlGet = freezed,
    Object? notificationUrl = freezed,
  }) {
    return _then(_value.copyWith(
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      publicReference: freezed == publicReference
          ? _value.publicReference
          : publicReference // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      acsUrl: freezed == acsUrl
          ? _value.acsUrl
          : acsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      base64EncodedCqeq: freezed == base64EncodedCqeq
          ? _value.base64EncodedCqeq
          : base64EncodedCqeq // ignore: cast_nullable_to_non_nullable
              as String?,
      termUrlGet: freezed == termUrlGet
          ? _value.termUrlGet
          : termUrlGet // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationUrl: freezed == notificationUrl
          ? _value.notificationUrl
          : notificationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateResponseIpayImplCopyWith<$Res>
    implements $StateResponseIpayCopyWith<$Res> {
  factory _$$StateResponseIpayImplCopyWith(_$StateResponseIpayImpl value,
          $Res Function(_$StateResponseIpayImpl) then) =
      __$$StateResponseIpayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? reference,
      String? publicReference,
      String? state,
      String? acsUrl,
      String? base64EncodedCqeq,
      String? termUrlGet,
      String? notificationUrl});
}

/// @nodoc
class __$$StateResponseIpayImplCopyWithImpl<$Res>
    extends _$StateResponseIpayCopyWithImpl<$Res, _$StateResponseIpayImpl>
    implements _$$StateResponseIpayImplCopyWith<$Res> {
  __$$StateResponseIpayImplCopyWithImpl(_$StateResponseIpayImpl _value,
      $Res Function(_$StateResponseIpayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = freezed,
    Object? publicReference = freezed,
    Object? state = freezed,
    Object? acsUrl = freezed,
    Object? base64EncodedCqeq = freezed,
    Object? termUrlGet = freezed,
    Object? notificationUrl = freezed,
  }) {
    return _then(_$StateResponseIpayImpl(
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      publicReference: freezed == publicReference
          ? _value.publicReference
          : publicReference // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      acsUrl: freezed == acsUrl
          ? _value.acsUrl
          : acsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      base64EncodedCqeq: freezed == base64EncodedCqeq
          ? _value.base64EncodedCqeq
          : base64EncodedCqeq // ignore: cast_nullable_to_non_nullable
              as String?,
      termUrlGet: freezed == termUrlGet
          ? _value.termUrlGet
          : termUrlGet // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationUrl: freezed == notificationUrl
          ? _value.notificationUrl
          : notificationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$StateResponseIpayImpl implements _StateResponseIpay {
  const _$StateResponseIpayImpl(
      {this.reference,
      this.publicReference,
      this.state,
      this.acsUrl,
      this.base64EncodedCqeq,
      this.termUrlGet,
      this.notificationUrl});

  factory _$StateResponseIpayImpl.fromJson(Map<String, dynamic> json) =>
      _$$StateResponseIpayImplFromJson(json);

// Define the properties of the `StateResponseIpay` class
  @override
  final String? reference;
  @override
  final String? publicReference;
  @override
  final String? state;
  @override
  final String? acsUrl;
  @override
  final String? base64EncodedCqeq;
  @override
  final String? termUrlGet;
  @override
  final String? notificationUrl;

  @override
  String toString() {
    return 'StateResponseIpay(reference: $reference, publicReference: $publicReference, state: $state, acsUrl: $acsUrl, base64EncodedCqeq: $base64EncodedCqeq, termUrlGet: $termUrlGet, notificationUrl: $notificationUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateResponseIpayImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.publicReference, publicReference) ||
                other.publicReference == publicReference) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.acsUrl, acsUrl) || other.acsUrl == acsUrl) &&
            (identical(other.base64EncodedCqeq, base64EncodedCqeq) ||
                other.base64EncodedCqeq == base64EncodedCqeq) &&
            (identical(other.termUrlGet, termUrlGet) ||
                other.termUrlGet == termUrlGet) &&
            (identical(other.notificationUrl, notificationUrl) ||
                other.notificationUrl == notificationUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, reference, publicReference,
      state, acsUrl, base64EncodedCqeq, termUrlGet, notificationUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StateResponseIpayImplCopyWith<_$StateResponseIpayImpl> get copyWith =>
      __$$StateResponseIpayImplCopyWithImpl<_$StateResponseIpayImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StateResponseIpayImplToJson(
      this,
    );
  }
}

abstract class _StateResponseIpay implements StateResponseIpay {
  const factory _StateResponseIpay(
      {final String? reference,
      final String? publicReference,
      final String? state,
      final String? acsUrl,
      final String? base64EncodedCqeq,
      final String? termUrlGet,
      final String? notificationUrl}) = _$StateResponseIpayImpl;

  factory _StateResponseIpay.fromJson(Map<String, dynamic> json) =
      _$StateResponseIpayImpl.fromJson;

  @override // Define the properties of the `StateResponseIpay` class
  String? get reference;
  @override
  String? get publicReference;
  @override
  String? get state;
  @override
  String? get acsUrl;
  @override
  String? get base64EncodedCqeq;
  @override
  String? get termUrlGet;
  @override
  String? get notificationUrl;
  @override
  @JsonKey(ignore: true)
  _$$StateResponseIpayImplCopyWith<_$StateResponseIpayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
