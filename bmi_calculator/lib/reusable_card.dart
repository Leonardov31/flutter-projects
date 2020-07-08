import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final Function onPress;

  ReusableCard({@required this.color, this.cardChild, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: this.cardChild,
      ),
    );
  }
}
