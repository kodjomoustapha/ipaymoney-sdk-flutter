import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ipay_money_flutter_sdk/src/models/payment.dart';
import 'package:ipay_money_flutter_sdk/src/providers/ipay_payment_provider.dart';
import 'package:ipay_money_flutter_sdk/src/utils/utils.dart';
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

  ///The reference sufix that let you track the type of the transaction.
  String? referencePrefix;

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
      this.pan = '',
      this.referencePrefix});

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
        timeOut: timeOut,
        referencePrefix: referencePrefix!.replaceAll(" ", ""));
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
                            .watch(ipayVisaMasterCardPaymentProvider(
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
  late final Payment _payment = Payment(
      timeOut: widget.payment.timeOut,
      targetEnvironment: widget.payment.targetEnvironment,
      paymentType: widget.payment.paymentType,
      authorization: widget.payment.authorization,
      reference: widget.reference);
  late TransactionStatus _transactionStatus = TransactionStatus.pending;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    final status = await _checkStatus(_payment, ref);
    if (mounted) {
      setState(() {
        _transactionStatus = status!;
      });
    }
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

    if (_transactionStatus == TransactionStatus.succeeded) {
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
              _transactionStatus == TransactionStatus.succeeded
                  ? const Text('Paiement effectuer avec succès',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      textAlign: TextAlign.center)
                  : _transactionStatus == TransactionStatus.failed
                      ? const Column(
                          children: [
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
                            if (_payment.paymentType == PaymentType.mobile)
                              const Column(
                                children: [
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
                            if (_payment.paymentType == PaymentType.alizza)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    'Veuillez vous rendre dans un centre AL IZZA et fournir ce code:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                    textAlign: TextAlign.center),
                              ),
                            if (_payment.paymentType == PaymentType.alizza)
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
              _transactionStatus == TransactionStatus.succeeded
                  ? const Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                      size: 30,
                    )
                  : _transactionStatus == TransactionStatus.failed
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
  late WebViewController _controller;

  @override
  void initState() {
    var encode = json.encode({
      "status": "success",
      "reference": widget.reference,
      "public_reference": widget.publicReference,
    });
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (data) async {
            if (data.startsWith(
                'https://i-pay.money/api/sdk/v1/emv_challenges?reference=${widget.reference}')) {
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
          controller: _controller,
        ),
      ),
    );
  }
}

Future<TransactionStatus?> _checkStatus(Payment payment, WidgetRef ref) async {
  TransactionStatus? status;
  int timer = 0;
  await Future.delayed(const Duration(milliseconds: 100));
  await Future.doWhile(() async {
    await Future.delayed(const Duration(seconds: 1));
    timer++;
    if (kDebugMode) {
      log('$timer');
    }
    try {
      final result = await ref
          .read(paymentEnquiryProvider(payment: payment).future)
          .onError((error, stackTrace) {
        status = TransactionStatus.failed;
      });

      final value = jsonDecode(result);

      if (kDebugMode) {
        log(value['status']);
      }
      status = getTransactionStatusEnum(value['status']!.toLowerCase());

      if (status != TransactionStatus.pending) {
        return false;
      } else if (timer == payment.timeOut) {
        status = TransactionStatus.failed;
        return false;
      }
    } catch (_) {
      status = TransactionStatus.failed;
      return false;
    }
    return true;
  });
  return status;
}
