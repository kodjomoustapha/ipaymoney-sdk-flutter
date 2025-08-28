import 'package:flutter/material.dart';
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';

class PaymentTypeInfoWidget extends StatelessWidget {
  final PaymentType paymentType;

  const PaymentTypeInfoWidget({
    super.key,
    required this.paymentType,
  });

  @override
  Widget build(BuildContext context) {
    final assets = IpayAssets.getAssetsByPaymentType(paymentType);
    final label = IpayAssets.getPaymentTypeLabel(paymentType);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: ((assets.length + 1) * 20.0),
          height: 30,
          child: Stack(
            children: List.generate(
              assets.length,
              (i) => Positioned(
                left: i * 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      assets[i],
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
