import 'package:flutter/material.dart';
import 'package:productivity_timer/components/custom_button.dart';
import 'package:productivity_timer/settings_screen.dart';

import 'components/custom_progress_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productivity App',
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
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
  int _duration = 30;
  int _work = 30;
  int _shortBreak = 5;
  int _longBreak = 20;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _duration),
    );
  }

  String get timeString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void startOrStopTimer() {
    if (controller.isAnimating)
      controller.stop();
    else {
      controller.reverse(
        from: controller.value == 0.0 ? 1.0 : controller.value,
      );
    }
  }

  void setTimeWork() {
    setState(() {
      _duration = _work;
      controller.value = 0.0;
      controller.duration = Duration(seconds: _duration);
    });
  }

  void setBreak(bool isShort) {
    setState(() {
      _duration = isShort ? _shortBreak : _longBreak;
      controller.value = 0.0;
      controller.duration = Duration(seconds: _duration);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 26, 51),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('My Work Timer'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              color: Color.fromARGB(255, 242, 242, 242),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SettingsScreen();
                  },
                ),
              ),
              icon: Icon(Icons.settings),
            ),
          ),
        ],
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
                  onPressed: setTimeWork,
                ),
                SizedBox(width: 10.0),
                CustomButton(
                  text: 'Short Break',
                  color: Colors.blue[600],
                  onPressed: () => setBreak(true),
                ),
                SizedBox(width: 10.0),
                CustomButton(
                  text: 'Long Break',
                  color: Colors.amber[600],
                  onPressed: () => setBreak(false),
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
                        child: buildAnimatedBuilderText(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return CustomButton(
                      text: !controller.isAnimating ? 'Stop' : 'Start',
                      color: Colors.red[600],
                      onPressed: startOrStopTimer,
                    );
                  },
                ),
                SizedBox(width: 10.0),
                CustomButton(
                  text: 'Restart',
                  color: Colors.green[600],
                  onPressed: () {
                    print(controller.value);
                    controller.reverse(from: controller.value = 1.0);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AnimatedBuilder buildAnimatedBuilderText() {
    Duration duration = controller.duration;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Text(
          controller.isAnimating
              ? timeString
              : '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: 100,
            color: Color.fromARGB(255, 242, 242, 242),
          ),
        );
      },
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
