import 'package:app_project/components/color.dart';
import 'package:app_project/sqflite/database_helper.dart';
import 'package:flutter/material.dart';


class InputField extends StatefulWidget {
  final String hint;
  String? Function(String?)?  valu;
  final double horizon;
  final IconData icon;
  final bool passwordinvisible;
  final TextEditingController controller;
  InputField(
      {super.key,
      required this.hint,
      required this.valu,
      required this.icon,
      required this.controller,
      this.passwordinvisible = false,
      this.horizon = 10});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final user = TextEditingController();
    final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical:2 ),
        margin: EdgeInsets.symmetric(vertical: widget.horizon),
        width: size.width * .9,
        height: 55,
        decoration: BoxDecoration(
            color: backgroudColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: TextFormField (
            validator: widget.valu,
           
            controller: widget.controller,
            obscureText: widget.passwordinvisible,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              icon: Icon(widget.icon),
            ),
          ),
          
        ));
  }
}
