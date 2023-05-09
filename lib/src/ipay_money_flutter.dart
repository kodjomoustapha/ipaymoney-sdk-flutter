import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ipay_money_flutter_sdk/src/models/payment.dart';
import 'package:ipay_money_flutter_sdk/src/providers/enquiry_timeout_provider.dart';
import 'package:ipay_money_flutter_sdk/src/providers/ipay_payment_provider.dart';
import 'package:ipay_money_flutter_sdk/src/providers/state_providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IpayPayments {
  /// the amount of the payment
  String amount;

  /// the authorization token for the payment
  String authorization;

  /// the country where the payment is being made
  Country country;

  /// the currency of the payment
  String currency;

  /// the msisdn (mobile phone number) of the payer
  String msisdn;

  /// the name of the payer
  String name;

  /// the timeout for the payment enquiry
  int timeOut;

  /// the target environment (live or sandbox) for the payment
  TargetEnvironment targetEnvironment;

  /// the type of payment (card , alIzza or mobile money)
  PaymentType paymentType;

  /// the card CVV for a card payment
  String cvv;

  /// the card expiration date for a card payment
  String exp;

  /// the card number for a card payment
  String pan;

  IpayPayments(
      {required this.amount,
      required this.authorization,
      required this.msisdn,
      required this.name,
      required this.paymentType,
      required this.country,
      required this.currency,
      required this.targetEnvironment,
      this.timeOut = 5,
      this.cvv = '',
      this.exp = '',
      this.pan = ''});

  ipayPayment(
      {required BuildContext context,
      required Function(String) callback}) async {
    Payment payment = Payment(
        cvv: cvv,
        pan: pan,
        exp: exp,
        amount: amount,
        authorization: authorization,
        country: country,
        currency: currency,
        msisdn: msisdn,
        name: name,
        targetEnvironment: targetEnvironment,
        paymentType: paymentType,
        timeOut: timeOut);
    showDialog(
        context: context,
        builder: (_) => ProviderScope(
              child: Consumer(builder: (context, ref, child) {
                final startPayment =
                    ref.watch(ipayPaymentProvider(payment: payment).future);
                startPayment.then((value) {
                  if (value != null) {
                    var val = jsonDecode(value);
                    if (payment.paymentType == PaymentType.card) {
                      if (val['state'] == 'AWAIT_3DS') {
                        ref
                            .watch(IpayVisaMasterCardPaymentProvider(
                                    authorization: payment.authorization!,
                                    orderReference: val['order_reference'],
                                    reference: val['reference'],
                                    paymentReference: val['payment_reference'])
                                .future)
                            .then((value) {
                          Navigator.pop(context);
                          var url =
                              '${value.termUrlGet}?acs_url=${value.acsUrl}&base64_encoded_cqeq=${value.base64EncodedCqeq}&challenge_notification_url=${value.notificationUrl}';
                          showDialog(
                              context: context,
                              builder: (_) => ProviderScope(
                                    child: IpayVisaMasterCard(
                                      payment: payment,
                                      reference: val['reference'],
                                      publicReference: val['public_reference'],
                                      url: url,
                                      callback: callback,
                                    ),
                                  ));
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      if (val['status'] == 'succeeded') {
                        Navigator.pop(context);
                        showModalBottomSheet(
                            enableDrag: false,
                            elevation: 5,
                            isDismissible: false,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return ProviderScope(
                                  child: IpayConsumer(
                                callback: callback,
                                payment: payment,
                                reference: val['reference'],
                                publicReference: val['public_reference'],
                              ));
                            });
                      }
                    }
                  } else {
                    Navigator.pop(context);
                  }
                });
                return const Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  )),
                );
              }),
            ));
  }
}

class IpayConsumer extends ConsumerStatefulWidget {
  final String reference;
  final Payment payment;
  final String publicReference;
  final Function(String) callback;
  const IpayConsumer(
      {required this.payment,
      required this.publicReference,
      required this.reference,
      required this.callback,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IpayConsumerState();
}

class _IpayConsumerState extends ConsumerState<IpayConsumer> {
  late Payment payment = Payment(
      timeOut: widget.payment.timeOut,
      targetEnvironment: widget.payment.targetEnvironment,
      paymentType: widget.payment.paymentType,
      authorization: widget.payment.authorization,
      reference: widget.reference);
  @override
  void initState() {
    ref.read(enquiryTimeoutProvider(payment));
    super.initState();
  }

  var encode = json.encode({
    "status": "failed",
  });
  @override
  Widget build(BuildContext context) {
    var encodeS = json.encode({
      "status": "success",
      "reference": widget.reference,
      "public_reference": widget.publicReference,
    });

    final isSucces = ref.watch(succesStateProviders);
    final isFailed = ref.watch(failedStateProviders);
    if (isSucces == true) {
      Timer.periodic(const Duration(seconds: 2), (timerPop) {
        if (timerPop.tick == 2) {
          timerPop.cancel();
          if (mounted) {
            widget.callback(encodeS);
            Navigator.pop(context);
          }
        }
      });
    }

    return WillPopScope(
      onWillPop: () async {
        if (mounted) {
          widget.callback(encode);
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSucces == true
                  ? const Text('Paiement effectuer avec succès',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      textAlign: TextAlign.center)
                  : isFailed == true
                      ? Column(
                          children: const [
                            Text(
                              'La transaction a échouée.\nVeuillez reprendre le paiement',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                              size: 50,
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Transaction en cours....",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22),
                                textAlign: TextAlign.center),
                            if (payment.paymentType == PaymentType.mobile)
                              Column(
                                children: const [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      'Veuillez valider le push que vous avez reçu sur votre téléphone...',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (payment.paymentType == PaymentType.alizza)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    'Veuillez vous rendre dans un centre AL IZZA et fournir ce code:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                    textAlign: TextAlign.center),
                              ),
                            if (payment.paymentType == PaymentType.alizza)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.publicReference,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                    textAlign: TextAlign.center),
                              ),
                          ],
                        ),
              const SizedBox(
                height: 20,
              ),
              isSucces == true
                  ? const Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                      size: 30,
                    )
                  : isFailed == true
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            if (mounted) {
                              widget.callback(encode);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Retour'))
                      : const CircularProgressIndicator(
                          color: Colors.green,
                        )
            ],
          ),
        ),
      ),
    );
  }
}

class IpayVisaMasterCard extends StatefulWidget {
  final String url;
  final String reference;
  final Payment payment;
  final String publicReference;
  final Function(String) callback;
  const IpayVisaMasterCard({
    required this.callback,
    super.key,
    required this.reference,
    required this.payment,
    required this.publicReference,
    required this.url,
  });

  @override
  State<StatefulWidget> createState() => _IpayVisaMasterCardState();
}

class _IpayVisaMasterCardState extends State<IpayVisaMasterCard> {
  late WebViewController controller;

  @override
  void initState() {
    var encode = json.encode({
      "status": "success",
      "reference": widget.reference,
      "public_reference": widget.publicReference,
    });
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (data) async {
            if (data.startsWith(
                'https://i-pay.money/api/sdk/v1/emv_challenges/success')) {
              await Future.delayed(const Duration(seconds: 3));

              if (mounted) {
                widget.callback(encode);
                Navigator.pop(context);
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
