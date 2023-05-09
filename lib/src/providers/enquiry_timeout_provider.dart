import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:ipay_money_flutter_sdk/src/models/payment.dart';
import 'package:ipay_money_flutter_sdk/src/providers/ipay_payment_provider.dart';
import 'package:ipay_money_flutter_sdk/src/providers/state_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'enquiry_timeout_provider.g.dart';

/// Define a FutureProvider for checking the status of a payment with a given timeout
@riverpod
Future<bool> enquiryTimeout(EnquiryTimeoutRef ref, Payment payment) async {
  // The provider function that will be run when the provider is called
  int timer = 0;
  await Future.doWhile(() async {
    timer++;
    if (kDebugMode) {
      log('$timer');
    }

    try {
      // Use the iPayServices provider to make a paymentEnquiry request
      final result = await ref
          .read(paymentEnquiryProvider(payment: payment).future)
          .onError((error, stackTrace) {
        ref.read(failedStateProviders.notifier).update((state) => state = true);
      });
      // Convert the response to a Map using jsonDecode
      final value = jsonDecode(result);
      // Print the status if kDebugMode is true
      if (kDebugMode) {
        log(value['status']);
      }
      // If the status is 'failed', update the failedStateProviders notifier to true
      if (value['status'] == 'failed') {
        ref.read(failedStateProviders.notifier).update((state) => state = true);
        // Cancel the timer
        return false;
      } else if (value['status'] == 'succeeded') {
        // If the status is 'succeeded', update the succesStateProviders notifier to true
        ref.read(succesStateProviders.notifier).update((state) => state = true);
        // Cancel the timer
        return false;
      } else if (timer == payment.timeOut) {
        // If the timeout is reached, update the failedStateProviders notifier to true
        ref.read(failedStateProviders.notifier).update((state) => state = true);
        // Cancel the timer
        return false;
      }
    } catch (_) {
      // If an error occurs, cancel the timer
      ref.read(failedStateProviders.notifier).update((state) => state = true);
      return false;
    }
    return true;
  });
  return false;
}
