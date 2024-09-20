import 'package:flutter/material.dart';

class PaymentOptionWidget extends StatelessWidget {
  final List<String> assets;
  final String label;
  final bool selected;
  final Function()? onTap;
  final double? width;
  const PaymentOptionWidget(
      {Key? key,
      required this.assets,
      required this.label,
      required this.selected,
      required this.onTap,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width_ = width ?? MediaQuery.of(context).size.width * 0.4;
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
                    width: width_,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        border: Border.all(
                            color: selected ? Colors.green : Colors.grey,
                            width: selected ? 1 : 0.4),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 2, left: 2, right: 2),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: assets
                                    .map((e) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(e, height: 25),
                                          ),
                                        ))
                                    .toList(),
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
                left: width_ - 20,
                child: const CircleAvatar(
                  radius: 10,
                  child: Padding(
                      padding: EdgeInsets.all(3.5),
                      child: Icon(
                        Icons.check,
                        size: 13,
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
