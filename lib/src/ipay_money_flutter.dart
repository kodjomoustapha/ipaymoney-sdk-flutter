// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
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
  String referencePrefix;

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
      this.referencePrefix = 'ipay'});

  Future<void> ipayPayment(
      {required BuildContext context,
      required void Function(String) callback}) async {
    final payment = Payment(
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
        referencePrefix: referencePrefix
            .replaceAll(' ', '')
            .replaceAll(RegExp(r'[^a-zA-Z0-9 .()\-\s]'), '-'));
    await showModalBottomSheet(
        enableDrag: false,
        elevation: 5,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => ProviderScope(
              child: Consumer(builder: (context, ref, child) {
                final startPayment =
                    ref.watch(ipayPaymentProvider(payment: payment));

                return startPayment.when(
                  data: (value) {
                    var val = jsonDecode(value);
                    if (payment.paymentType == PaymentType.card) {
                      if (val['state'] == 'AWAIT_3DS') {
                        final cardPayment = ref.watch(
                            ipayVisaMasterCardPaymentProvider(
                                authorization: payment.authorization!,
                                orderReference: val['order_reference'],
                                reference: val['reference'],
                                paymentReference: val['payment_reference']));

                        cardPayment.when(
                            data: (url) {
                              return IpayVisaMasterCard(
                                payment: payment,
                                reference: val['reference'],
                                publicReference: val['public_reference'],
                                url: url,
                                callback: callback,
                              );
                            },
                            error: (error, stackTrace) {
                              return _noConnectionWidgetPlus(context, () {
                                ref.invalidate(
                                    ipayVisaMasterCardPaymentProvider);
                              });
                            },
                            loading: () => const Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.green,
                                  )),
                                ));
                      } else {
                        Navigator.pop(context);
                      }
                    }
                    return IpayConsumer(
                      callback: callback,
                      payment: payment,
                      reference: val['reference'],
                      publicReference: val['public_reference'],
                    );
                  },
                  error: (error, stackTrace) {
                    return _noConnectionWidgetPlus(context, () {
                      ref.invalidate(ipayPaymentProvider);
                    });
                  },
                  loading: () => const Column(
                    children: [
                      CircularProgressIndicator(color: Colors.green),
                    ],
                  ),
                );
              }),
            ));
  }
}

class IpayConsumer extends ConsumerStatefulWidget {
  final String reference;
  final Payment payment;
  final String publicReference;
  final void Function(String) callback;
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

  Future<void> _init() async {
    final status = await _checkStatus(_payment, ref, context);
    if (mounted) {
      setState(() {
        _transactionStatus = status!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_transactionStatus == TransactionStatus.succeeded) {
      Timer.periodic(const Duration(seconds: 2), (timerPop) {
        if (timerPop.tick == 2) {
          timerPop.cancel();
          if (mounted) {
            widget.callback(json.encode({
              "status": "success",
              "reference": widget.reference,
              "public_reference": widget.publicReference,
            }));
            Navigator.pop(context);
          }
        }
      });
    }

    return WillPopScope(
      onWillPop: () async {
        if (mounted) {
          widget.callback(json.encode({
            "status": "failed",
          }));
          Navigator.pop(context);
        }
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red,
                                size: 50,
                              ),
                            )
                          ],
                        )
                      : _transactionStatus == TransactionStatus.connectionError
                          ? _noConnectionWidget()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Transaction en cours....",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
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
              const SizedBox(height: 20),
              _transactionStatus == TransactionStatus.succeeded
                  ? const Icon(
                      Icons.check_circle_outlined,
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
                              widget.callback(json.encode({
                                "status": "failed",
                              }));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Retour',
                            style: TextStyle(color: Colors.white),
                          ))
                      : _transactionStatus == TransactionStatus.connectionError
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  _transactionStatus =
                                      TransactionStatus.pending;
                                });
                                _init();
                              },
                              child: const Text('Réessayer',
                                  style: TextStyle(color: Colors.white)))
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
  final void Function(String) callback;
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
                widget.callback(json.encode({
                  "status": "success",
                  "reference": widget.reference,
                  "public_reference": widget.publicReference,
                }));
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

Future<TransactionStatus?> _checkStatus(
    Payment payment, WidgetRef ref, BuildContext context) async {
  TransactionStatus? status;
  int timer = 0;
  await Future.delayed(const Duration(milliseconds: 100));
  await Future.doWhile(() async {
    if (!context.mounted) return false;
    await Future.delayed(const Duration(milliseconds: 800));
    timer++;
    if (kDebugMode) {
      logger('_checkStatus timer : $timer');
    }
    try {
      final result =
          await ref.read(paymentEnquiryProvider(payment: payment).future);

      final value = jsonDecode(result);

      if (kDebugMode) {
        logger('_checkStatus status : ${value['status']}');
      }
      status = getTransactionStatusEnum(value['status']!.toLowerCase());

      if (status != TransactionStatus.pending) {
        return false;
      } else if (timer == payment.timeOut) {
        status = TransactionStatus.failed;
        return false;
      }
    } catch (_) {
      status = TransactionStatus.connectionError;
      return false;
    }
    return true;
  });
  return status;
}

Widget _noConnectionWidget() {
  return const Column(
    children: [
      Text(
        'Connexion internet non disponible ou instable veuillez réessayer.',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.signal_cellular_connected_no_internet_4_bar,
            color: Colors.red, size: 50),
      )
    ],
  );
}

Widget _noConnectionWidgetPlus(
    BuildContext context, void Function()? onPressed) {
  return Scaffold(
      body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _noConnectionWidget(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: onPressed,
                child: const Text('Réessayer',
                    style: TextStyle(color: Colors.white))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Retour',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      )
    ],
  ));
}
