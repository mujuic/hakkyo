// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.black,
        border:Border.all(width: 5, color: Colors.white),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(child:widget)
    );
  }
}
