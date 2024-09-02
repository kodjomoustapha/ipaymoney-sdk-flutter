import 'dart:convert';
import 'package:ipay_money_flutter_sdk/src/models/payment.dart';
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
Future<String> ipayPayment(
  IpayPaymentRef ref, {
  required Payment? payment,
}) async {
  var random = randomAlphaNumeric(20);
  var headers = {
    'Ipay-Target-Environment': convertEnumToString(payment!.targetEnvironment!),
    'Ipay-Payment-Type': convertEnumToString(payment.paymentType!),
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${payment.authorization}',
  };
  var request = http.Request(
      'POST',
      Uri.parse(payment.paymentType == PaymentType.card
          ? '$_apiBaseUrl/payments/bank_card_payment'
          : '$_apiBaseUrl/payments'));
  request.body = json.encode({
    "customer_name": payment.name,
    "currency": "XOF",
    "country": convertEnumToString(payment.country!).toUpperCase(),
    "amount": payment.amount,
    "transaction_id": "${payment.referencePrefix}-$random",
    "msisdn": payment.country == Country.ne
        ? '227${payment.msisdn}'
        : '225${payment.msisdn}',
    if (payment.paymentType == PaymentType.card) ...{
      "payment_option": "card",
      "pan": payment.pan,
      "exp": payment.exp,
      "cvv": payment.cvv
    }
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final res = await response.stream.bytesToString();
    logger("ipayPayment(statusCode == 200) : $res");
    return res;
  } else {
    final reason = response.reasonPhrase;
    logger("ipayPayment(statusCode != 200) : $reason");
    throw reason!;
  }
}

@riverpod
Future<String> ipayVisaMasterCardPayment(IpayVisaMasterCardPaymentRef ref,
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
  var request = http.Request(
      'POST', Uri.parse('$_apiBaseUrl/payments/send_device_information'));
  request.body = json.encode({
    "reference": reference,
    "order_reference": orderReference,
    "payment_reference": paymentReference
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var res = jsonDecode(await response.stream.bytesToString())
        as Map<String, dynamic>;
    final url =
        '${res['term_url_get']}?acs_url=${res['acs_url']}&base64_encoded_cqeq=${res['base64_encoded_cqeq']}&challenge_notification_url=${res['notification_url']}';
    logger("ipayVisaMasterCardPayment(statusCode == 200) : $url");
    return url;
  } else {
    final reason = response.reasonPhrase;
    logger("ipayVisaMasterCardPayment(statusCode != 200) : $reason");
    throw reason!;
  }
}

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
@riverpod
Future<String> paymentEnquiry(
  PaymentEnquiryRef ref, {
  required Payment payment,
}) async {
  var headers = {
    'Ipay-Payment-Type': convertEnumToString(payment.paymentType),
    'Ipay-Target-Environment': convertEnumToString(payment.targetEnvironment),
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${payment.authorization}',
  };
  var request = http.Request(
      'GET', Uri.parse('$_apiBaseUrl/payments/${payment.reference}'));
  request.body = json.encode({"reference": payment.reference});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final res = await response.stream.bytesToString();
    logger("paymentEnquiry(statusCode == 200) : $res");
    return res;
  } else {
    final reason = response.reasonPhrase;
    logger("paymentEnquiry(statusCode != 200) : $reason");
    throw reason!;
  }
}

const _apiBaseUrl = 'https://i-pay.money/api/v1';
