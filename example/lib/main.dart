import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
import 'package:ipay_money_flutter_sdk_example/widget/payment_option_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Test());
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TextEditingController _mycontrollerName = TextEditingController();
  final TextEditingController _mycontrollerNumber = TextEditingController();
  final TextEditingController _mycontrollerAmount = TextEditingController();
  final TextEditingController _mycontrollerCvv = TextEditingController();
  final TextEditingController _mycontrollerExp = TextEditingController();
  final TextEditingController _mycontrollerPan = TextEditingController();
  PaymentType _paymentType = PaymentType.mobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'iPayMoney Sdk Test',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Choisir un moyen de paiement",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PaymentOptionWidget(
                        assets: const [
                          "assets/airtel.jpeg",
                          "assets/mtn.png",
                          "assets/moov-africa.jpeg",
                          "assets/zamani-cash.png"
                        ],
                        label: "Mobile Money",
                        onTap: () {
                          setState(() {
                            _paymentType = PaymentType.mobile;
                          });
                        },
                        selected: _paymentType == PaymentType.mobile,
                        width: 140,
                      ),
                      PaymentOptionWidget(
                        assets: const [
                          "assets/mastercard.jpg",
                          "assets/visa.png"
                        ],
                        label: "Carte Bancaire",
                        onTap: () {
                          setState(() {
                            _paymentType = PaymentType.card;
                          });
                        },
                        selected: _paymentType == PaymentType.card,
                        width: 130,
                      ),
                      PaymentOptionWidget(
                        assets: const ["assets/boa.png"],
                        label: "Boa",
                        onTap: () {
                          setState(() {
                            _paymentType = PaymentType.boa;
                          });
                        },
                        selected: _paymentType == PaymentType.boa,
                        width: 65,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PaymentOptionWidget(
                        assets: const ["assets/alizza.png"],
                        label: "AlIzza money",
                        onTap: () {
                          setState(() {
                            _paymentType = PaymentType.alizza;
                          });
                        },
                        selected: _paymentType == PaymentType.alizza,
                        width: 110,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      PaymentOptionWidget(
                        assets: const ["assets/amanata.png"],
                        label: "AmanaTa",
                        onTap: () {
                          setState(() {
                            _paymentType = PaymentType.amanata;
                          });
                        },
                        selected: _paymentType == PaymentType.amanata,
                        width: 85,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _paymentType == PaymentType.card
                      ? Column(
                          children: [
                            TextFormField(
                              controller: _mycontrollerPan,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Numéro de la carte",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.8),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.8),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.8)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: _mycontrollerExp,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: '--/--',
                                      labelText: "Date expiration",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.8)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller: _mycontrollerCvv,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      counterStyle: const TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                      labelText: "Cvv",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.8)),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _mycontrollerName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: "Nom et prénom",
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.8))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _mycontrollerNumber,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 14, left: 7),
                              child: Text("+227"),
                            ),
                            labelText: _paymentType != PaymentType.mobile
                                ? "Numéro de téléphone"
                                : "Numéro Mobile Money",
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.8),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.8))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _mycontrollerAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Montant",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.8)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          IpayPayments(
                            timeOut: 60,
                            amount: _mycontrollerAmount.text,
                            authorization: 'Your secret key',
                            country: Country.ne,
                            currency: 'XOF',
                            exp: _mycontrollerExp.text,
                            pan: _mycontrollerPan.text,
                            cvv: _mycontrollerCvv.text,
                            msisdn: _mycontrollerNumber.text,
                            name: _mycontrollerName.text,
                            targetEnvironment: TargetEnvironment.live,
                            paymentType: _paymentType,
                          ).ipayPayment(
                              context: context,
                              callback: (callback) async {
                                if (jsonDecode(callback)['status'] ==
                                    'success') {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Paiement effectuer avec succès , reference du paiement : ${jsonDecode(callback)['reference']}'),
                                      duration: const Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  if (kDebugMode) {
                                    log(callback.toString());
                                  }
                                }
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Payer',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
