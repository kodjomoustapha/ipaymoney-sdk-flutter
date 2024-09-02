// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipay_payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ipayPaymentHash() => r'fef2f59fdc7f0deb77af96110e67def4d0263be3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.
///
/// Copied from [ipayPayment].
@ProviderFor(ipayPayment)
const ipayPaymentProvider = IpayPaymentFamily();

/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.
///
/// Copied from [ipayPayment].
class IpayPaymentFamily extends Family<AsyncValue<String>> {
  /// Define a FutureProvider that can be used to make a direct payment
  /// Sends a POST request to the API to initiate a payment. The request body contains
  /// information about the payment, such as the amount, the customer's name, and the payment method.
  /// If the request is successful, it returns the response body as a string.
  /// Otherwise, it returns the response's reason phrase.
  ///
  /// Copied from [ipayPayment].
  const IpayPaymentFamily();

  /// Define a FutureProvider that can be used to make a direct payment
  /// Sends a POST request to the API to initiate a payment. The request body contains
  /// information about the payment, such as the amount, the customer's name, and the payment method.
  /// If the request is successful, it returns the response body as a string.
  /// Otherwise, it returns the response's reason phrase.
  ///
  /// Copied from [ipayPayment].
  IpayPaymentProvider call({
    required Payment? payment,
  }) {
    return IpayPaymentProvider(
      payment: payment,
    );
  }

  @override
  IpayPaymentProvider getProviderOverride(
    covariant IpayPaymentProvider provider,
  ) {
    return call(
      payment: provider.payment,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ipayPaymentProvider';
}

/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.
///
/// Copied from [ipayPayment].
class IpayPaymentProvider extends AutoDisposeFutureProvider<String> {
  /// Define a FutureProvider that can be used to make a direct payment
  /// Sends a POST request to the API to initiate a payment. The request body contains
  /// information about the payment, such as the amount, the customer's name, and the payment method.
  /// If the request is successful, it returns the response body as a string.
  /// Otherwise, it returns the response's reason phrase.
  ///
  /// Copied from [ipayPayment].
  IpayPaymentProvider({
    required Payment? payment,
  }) : this._internal(
          (ref) => ipayPayment(
            ref as IpayPaymentRef,
            payment: payment,
          ),
          from: ipayPaymentProvider,
          name: r'ipayPaymentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ipayPaymentHash,
          dependencies: IpayPaymentFamily._dependencies,
          allTransitiveDependencies:
              IpayPaymentFamily._allTransitiveDependencies,
          payment: payment,
        );

  IpayPaymentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.payment,
  }) : super.internal();

  final Payment? payment;

  @override
  Override overrideWith(
    FutureOr<String> Function(IpayPaymentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IpayPaymentProvider._internal(
        (ref) => create(ref as IpayPaymentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        payment: payment,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _IpayPaymentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IpayPaymentProvider && other.payment == payment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, payment.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IpayPaymentRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `payment` of this provider.
  Payment? get payment;
}

class _IpayPaymentProviderElement
    extends AutoDisposeFutureProviderElement<String> with IpayPaymentRef {
  _IpayPaymentProviderElement(super.provider);

  @override
  Payment? get payment => (origin as IpayPaymentProvider).payment;
}

String _$ipayVisaMasterCardPaymentHash() =>
    r'ebee0a537ad111bad96b14840e502f4c30612ee5';

/// See also [ipayVisaMasterCardPayment].
@ProviderFor(ipayVisaMasterCardPayment)
const ipayVisaMasterCardPaymentProvider = IpayVisaMasterCardPaymentFamily();

/// See also [ipayVisaMasterCardPayment].
class IpayVisaMasterCardPaymentFamily extends Family<AsyncValue<String>> {
  /// See also [ipayVisaMasterCardPayment].
  const IpayVisaMasterCardPaymentFamily();

  /// See also [ipayVisaMasterCardPayment].
  IpayVisaMasterCardPaymentProvider call({
    required String authorization,
    required String orderReference,
    required String reference,
    required String paymentReference,
  }) {
    return IpayVisaMasterCardPaymentProvider(
      authorization: authorization,
      orderReference: orderReference,
      reference: reference,
      paymentReference: paymentReference,
    );
  }

  @override
  IpayVisaMasterCardPaymentProvider getProviderOverride(
    covariant IpayVisaMasterCardPaymentProvider provider,
  ) {
    return call(
      authorization: provider.authorization,
      orderReference: provider.orderReference,
      reference: provider.reference,
      paymentReference: provider.paymentReference,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ipayVisaMasterCardPaymentProvider';
}

/// See also [ipayVisaMasterCardPayment].
class IpayVisaMasterCardPaymentProvider
    extends AutoDisposeFutureProvider<String> {
  /// See also [ipayVisaMasterCardPayment].
  IpayVisaMasterCardPaymentProvider({
    required String authorization,
    required String orderReference,
    required String reference,
    required String paymentReference,
  }) : this._internal(
          (ref) => ipayVisaMasterCardPayment(
            ref as IpayVisaMasterCardPaymentRef,
            authorization: authorization,
            orderReference: orderReference,
            reference: reference,
            paymentReference: paymentReference,
          ),
          from: ipayVisaMasterCardPaymentProvider,
          name: r'ipayVisaMasterCardPaymentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ipayVisaMasterCardPaymentHash,
          dependencies: IpayVisaMasterCardPaymentFamily._dependencies,
          allTransitiveDependencies:
              IpayVisaMasterCardPaymentFamily._allTransitiveDependencies,
          authorization: authorization,
          orderReference: orderReference,
          reference: reference,
          paymentReference: paymentReference,
        );

  IpayVisaMasterCardPaymentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.authorization,
    required this.orderReference,
    required this.reference,
    required this.paymentReference,
  }) : super.internal();

  final String authorization;
  final String orderReference;
  final String reference;
  final String paymentReference;

  @override
  Override overrideWith(
    FutureOr<String> Function(IpayVisaMasterCardPaymentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IpayVisaMasterCardPaymentProvider._internal(
        (ref) => create(ref as IpayVisaMasterCardPaymentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        authorization: authorization,
        orderReference: orderReference,
        reference: reference,
        paymentReference: paymentReference,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _IpayVisaMasterCardPaymentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IpayVisaMasterCardPaymentProvider &&
        other.authorization == authorization &&
        other.orderReference == orderReference &&
        other.reference == reference &&
        other.paymentReference == paymentReference;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authorization.hashCode);
    hash = _SystemHash.combine(hash, orderReference.hashCode);
    hash = _SystemHash.combine(hash, reference.hashCode);
    hash = _SystemHash.combine(hash, paymentReference.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IpayVisaMasterCardPaymentRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `authorization` of this provider.
  String get authorization;

  /// The parameter `orderReference` of this provider.
  String get orderReference;

  /// The parameter `reference` of this provider.
  String get reference;

  /// The parameter `paymentReference` of this provider.
  String get paymentReference;
}

class _IpayVisaMasterCardPaymentProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with IpayVisaMasterCardPaymentRef {
  _IpayVisaMasterCardPaymentProviderElement(super.provider);

  @override
  String get authorization =>
      (origin as IpayVisaMasterCardPaymentProvider).authorization;
  @override
  String get orderReference =>
      (origin as IpayVisaMasterCardPaymentProvider).orderReference;
  @override
  String get reference =>
      (origin as IpayVisaMasterCardPaymentProvider).reference;
  @override
  String get paymentReference =>
      (origin as IpayVisaMasterCardPaymentProvider).paymentReference;
}

String _$paymentEnquiryHash() => r'cce9e97c4615e812e6745fc3c952377789dfa038';

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
///
/// Copied from [paymentEnquiry].
@ProviderFor(paymentEnquiry)
const paymentEnquiryProvider = PaymentEnquiryFamily();

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
///
/// Copied from [paymentEnquiry].
class PaymentEnquiryFamily extends Family<AsyncValue<String>> {
  /// Define a FutureProvider that can be used for paymentEnquiry request
  /// Sends a GET request to the API to retrieve information about the payment specified
  /// by the reference property of the Payment object. If the request is successful,
  /// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
  ///
  /// Copied from [paymentEnquiry].
  const PaymentEnquiryFamily();

  /// Define a FutureProvider that can be used for paymentEnquiry request
  /// Sends a GET request to the API to retrieve information about the payment specified
  /// by the reference property of the Payment object. If the request is successful,
  /// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
  ///
  /// Copied from [paymentEnquiry].
  PaymentEnquiryProvider call({
    required Payment payment,
  }) {
    return PaymentEnquiryProvider(
      payment: payment,
    );
  }

  @override
  PaymentEnquiryProvider getProviderOverride(
    covariant PaymentEnquiryProvider provider,
  ) {
    return call(
      payment: provider.payment,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentEnquiryProvider';
}

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
///
/// Copied from [paymentEnquiry].
class PaymentEnquiryProvider extends AutoDisposeFutureProvider<String> {
  /// Define a FutureProvider that can be used for paymentEnquiry request
  /// Sends a GET request to the API to retrieve information about the payment specified
  /// by the reference property of the Payment object. If the request is successful,
  /// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
  ///
  /// Copied from [paymentEnquiry].
  PaymentEnquiryProvider({
    required Payment payment,
  }) : this._internal(
          (ref) => paymentEnquiry(
            ref as PaymentEnquiryRef,
            payment: payment,
          ),
          from: paymentEnquiryProvider,
          name: r'paymentEnquiryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paymentEnquiryHash,
          dependencies: PaymentEnquiryFamily._dependencies,
          allTransitiveDependencies:
              PaymentEnquiryFamily._allTransitiveDependencies,
          payment: payment,
        );

  PaymentEnquiryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.payment,
  }) : super.internal();

  final Payment payment;

  @override
  Override overrideWith(
    FutureOr<String> Function(PaymentEnquiryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaymentEnquiryProvider._internal(
        (ref) => create(ref as PaymentEnquiryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        payment: payment,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _PaymentEnquiryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentEnquiryProvider && other.payment == payment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, payment.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PaymentEnquiryRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `payment` of this provider.
  Payment get payment;
}

class _PaymentEnquiryProviderElement
    extends AutoDisposeFutureProviderElement<String> with PaymentEnquiryRef {
  _PaymentEnquiryProviderElement(super.provider);

  @override
  Payment get payment => (origin as PaymentEnquiryProvider).payment;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
