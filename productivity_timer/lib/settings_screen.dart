import 'package:flutter/material.dart';
import 'package:productivity_timer/components/custom_button.dart';
import 'package:productivity_timer/components/settings_button.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 26, 51),
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle =
      TextStyle(fontSize: 24, color: Color.fromARGB(255, 242, 242, 242));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          Text('Work', style: textStyle),
          Text(''),
          Text(''),
          SettinsButton(
            text: '-',
            color: Colors.pink[800],
            onPressed: () {},
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettinsButton(
            text: '+',
            color: Colors.pink[800],
            onPressed: () {},
          ),
          Text('Short', style: textStyle),
          Text(''),
          Text(''),
          SettinsButton(
            text: '-',
            color: Colors.blue[800],
            onPressed: () {},
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettinsButton(
            text: '+',
            color: Colors.blue[800],
            onPressed: () {},
          ),
          Text('Long', style: textStyle),
          Text(''),
          Text(''),
          SettinsButton(
            text: '-',
            color: Colors.amber[800],
            onPressed: () {},
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettinsButton(
            text: '+',
            color: Colors.amber[800],
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
