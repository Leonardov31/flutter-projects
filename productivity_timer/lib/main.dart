import 'package:flutter/material.dart';
import 'package:productivity_timer/components/custom_button.dart';

import 'components/custom_progress_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productivity App',
      theme: ThemeData(brightness: Brightness.dark),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatefulWidget {
  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage>
    with TickerProviderStateMixin {
  AnimationController controller;
  double duration = 10;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
  }

  String get timeString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 26, 51),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('My Work Timer'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: 'Work',
                  color: Colors.pink[600],
                  onPressed: () {},
                ),
                SizedBox(width: 10.0),
                CustomButton(
                  text: 'Short Break',
                  color: Colors.blue[400],
                  onPressed: () {},
                ),
                SizedBox(width: 10.0),
                CustomButton(
                  text: 'Long Break',
                  color: Colors.amber[400],
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: buildAnimatedBuilderCircle(),
                      ),
                      Align(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return Text(
                              timeString,
                              style: TextStyle(
                                fontSize: 100,
                                color: Color.fromARGB(255, 242, 242, 242),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                CustomButton(
                  text: 'Stop',
                  color: Colors.red[400],
                  onPressed: () {},
                ),
                SizedBox(width: 10.0),
                CustomButton(
                  text: 'Restart',
                  color: Colors.green[400],
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AnimatedBuilder buildAnimatedBuilderCircle() {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return CustomPaint(
          painter: CustomTimerPainter(
            animation: controller,
            backgroundColor: Colors.blue[200],
            color: Color.fromARGB(255, 0, 10, 36),
          ),
        );
      },
    );
  }
}
