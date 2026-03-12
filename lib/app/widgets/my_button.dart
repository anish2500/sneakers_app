import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final VoidCallback? onTap;
  final Color backgroundColor;
  const MyButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    this.onTap,
    required this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            // color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
