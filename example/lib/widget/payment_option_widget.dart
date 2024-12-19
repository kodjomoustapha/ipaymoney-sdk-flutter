import 'package:flutter/material.dart';

class PaymentOptionWidget extends StatelessWidget {
  final List<String> assets;
  final String label;
  final bool selected;
  final Function()? onTap;
  final double width;
  final double left;
  const PaymentOptionWidget(
      {super.key,
      required this.assets,
      required this.label,
      required this.selected,
      required this.onTap,
      required this.width,
      required this.left});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height: 75,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        border: Border.all(
                            color: selected ? Colors.green : Colors.grey,
                            width: selected ? 0.6 : 0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 2, left: left, right: 2),
                            child: SizedBox(
                              height: 35,
                              child: Stack(
                                children: List.generate(
                                    assets.length,
                                    (i) => Positioned(
                                          left: i * 20.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(assets[i],
                                                  height: 30,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        )).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (selected)
              Positioned(
                left: width - 20,
                child: const CircleAvatar(
                  radius: 9,
                  child: Padding(
                      padding: EdgeInsets.all(3.5),
                      child: Icon(
                        Icons.check,
                        size: 11,
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
