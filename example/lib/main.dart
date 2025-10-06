import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: IpayPaymentsWidget(
            authorization: 'sk_1f3e3f0772af4b5f8fc4406cf0dc5011',
            country: Country.ne,
            currency: 'XOF',
            targetEnvironment: TargetEnvironment.live,
            callback: (callback, context) async {
              if (jsonDecode(callback)['status'] == 'success') {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Paiement effectué avec succès, référence du paiement : ${jsonDecode(callback)['reference']}'),
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.green,
                  ));
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('"Échec du paiement. Veuillez réessayer."'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                  ));
                }
                if (kDebugMode) {
                  log(callback.toString());
                }
              }
            }));
  }
}
