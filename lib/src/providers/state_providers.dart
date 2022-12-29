import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a StateProvider for the success state
final succesStateProviders = StateProvider.autoDispose<bool?>((ref) {
  // The initial value is false
  return false;
});

// Define a StateProvider for the failed state
final failedStateProviders = StateProvider.autoDispose<bool?>((ref) {
  // The initial value is false
  return false;
});

// Define a StateProvider for the cancel state
final cancelStateProviders = StateProvider.autoDispose<bool?>((ref) {
  // The initial value is false
  return false;
});
