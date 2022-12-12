import 'package:flutter/material.dart';

class TypePaiementWidget extends StatelessWidget {
  final List<Widget> list;
  final String label;
  final bool isTapMobileMoney;
  final bool isTapVisa;
  final bool isTapAlIzza;
  final VoidCallback onTap;
  const TypePaiementWidget({
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: isTapMobileMoney || isTapVisa || isTapAlIzza
                      ? Colors.green.withOpacity(0.3)
                      : Colors.white,
                  border: Border.all(
                      color: isTapMobileMoney || isTapVisa || isTapAlIzza
                          ? Colors.black
                          : Colors.black.withOpacity(0.5),
                      width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: list,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTapMobileMoney || isTapVisa || isTapAlIzza
                      ? FontWeight.bold
                      : FontWeight.w400,
                  fontFamily: "Lato"),
            ),
          )
        ],
      ),
    );
  }
}
