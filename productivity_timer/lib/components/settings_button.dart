import 'package:flutter/material.dart';

class SettinsButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final String text;

  SettinsButton({this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: this.onPressed,
        color: this.color,
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
