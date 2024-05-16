// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black,
        border:Border.all(width: 2.5, color: Colors.white),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(child: widget)
    );
  }
}
