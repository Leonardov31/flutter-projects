import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.pink[100],
        child: InkWell(
          splashColor: Colors.pink[500],
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              this.icon,
              color: Colors.grey[10],
            ),
          ),
          onTap: this.onTap,
        ),
      ),
    );
  }
}
