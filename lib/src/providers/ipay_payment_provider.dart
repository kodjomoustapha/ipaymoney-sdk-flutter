import 'dart:convert';
import 'package:ipay_money_flutter_sdk/src/models/payment.dart';
import 'package:ipay_money_flutter_sdk/src/models/state_response_ipay.dart';
import 'package:ipay_money_flutter_sdk/src/utils/utils.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
part 'ipay_payment_provider.g.dart';

/// Define a FutureProvider that can be used to make a direct payment
/// Sends a POST request to the API to initiate a payment. The request body contains
/// information about the payment, such as the amount, the customer's name, and the payment method.
/// If the request is successful, it returns the response body as a string.
/// Otherwise, it returns the response's reason phrase.
@riverpod
Future<dynamic> ipayPayment(
  IpayPaymentRef ref, {
  required Payment? payment,
}) async {
  var random = randomNumeric(10);
  var headers = {
    'Ipay-Target-Environment':
        convertEnumToString(payment!.targetEnvironment!).toString(),
    'Ipay-Payment-Type': convertEnumToString(payment.paymentType!).toString(),
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${payment.authorization}',
  };
  var request = http.Request(
      'POST',
      Uri.parse(payment.paymentType == PaymentType.card
          ? 'https://i-pay.money/api/v1/payments/bank_card_payment'
          : 'https://i-pay.money/api/v1/payments'));
  request.body = payment.paymentType == PaymentType.card
      ? json.encode({
          "customer_name": payment.name,
          "currency": "XOF",
          "country":
              convertEnumToString(payment.country!).toString().toUpperCase(),
          "amount": payment.amount,
          "transaction_id": "random-$random",
          "msisdn": payment.country == Country.ne
              ? '227${payment.msisdn}'
              : '225${payment.msisdn}',
          "payment_option": "card",
          "pan": payment.pan,
          "exp": payment.exp,
          "cvv": payment.cvv
        })
      : json.encode({
          "customer_name": payment.name,
          "currency": "XOF",
          "country":
              convertEnumToString(payment.country!).toString().toUpperCase(),
          "amount": payment.amount,
          "transaction_id": "random-$random",
          "msisdn": payment.targetEnvironment == TargetEnvironment.live
              ? payment.country == Country.ne
                  ? '227${payment.msisdn}'
                  : '225${payment.msisdn}'
              : payment.msisdn
        });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var res = await response.stream.bytesToString();
    return res;
  } else {
    return response.reasonPhrase;
  }
}

/// Define a FutureProvider that can be used to make a Visa or MasterCard payment
/// Sends a POST request to the API to send_device_information . If the request
/// is successful, it returns the response body as a [StateResponseIpay]. Otherwise, it returns
/// the response's reason phrase.
@riverpod
Future<dynamic> ipayVisaMasterCardPayment(IpayVisaMasterCardPaymentRef ref,
    {required String authorization,
    required String orderReference,
    required String reference,
    required String paymentReference}) async {
  var headers = {
    'Ipay-Target-Environment': 'live',
    'Ipay-Payment-Type': 'card',
    'Authorization': 'Bearer $authorization',
    'Content-Type': 'application/json',
  };
  var request = http.Request('POST',
      Uri.parse('https://i-pay.money/api/v1/payments/send_device_information'));
  request.body = json.encode({
    "reference": reference,
    "order_reference": orderReference,
    "payment_reference": paymentReference
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var statusOk = jsonDecode(await response.stream.bytesToString())
        as Map<String, dynamic>;
    var stateResponse = StateResponseIpay.fromJson(statusOk);
    return stateResponse;
  } else {
    return response.reasonPhrase;
  }
}

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
@riverpod
Future<dynamic> paymentEnquiry(
  PaymentEnquiryRef ref, {
  required Payment payment,
}) async {
  var headers = {
    'Ipay-Payment-Type': convertEnumToString(payment.paymentType).toString(),
    'Ipay-Target-Environment':
        convertEnumToString(payment.targetEnvironment).toString(),
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${payment.authorization}',
  };
  var request = http.Request('GET',
      Uri.parse('https://i-pay.money/api/v1/payments/${payment.reference}'));
  request.body = json.encode({"reference": payment.reference});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    return response.reasonPhrase;
  }
}
