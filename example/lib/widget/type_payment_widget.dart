import 'package:flutter/material.dart';

class PaymentTypeWidget extends StatelessWidget {
  final List<Widget> list;
  final String label;
  final bool isTapMobileMoney;
  final bool isTapVisa;
  final bool isTapAlIzza;
  final VoidCallback onTap;
  const PaymentTypeWidget({
    Key? key,
    required this.list,
    required this.label,
    required this.isTapMobileMoney,
    required this.onTap,
    required this.isTapVisa,
    required this.isTapAlIzza,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        // width: mediaWidth(context, 0.29),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    decoration: BoxDecoration(
                        // color: isTapMobileMoney || isTapVisa || isTapAlIzza
                        //     ? Colors.green.withOpacity(0.3)
                        //     : Colors.white,
                        border: Border.all(
                            color: isTapMobileMoney || isTapVisa || isTapAlIzza
                                ? Colors.green
                                : Colors.grey,
                            width: isTapMobileMoney || isTapVisa || isTapAlIzza
                                ? 1
                                : 0.4),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 2, left: 2, right: 2),
                          child: SizedBox(
                            child: Row(
                              children: list,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 1, bottom: 3),
                          child: Text(
                            label,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Lato"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isTapMobileMoney || isTapVisa || isTapAlIzza)
              const Positioned(
                left: 71,
                child: CircleAvatar(
                  radius: 8,
                  child: Padding(
                      padding: EdgeInsets.all(3.5), child: Icon(Icons.check)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
