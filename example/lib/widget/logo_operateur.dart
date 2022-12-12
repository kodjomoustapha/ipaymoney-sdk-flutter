import 'package:flutter/material.dart';

class LogoOperateur extends StatelessWidget {
  final String imgUrl;
  const LogoOperateur({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        imgUrl,
        height: 50,
      ),
    );
  }
}
