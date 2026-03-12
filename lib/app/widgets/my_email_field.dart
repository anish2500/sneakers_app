
import 'package:flutter/material.dart';

class MyEmailField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  const MyEmailField({
    super.key,
    this.labelText, 
    this.hintText, 
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.emailAddress,
    this.borderColor,
    this.borderRadius = 30,
    this.contentPadding,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: const Color.fromARGB(255, 130, 129, 129),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        floatingLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: const Color.fromARGB(255, 148, 147, 147),
          fontWeight: FontWeight.w600,
        ),
        contentPadding: contentPadding ?? EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: borderColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: borderColor ?? const Color.fromARGB(255, 155, 155, 155),
            width: 2,
          ),
        ),
      ),
    );
  }
}