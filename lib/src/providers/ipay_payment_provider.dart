import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ipay_money_flutter_sdk/src/models/payment.dart';
import 'package:ipay_money_flutter_sdk/src/services/ipay_services.dart';

// Define a FutureProvider that can be used to make a direct payment
final ipayPaymentProvider =
    FutureProvider.family.autoDispose<dynamic, Payment>((ref, payment) async {
  // Call the directPayment method on the iPayServices provider and return the result
  return ref.watch(iPayServices).directPayment(payment: payment);
});

// Define a FutureProvider that can be used to make a Visa or MasterCard payment
final ipayVisaMasterCardPaymentProvider =
    FutureProvider.family.autoDispose<dynamic, String>((ref, payment) async {
  // Convert the payment string into a JSON object
  var data = jsonDecode(payment);

  // Call the visaMasterCardRequest method on the iPayServices provider and return the result
  return ref.watch(iPayServices).visaMasterCardRequest(
      authorization: data['authorization'],
      orderReference: data['order_reference'],
      paymentReference: data['payment_reference'],
      reference: data['reference']);
});
