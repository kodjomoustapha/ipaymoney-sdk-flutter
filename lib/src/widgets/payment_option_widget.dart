import 'package:flutter/material.dart';

class PaymentOptionWidget extends StatelessWidget {
  final List<String> assets;
  final String label;
  final Function()? onTap;
  const PaymentOptionWidget({
    super.key,
    required this.assets,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withValues(alpha: 0.07),
              border: Border.all(
                width: 0.5,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: ((assets.length + 1) * 23.0),
                        height: 35,
                        child: Stack(
                          children: List.generate(
                            assets.length,
                            (i) => Positioned(
                              left: i * 23.0,
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
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
