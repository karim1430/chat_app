import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, required this.text});
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(child: Text(text)),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
      ),
    );
  }
}
