import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  const MyPasswordField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = true,
    this.borderColor,
    this.borderRadius = 30,
    this.contentPadding,
  });

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: _isObscured,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: const Color.fromARGB(255, 130, 129, 129),
        ),
        hintText: widget.hintText,
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
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color:
                widget.borderColor ?? const Color.fromARGB(255, 155, 155, 155),
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
    );
  }
}
