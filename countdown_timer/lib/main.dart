import 'package:countdown_timer/components/circular_progress_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountDownTimer(),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.blue[300],
                  height: controller.value * MediaQuery.of(context).size.height,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: buildAnimatedBuilderCircle(),
                              ),
                              Align(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Count Down Timer",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    buildAnimatedBuilderText(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    buildAnimatedBuilderButton(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  AnimatedBuilder buildAnimatedBuilderButton() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            if (controller.isAnimating)
              controller.stop();
            else {
              controller.reverse(
                from: controller.value == 0.0 ? 1.0 : controller.value,
              );
            }
          },
          icon: Icon(controller.isAnimating ? Icons.pause : Icons.play_arrow),
          label: Text(controller.isAnimating ? "Pause" : "Play"),
        );
      },
    );
  }

  AnimatedBuilder buildAnimatedBuilderText() {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Text(
          timerString,
          style: TextStyle(
            fontSize: 112.0,
            color: Colors.white,
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
            backgroundColor: Colors.white,
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
