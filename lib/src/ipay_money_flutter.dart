// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
import 'package:ipay_money_flutter_sdk/src/providers/ipay_payment_provider.dart';
import 'package:ipay_money_flutter_sdk/src/utils/formaters.dart';
import 'package:ipay_money_flutter_sdk/src/utils/utils.dart';
import 'package:ipay_money_flutter_sdk/src/utils/validators.dart';
import 'package:ipay_money_flutter_sdk/src/widgets/payment_option_widget.dart';
import 'package:ipay_money_flutter_sdk/src/widgets/payment_type_info_widget.dart';
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

  String? transationId;

  String? paymentSucceededMsg;

  String? paymentFailedMsg;

  IpayPayments(
      {required this.amount,
      required this.authorization,
      required this.msisdn,
      required this.name,
      required this.paymentType,
      required this.country,
      required this.currency,
      required this.targetEnvironment,
      this.timeOut = 60,
      this.cvv = '',
      this.exp = '',
      this.pan = '',
      this.referencePrefix = 'ipay',
      this.transationId,
      this.paymentSucceededMsg,
      this.paymentFailedMsg});

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
            .replaceAll(RegExp(r'[^a-zA-Z0-9 .()\-\s]'), '-'),
        transactionId: transationId);
    final isCardPayment = payment.paymentType == PaymentType.card;
    final paymentWidget = ProviderScope(
      child: Consumer(builder: (context, ref, child) {
        final startPayment = ref.watch(ipayPaymentProvider(payment: payment));

        return startPayment.when(
          data: (value) {
            var val = jsonDecode(value);
            if (isCardPayment) {
              if (val['state'] == 'AWAIT_3DS') {
                final cardPayment = ref.watch(ipayVisaMasterCardPaymentProvider(
                    authorization: payment.authorization!,
                    orderReference: val['order_reference'],
                    reference: val['reference'],
                    paymentReference: val['payment_reference']));

                return cardPayment.when(
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
                      return _noConnectionWidgetPlus(context, error, () {
                        ref.invalidate(ipayVisaMasterCardPaymentProvider);
                      });
                    },
                    loading: () => const Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                              child: CircularProgressIndicator(
                            color: primaryColor,
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
              paymentSucceededMsg: paymentSucceededMsg,
              paymentFailedMsg: paymentFailedMsg,
            );
          },
          error: (error, stackTrace) {
            return _noConnectionWidgetPlus(context, error, () {
              ref.invalidate(ipayPaymentProvider);
            });
          },
          loading: () => Column(
            mainAxisAlignment: isCardPayment
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: const [
              CircularProgressIndicator(color: primaryColor),
            ],
          ),
        );
      }),
    );
    if (isCardPayment) {
      await showDialog(context: context, builder: (_) => paymentWidget);
    } else {
      await showModalBottomSheet(
          enableDrag: false,
          elevation: 5,
          isDismissible: false,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) => paymentWidget);
    }
  }
}

class IpayConsumer extends ConsumerStatefulWidget {
  final String reference;
  final Payment payment;
  final String publicReference;
  final String? paymentSucceededMsg;
  final String? paymentFailedMsg;
  final void Function(String) callback;
  const IpayConsumer(
      {required this.payment,
      required this.publicReference,
      required this.reference,
      required this.callback,
      required this.paymentSucceededMsg,
      required this.paymentFailedMsg,
      super.key});

  @override
  ConsumerState<IpayConsumer> createState() => _IpayConsumerState();
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
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _transactionStatus == TransactionStatus.succeeded
                        ? Text(
                            widget.paymentSucceededMsg ??
                                'Paiement effectuer avec succès',
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            textAlign: TextAlign.center)
                        : _transactionStatus == TransactionStatus.failed
                            ? Column(
                                children: [
                                  Text(
                                    widget.paymentFailedMsg ??
                                        'La transaction a échouée.\nVeuillez reprendre le paiement',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.warning_amber_rounded,
                                        color: Colors.red, size: 70),
                                  )
                                ],
                              )
                            : _transactionStatus ==
                                    TransactionStatus.connectionError
                                ? _noConnectionWidget()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Transaction en cours....",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22),
                                          textAlign: TextAlign.center),
                                      if (_payment.paymentType ==
                                          PaymentType.amanata)
                                        const Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                'Veuillez vous connectez sur votre Compte Amanata pour Valider la Transaction...',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 17),
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      if (_payment.paymentType ==
                                          PaymentType.mobile) ...[
                                        if (widget.payment.country ==
                                                Country.ne &&
                                            zamani2FirstNumbersList.any((e) =>
                                                widget.payment.msisdn!
                                                    .startsWith(e))) ...[
                                          const Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text.rich(
                                                  TextSpan(children: [
                                                    TextSpan(text: "Taper "),
                                                    TextSpan(
                                                      text: "#146# ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            "pour valider la transaction")
                                                  ]),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 17),
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        ] else ...[
                                          const Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                  'Veuillez valider le push que vous avez reçu sur votre téléphone...',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 17),
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ]
                                      ],
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      if (_payment.paymentType ==
                                          PaymentType.alizza)
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              'Veuillez vous rendre dans un centre AL IZZA pour fournir ce code:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 17),
                                              textAlign: TextAlign.center),
                                        ),
                                      if (_payment.paymentType ==
                                          PaymentType.boa)
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              'Veuillez vous rendre dans un centre BOA pour fournir ce code:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 17),
                                              textAlign: TextAlign.center),
                                        ),
                                      if (_payment.paymentType ==
                                              PaymentType.alizza ||
                                          _payment.paymentType ==
                                              PaymentType.boa)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.publicReference,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                              textAlign: TextAlign.center),
                                        ),
                                      Image.memory(base64Decode(phoneImgBase64),
                                          height: 110),
                                    ],
                                  ),
                    const SizedBox(height: 20),
                    _transactionStatus == TransactionStatus.succeeded
                        ? const Icon(
                            Icons.check_circle_outlined,
                            color: primaryColor,
                            size: 30,
                          )
                        : _transactionStatus == TransactionStatus.failed
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
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
                            : _transactionStatus ==
                                    TransactionStatus.connectionError
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
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
                                    color: primaryColor,
                                  ),
                  ],
                ),
              ),
              const IpayCertificationFlag()
            ],
          ),
        ),
      ),
    );
  }
}

class IpayVisaMasterCard extends ConsumerStatefulWidget {
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
  ConsumerState<IpayVisaMasterCard> createState() => _IpayVisaMasterCardState();
}

class _IpayVisaMasterCardState extends ConsumerState<IpayVisaMasterCard> {
  late WebViewController _controller;
  late final Payment _payment = Payment(
      timeOut: widget.payment.timeOut,
      targetEnvironment: widget.payment.targetEnvironment,
      paymentType: widget.payment.paymentType,
      authorization: widget.payment.authorization,
      reference: widget.reference);
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
              final status = await _checkStatus(_payment, ref, context);
              if (status == TransactionStatus.succeeded) {
                if (mounted) {
                  widget.callback(json.encode({
                    "status": "success",
                    "reference": widget.reference,
                    "public_reference": widget.publicReference,
                  }));
                  Navigator.pop(context);
                }
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
  int retry = 0;
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

      if (status != TransactionStatus.pending &&
          status != TransactionStatus.initiated) {
        return false;
      } else if (timer == payment.timeOut) {
        status = TransactionStatus.failed;
        return false;
      }
    } catch (_) {
      if (retry >= 3) {
        status = TransactionStatus.connectionError;
        return false;
      } else {
        retry++;
        return true;
      }
    }
    return true;
  });
  return status;
}

Widget _noConnectionWidget({String? message}) {
  return Column(
    children: [
      Text(
        message ??
            'Connexion internet non disponible ou instable veuillez réessayer.',
        style: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.signal_cellular_connected_no_internet_4_bar,
            color: Colors.red, size: 50),
      )
    ],
  );
}

Widget _noConnectionWidgetPlus(
    BuildContext context, Object error, void Function()? onPressed) {
  return Scaffold(
      body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (error is ArgumentError) ...[
        _noConnectionWidget(message: error.message.toString())
      ] else
        _noConnectionWidget(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
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

class IpayCertificationFlag extends StatelessWidget {
  const IpayCertificationFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Paiement sécurisé par", style: TextStyle(fontSize: 9)),
          const SizedBox(width: 10),
          Image.memory(base64Decode(ipayLogoBase64), height: 23),
          const SizedBox(width: 4),
          const Icon(Icons.lock, color: primaryColor, size: 15),
          Image.memory(base64Decode(pcidssLogoBase64), height: 23),
        ],
      ),
    );
  }
}

class IpayPaymentsWidget extends StatefulWidget {
  /// the amount of the payment if provided the amount textfield will disappear
  final String? amount;

  /// the authorization token for the payment
  final String authorization;

  /// the country where the payment is being made
  final Country country;

  /// the currency of the payment
  final String currency;

  /// the timeout for the payment enquiry
  final int timeOut;

  /// the target environment (live or sandbox) for the payment
  final TargetEnvironment targetEnvironment;

  ///The reference sufix that let you track the type of the transaction.
  final String referencePrefix;

  final String? transationId;

  final String? paymentSucceededMsg;

  final String? paymentFailedMsg;

  /// Callback function to handle payment status updates
  final void Function(String) callback;

  const IpayPaymentsWidget(
      {this.amount,
      required this.authorization,
      required this.country,
      required this.currency,
      required this.targetEnvironment,
      required this.callback,
      this.timeOut = 60,
      this.referencePrefix = 'ipay',
      this.transationId,
      this.paymentSucceededMsg,
      this.paymentFailedMsg,
      super.key});

  @override
  State<IpayPaymentsWidget> createState() => _IpayPaymentsWidgetState();
}

class _IpayPaymentsWidgetState extends State<IpayPaymentsWidget>
    with TickerProviderStateMixin {
  final _mycontrollerPhone = TextEditingController();
  final _mycontrollerAmount = TextEditingController();
  final _mycontrollerName = TextEditingController();
  final _mycontrollerCvv = TextEditingController();
  final _mycontrollerExp = TextEditingController();
  final _mycontrollerPan = TextEditingController();
  PaymentType _paymentType = PaymentType.mobile;
  String? _errorText;
  bool _isLoading = false;
  bool _showForm = false;

  final Map<String, String?> _fieldErrors = {};

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  List<Widget> _listWidget() {
    return [
      PaymentOptionWidget(
        assets: IpayAssets.mobileMoneyAssets,
        label: "Mobile Money",
        onTap: () => _selectPaymentType(PaymentType.mobile),
      ),
      PaymentOptionWidget(
        assets: IpayAssets.bankCardAssets,
        label: "Carte Bancaire",
        onTap: () => _selectPaymentType(PaymentType.card),
      ),
      PaymentOptionWidget(
        assets: IpayAssets.alizzaAssets,
        label: "AlIzza money",
        onTap: () => _selectPaymentType(PaymentType.alizza),
      ),
      PaymentOptionWidget(
        assets: IpayAssets.boaAssets,
        label: "Boa",
        onTap: () => _selectPaymentType(PaymentType.boa),
      ),
      PaymentOptionWidget(
        assets: IpayAssets.amanataAssets,
        label: "AmanaTa",
        onTap: () => _selectPaymentType(PaymentType.amanata),
      ),
      PaymentOptionWidget(
        assets: IpayAssets.mynitaAssets,
        label: "Paiement En Ligne Nita",
        onTap: () => _selectPaymentType(PaymentType.myNita),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mycontrollerPhone.dispose();
    _mycontrollerName.dispose();
    _mycontrollerCvv.dispose();
    _mycontrollerExp.dispose();
    _mycontrollerPan.dispose();
    super.dispose();
  }

  void _selectPaymentType(PaymentType type) {
    setState(() {
      _paymentType = type;
      _showForm = true;
      _clearValidationErrors();
    });
    _animationController.forward();
  }

  void _clearValidationErrors() {
    _fieldErrors.clear();
    _errorText = null;
  }

  void _validateField(String fieldName, String? value) {
    String? error;

    switch (fieldName) {
      case 'name':
        error = FormValidators.validateName(value);
        break;
      case 'amount':
        error = FormValidators.validateAmount(value);
        break;
      case 'phone':
        error = FormValidators.validatePhone(value);
        break;
      case 'cardNumber':
        error = FormValidators.validateCardNumber(value);
        break;
      case 'expiryDate':
        error = FormValidators.validateExpiryDate(value);
        break;
      case 'cvv':
        error = FormValidators.validateCVV(value);
        break;
    }

    setState(() {
      _fieldErrors[fieldName] = error;
    });
  }

  bool _validateAllFields() {
    bool isValid = true;

    _validateField('name', _mycontrollerName.text);
    if (_fieldErrors['name'] != null) isValid = false;

    _validateField('amount', _mycontrollerAmount.text);
    if (_fieldErrors['amount'] != null) isValid = false;

    _validateField('phone', _mycontrollerPhone.text);
    if (_fieldErrors['phone'] != null) isValid = false;

    if (_paymentType == PaymentType.card) {
      _validateField('cardNumber', _mycontrollerPan.text);
      if (_fieldErrors['cardNumber'] != null) isValid = false;

      _validateField('expiryDate', _mycontrollerExp.text);
      if (_fieldErrors['expiryDate'] != null) isValid = false;

      _validateField('cvv', _mycontrollerCvv.text);
      if (_fieldErrors['cvv'] != null) isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        if (!_showForm) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choisissez un mode de paiement',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                itemCount: _listWidget().length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.7,
                                  crossAxisSpacing: 15,
                                ),
                                itemBuilder: (context, index) {
                                  return _listWidget()[index];
                                },
                              ),
                            ],
                          )
                        ],
                        if (_showForm) ...[
                          const SizedBox(height: 20),
                          SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildPaymentFormSection(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const IpayCertificationFlag()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentFormSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _animationController.reverse().then((_) {
                setState(() {
                  _showForm = false;
                  _paymentType = PaymentType.mobile;
                  _clearForm();
                });
              });
            },
            child: const Row(
              children: [
                Icon(Icons.arrow_back, size: 20),
                SizedBox(width: 8),
                Text(
                  "Changer la methode de paiement",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PaymentTypeInfoWidget(paymentType: _paymentType),
          const SizedBox(height: 24),
          _customTextField(
            controller: _mycontrollerName,
            hintText: "Entrez votre nom complet",
            label: "Nom et Prénoms",
            keyboardType: TextInputType.name,
            fieldName: 'name',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]')),
            ],
          ),
          const SizedBox(height: 16),
          _customTextField(
            controller: _mycontrollerAmount,
            hintText: "Entrez le montant",
            label: "Montant",
            keyboardType: TextInputType.number,
            fieldName: 'amount',
            suffixText: "FCFA",
            inputFormatters: [AmountFormatter()],
          ),
          const SizedBox(height: 16),
          _customTextField(
            controller: _mycontrollerPhone,
            hintText: "XX XX XX XX",
            label: _paymentType == PaymentType.mobile
                ? "Compte Mobile Money"
                : _paymentType == PaymentType.amanata
                    ? "Compte Amanata"
                    : _paymentType == PaymentType.alizza
                        ? "Numéro AlIzza"
                        : _paymentType == PaymentType.boa
                            ? "Numéro BOA"
                            : "Numéro de téléphone",
            keyboardType: TextInputType.phone,
            fieldName: 'phone',
            maxLength: 11,
            inputFormatters: [PhoneNumberFormatter()],
          ),
          const SizedBox(height: 16),
          if (_paymentType == PaymentType.card) ...[
            _customTextField(
              controller: _mycontrollerPan,
              hintText: "0000 0000 0000 0000",
              label: "Numéro de la carte",
              keyboardType: TextInputType.number,
              fieldName: 'cardNumber',
              maxLength: 19,
              inputFormatters: [CardNumberFormatter()],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _customTextField(
                    controller: _mycontrollerExp,
                    hintText: "MM/AA",
                    label: "Expiration",
                    keyboardType: TextInputType.number,
                    fieldName: 'expiryDate',
                    maxLength: 5,
                    inputFormatters: [ExpiryDateFormatter()],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _customTextField(
                    controller: _mycontrollerCvv,
                    hintText: "123",
                    label: "CVV",
                    keyboardType: TextInputType.number,
                    fieldName: 'cvv',
                    maxLength: 3,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          if (_errorText != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hintText,
    required String label,
    required String fieldName,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    Widget? prefixWidget,
    String? suffixText,
  }) {
    final hasError = _fieldErrors[fieldName] != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: hasError ? Colors.red : Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: hasError
                    ? Colors.red.withValues(alpha: 0.5)
                    : Colors.grey.withValues(alpha: 0.2)),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            onChanged: (value) {
              setState(() => _errorText = null);
              _validateField(fieldName, value);
            },
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: prefixWidget,
              suffixText: suffixText,
              suffixStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              counterText: "",
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            _fieldErrors[fieldName]!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handlePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Payer ${_mycontrollerAmount.text.isEmpty ? "0" : _mycontrollerAmount.text} Francs FCFA',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _handlePayment() async {
    if (!_validateAllFields()) {
      setState(() {
        _errorText = "Veuillez corriger les erreurs dans le formulaire";
      });
      return;
    }

    final amount = _mycontrollerAmount.text.trim().replaceAll(' ', '');
    final name = _mycontrollerName.text.trim();
    final phone = _mycontrollerPhone.text.trim().replaceAll(' ', '');

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await IpayPayments(
              timeOut: widget.timeOut,
              amount: amount,
              authorization: widget.authorization,
              country: widget.country,
              currency: widget.currency,
              exp: _mycontrollerExp.text,
              pan: _mycontrollerPan.text.replaceAll(' ', ''),
              cvv: _mycontrollerCvv.text,
              msisdn: phone,
              name: name,
              targetEnvironment: widget.targetEnvironment,
              paymentType: _paymentType,
              referencePrefix: widget.referencePrefix,
              transationId: widget.transationId,
              paymentSucceededMsg: widget.paymentSucceededMsg,
              paymentFailedMsg: widget.paymentFailedMsg)
          .ipayPayment(
        context: context,
        callback: widget.callback,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorText = "Une erreur est survenue : ${e.toString()}";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearForm() {
    _mycontrollerPhone.clear();
    _mycontrollerName.clear();
    _mycontrollerCvv.clear();
    _mycontrollerExp.clear();
    _mycontrollerPan.clear();
    _mycontrollerAmount.clear();
    _clearValidationErrors();
  }
}
