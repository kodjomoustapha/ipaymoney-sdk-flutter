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
  Ref ref, {
  required Payment? payment,
}) async {
  var headers = {
    'Ipay-Target-Environment': convertEnumToString(payment!.targetEnvironment!),
    'Ipay-Payment-Type': ipayPaymentType(payment.paymentType!),
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
    "transaction_id": payment.transactionId ??
        "${payment.referencePrefix}-${randomAlphaNumeric(20)}",
    "msisdn": payment.country == Country.ne
        ? '227${payment.msisdn}'
        : '225${payment.msisdn}',
    if (payment.paymentType == PaymentType.boa) ...{"payment_option": "sta"},
    if (payment.paymentType == PaymentType.card) ...{
      "payment_option": "card",
      "pan": payment.pan,
      "exp": payment.exp,
      "cvv": payment.cvv
    },
    if (payment.paymentType == PaymentType.myNita)
      "payment_option": "nita_online",
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  final res = await response.stream.bytesToString();
  if (response.statusCode == 200) {
    logger("ipayPayment(statusCode == 200) : $res");
    return res;
  } else {
    logger("ipayPayment(statusCode : ${response.statusCode}) :  $res");
    throw ArgumentError(jsonDecode(res)["message"], response.reasonPhrase!);
  }
}

@riverpod
Future<String> ipayVisaMasterCardPayment(Ref ref,
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
  var res = await response.stream.bytesToString();
  if (response.statusCode == 200) {
    final resJson = jsonDecode(res) as Map<String, dynamic>;
    final url =
        '${resJson['term_url_get']}?acs_url=${resJson['acs_url']}&base64_encoded_cqeq=${resJson['base64_encoded_cqeq']}&challenge_notification_url=${resJson['notification_url']}';
    logger("ipayVisaMasterCardPayment(statusCode == 200) : $url");
    return url;
  } else {
    logger(
        "ipayVisaMasterCardPayment(statusCode : ${response.statusCode}) : $res");
    throw ArgumentError(jsonDecode(res)["message"], response.reasonPhrase!);
  }
}

/// Define a FutureProvider that can be used for paymentEnquiry request
/// Sends a GET request to the API to retrieve information about the payment specified
/// by the reference property of the Payment object. If the request is successful,
/// it returns the response body as a string. Otherwise, it returns the response's reason phrase.
@riverpod
Future<String> paymentEnquiry(
  Ref ref, {
  required Payment payment,
}) async {
  var headers = {
    'Ipay-Payment-Type': ipayPaymentType(payment.paymentType!),
    'Ipay-Target-Environment': convertEnumToString(payment.targetEnvironment),
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${payment.authorization}',
  };
  var request = http.Request(
      'GET', Uri.parse('$_apiBaseUrl/payments/${payment.reference}'));
  request.body = json.encode({"reference": payment.reference});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  final res = await response.stream.bytesToString();
  if (response.statusCode == 200) {
    logger("paymentEnquiry(statusCode == 200) : $res");
    return res;
  } else {
    logger("paymentEnquiry(statusCode : ${response.statusCode}) : $res");
    throw ArgumentError(jsonDecode(res)["message"], response.reasonPhrase!);
  }
}

String ipayPaymentType(PaymentType paymentType) {
  switch (paymentType) {
    case PaymentType.boa:
      return "sta";
    case PaymentType.myNita:
      return "nita_online";
    default:
      return convertEnumToString(paymentType);
  }
}

const _apiBaseUrl = 'https://i-pay.money/api/v1';
