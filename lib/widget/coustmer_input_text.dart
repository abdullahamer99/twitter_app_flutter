import 'package:flutter/material.dart';
class CumotumerInputField extends StatelessWidget {
  const CumotumerInputField({
    Key key,
    @required this.hintText,
     this.secure,
     this.controller,
  }) : super(key: key);
  final String hintText;
  final bool secure;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(10),
      child:TextFormField(
        controller:controller,
        obscureText:secure,
        decoration:InputDecoration(
            hintText: hintText
        ),
      ),
    );

  }
}
