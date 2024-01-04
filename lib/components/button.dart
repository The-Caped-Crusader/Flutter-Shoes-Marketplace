import 'package:flutter/material.dart';
import 'package:app_project/views/auth.dart';
import 'package:app_project/components/color.dart';

class button extends StatelessWidget {
  final String label;
  final VoidCallback press;
  final TextStyle style1;
  final double h;
  final Color? color;
  button(
      {super.key,
      required this.label,
      required this.press,
      required this.style1,
      required this.h,
      required this.color,
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .9,
      height: h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        onPressed: press,
        child: Text(
          label,
          style: style1,
        ),
      ),
    );
  }
}
