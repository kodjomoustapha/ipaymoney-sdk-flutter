// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry_timeout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enquiryTimeoutHash() => r'dbe3e3bc205115411767457b75321e2776daec1f';

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

typedef EnquiryTimeoutRef = AutoDisposeFutureProviderRef<bool>;

/// Define a FutureProvider for checking the status of a payment with a given timeout
///
/// Copied from [enquiryTimeout].
@ProviderFor(enquiryTimeout)
const enquiryTimeoutProvider = EnquiryTimeoutFamily();

/// Define a FutureProvider for checking the status of a payment with a given timeout
///
/// Copied from [enquiryTimeout].
class EnquiryTimeoutFamily extends Family<AsyncValue<bool>> {
  /// Define a FutureProvider for checking the status of a payment with a given timeout
  ///
  /// Copied from [enquiryTimeout].
  const EnquiryTimeoutFamily();

  /// Define a FutureProvider for checking the status of a payment with a given timeout
  ///
  /// Copied from [enquiryTimeout].
  EnquiryTimeoutProvider call(
    Payment payment,
  ) {
    return EnquiryTimeoutProvider(
      payment,
    );
  }

  @override
  EnquiryTimeoutProvider getProviderOverride(
    covariant EnquiryTimeoutProvider provider,
  ) {
    return call(
      provider.payment,
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
  String? get name => r'enquiryTimeoutProvider';
}

/// Define a FutureProvider for checking the status of a payment with a given timeout
///
/// Copied from [enquiryTimeout].
class EnquiryTimeoutProvider extends AutoDisposeFutureProvider<bool> {
  /// Define a FutureProvider for checking the status of a payment with a given timeout
  ///
  /// Copied from [enquiryTimeout].
  EnquiryTimeoutProvider(
    this.payment,
  ) : super.internal(
          (ref) => enquiryTimeout(
            ref,
            payment,
          ),
          from: enquiryTimeoutProvider,
          name: r'enquiryTimeoutProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$enquiryTimeoutHash,
          dependencies: EnquiryTimeoutFamily._dependencies,
          allTransitiveDependencies:
              EnquiryTimeoutFamily._allTransitiveDependencies,
        );

  final Payment payment;

  @override
  bool operator ==(Object other) {
    return other is EnquiryTimeoutProvider && other.payment == payment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, payment.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
