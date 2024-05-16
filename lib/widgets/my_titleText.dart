// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTitleText extends StatelessWidget {
  const MyTitleText({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      )
    );
  }
}
