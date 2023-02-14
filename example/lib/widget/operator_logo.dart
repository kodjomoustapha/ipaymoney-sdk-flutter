import 'package:flutter/material.dart';

class OperatorLogo extends StatelessWidget {
  final String imgUrl;
  const OperatorLogo({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        imgUrl,
        height: 25,
      ),
    );
  }
}
