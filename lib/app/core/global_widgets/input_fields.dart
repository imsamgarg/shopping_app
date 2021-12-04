import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/utils/helper.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.icon,
    this.controller,
    this.isPass,
    required this.hintText,
    this.textInputType,
    this.validator,
  }) : super(key: key);

  final IconData icon;
  final TextEditingController? controller;
  final bool? isPass;
  final String hintText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  // final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final color = primaryColor(context);
    return Hero(
      tag: hintText,
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          key: key,
          validator: validator,
          controller: controller,
          cursorColor: color,
          obscureText: isPass ?? false,
          keyboardType: textInputType,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: color,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey[400]!,
                style: BorderStyle.solid,
              ),
            ),
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
