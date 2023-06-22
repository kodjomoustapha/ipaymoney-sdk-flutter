import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
import 'package:ipay_money_flutter_sdk_example/widget/operator_logo.dart';
import 'package:ipay_money_flutter_sdk_example/widget/type_payment_widget.dart';

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
  bool _isMobileMoney = true;
  bool _isVisa = false;
  bool _isAlIzza = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iPayMoney Sdk Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Choisir un moyen de paiement",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentTypeWidget(
                  list: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: OperatorLogo(imgUrl: "assets/airtel.png"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: OperatorLogo(imgUrl: "assets/moov.jpeg"),
                    )
                  ],
                  label: "Mobile Money",
                  isTapMobileMoney: _isMobileMoney,
                  onTap: () {
                    setState(() {
                      _isVisa = false;
                      _isMobileMoney = true;
                      _isAlIzza = false;
                    });
                  },
                  isTapVisa: false,
                  isTapAlIzza: false,
                ),
                PaymentTypeWidget(
                  list: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: OperatorLogo(imgUrl: "assets/alizza.png"),
                    )
                  ],
                  label: "AlIzza",
                  isTapMobileMoney: false,
                  onTap: () {
                    setState(() {
                      _isVisa = false;
                      _isMobileMoney = false;
                      _isAlIzza = true;
                    });
                  },
                  isTapVisa: false,
                  isTapAlIzza: _isAlIzza,
                ),
                Column(
                  children: [
                    PaymentTypeWidget(
                      list: const [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: OperatorLogo(imgUrl: "assets/mastercard.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: OperatorLogo(imgUrl: "assets/visa.png"),
                        ),
                      ],
                      label: "Carte Bancaire",
                      isTapVisa: _isVisa,
                      onTap: () {
                        setState(() {
                          _isVisa = true;
                          _isMobileMoney = false;
                          _isAlIzza = false;
                        });
                      },
                      isTapMobileMoney: false,
                      isTapAlIzza: false,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _isVisa
                      ? Column(
                          children: [
                            TextFormField(
                              controller: _mycontrollerPan,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Numéro de la carte",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
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
                                      hintText: '--/--',
                                      labelText: "Date expiration",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
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
                                      counterStyle: const TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                      labelText: "Cvv",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      : Container(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _mycontrollerName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: "Nom et prénom",
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _mycontrollerNumber,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 14, left: 7),
                              child: Text(
                                "+227",
                                style: TextStyle(),
                              ),
                            ),
                            labelText: _isVisa
                                ? "Numéro de téléphone"
                                : "Numéro Mobile Money",
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _mycontrollerAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Montant",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
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
                            authorization:
                                'secret key',
                            country: Country.ne,
                            currency: 'XOF',
                            exp: _mycontrollerExp.text,
                            pan: _mycontrollerPan.text,
                            cvv: _mycontrollerCvv.text,
                            msisdn: _mycontrollerNumber.text,
                            name: _mycontrollerName.text,
                            targetEnvironment: TargetEnvironment.sandbox,
                            paymentType: _isMobileMoney
                                ? PaymentType.mobile
                                : _isAlIzza
                                    ? PaymentType.alizza
                                    : PaymentType.card,
                          ).ipayPayment(
                              context: context,
                              callback: (callback) async {
                                // log(callback.toString());
                                if (jsonDecode(callback)['status'] ==
                                    'success') {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Paiement effectuer avec succès , reference du paiement : ${jsonDecode(callback)['reference']}'),
                                      duration: const Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  log(callback.toString());
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
