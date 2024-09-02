import 'package:flutter/material.dart';

class PaymentTypeWidget extends StatelessWidget {
  final List<Widget> list;
  final String label;
  final bool isTapMobileMoney;
  final bool isTapVisa;
  final bool isTapAlIzza;
  final Function()? onTap;
  final double width;
  const PaymentTypeWidget(
      {Key? key,
      required this.list,
      required this.label,
      required this.isTapMobileMoney,
      required this.onTap,
      required this.isTapVisa,
      required this.isTapAlIzza,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
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
                        padding:
                            const EdgeInsets.only(left: 10, top: 1, bottom: 3),
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
            Positioned(
              left: width-25,
              child: const CircleAvatar(
                radius: 13,
                child: Padding(
                    padding: EdgeInsets.all(3.5),
                    child: Icon(
                      Icons.check,
                      size: 17,
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
