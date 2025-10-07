// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipay_payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.

@ProviderFor(ipayPayment)
const ipayPaymentProvider = IpayPaymentFamily._();

/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.

final class IpayPaymentProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Define a FutureProvider that can be used to make a direct payment
  /// Sends a POST request to the API to initiate a payment. The request body contains
  /// information about the payment, such as the amount, the customer's name, and the payment method.
  /// If the request is successful, it returns the response body as a string.
  /// Otherwise, it returns the response's reason phrase.
  const IpayPaymentProvider._({
    required IpayPaymentFamily super.from,
    required Payment? super.argument,
  }) : super(
         retry: null,
         name: r'ipayPaymentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ipayPaymentHash();

  @override
  String toString() {
    return r'ipayPaymentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as Payment?;
    return ipayPayment(ref, payment: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IpayPaymentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ipayPaymentHash() => r'734f035ec4d4ad82e732ef38e803c1c3ed66ffeb';

/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.

final class IpayPaymentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, Payment?> {
  const IpayPaymentFamily._()
    : super(
        retry: null,
        name: r'ipayPaymentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Define a FutureProvider that can be used to make a direct payment
  /// Sends a POST request to the API to initiate a payment. The request body contains
  /// information about the payment, such as the amount, the customer's name, and the payment method.
  /// If the request is successful, it returns the response body as a string.
  /// Otherwise, it returns the response's reason phrase.

  IpayPaymentProvider call({required Payment? payment}) =>
      IpayPaymentProvider._(argument: payment, from: this);

  @override
  String toString() => r'ipayPaymentProvider';
}

@ProviderFor(ipayVisaMasterCardPayment)
const ipayVisaMasterCardPaymentProvider = IpayVisaMasterCardPaymentFamily._();

final class IpayVisaMasterCardPaymentProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const IpayVisaMasterCardPaymentProvider._({
    required IpayVisaMasterCardPaymentFamily super.from,
    required ({
      String authorization,
      String orderReference,
      String reference,
      String paymentReference,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'ipayVisaMasterCardPaymentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ipayVisaMasterCardPaymentHash();

  @override
  String toString() {
    return r'ipayVisaMasterCardPaymentProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument =
        this.argument
            as ({
              String authorization,
              String orderReference,
              String reference,
              String paymentReference,
            });
    return ipayVisaMasterCardPayment(
      ref,
      authorization: argument.authorization,
      orderReference: argument.orderReference,
      reference: argument.reference,
      paymentReference: argument.paymentReference,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IpayVisaMasterCardPaymentProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ipayVisaMasterCardPaymentHash() =>
    r'cb2095b57b1d988fb01642173e12598666cc26ee';

final class IpayVisaMasterCardPaymentFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<String>,
          ({
            String authorization,
            String orderReference,
            String reference,
            String paymentReference,
          })
        > {
  const IpayVisaMasterCardPaymentFamily._()
    : super(
        retry: null,
        name: r'ipayVisaMasterCardPaymentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IpayVisaMasterCardPaymentProvider call({
    required String authorization,
    required String orderReference,
    required String reference,
    required String paymentReference,
  }) => IpayVisaMasterCardPaymentProvider._(
    argument: (
      authorization: authorization,
      orderReference: orderReference,
      reference: reference,
      paymentReference: paymentReference,
    ),
    from: this,
  );

  @override
  String toString() => r'ipayVisaMasterCardPaymentProvider';
}

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.

@ProviderFor(paymentEnquiry)
const paymentEnquiryProvider = PaymentEnquiryFamily._();

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.

final class PaymentEnquiryProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Define a FutureProvider that can be used for paymentEnquiry request
  /// Sends a GET request to the API to retrieve information about the payment specified
  /// by the reference property of the Payment object. If the request is successful,
  /// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
  const PaymentEnquiryProvider._({
    required PaymentEnquiryFamily super.from,
    required Payment super.argument,
  }) : super(
         retry: null,
         name: r'paymentEnquiryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paymentEnquiryHash();

  @override
  String toString() {
    return r'paymentEnquiryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as Payment;
    return paymentEnquiry(ref, payment: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentEnquiryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paymentEnquiryHash() => r'13026fd403e66f9139ed677ffe8d393214edf982';

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.

final class PaymentEnquiryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, Payment> {
  const PaymentEnquiryFamily._()
    : super(
        retry: null,
        name: r'paymentEnquiryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Define a FutureProvider that can be used for paymentEnquiry request
  /// Sends a GET request to the API to retrieve information about the payment specified
  /// by the reference property of the Payment object. If the request is successful,
  /// it returns the response body as a string. Otherwise, it returns the response's reason phrase.

  PaymentEnquiryProvider call({required Payment payment}) =>
      PaymentEnquiryProvider._(argument: payment, from: this);

  @override
  String toString() => r'paymentEnquiryProvider';
}
