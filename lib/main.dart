import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  String hour = '0';
  String minute = '0';
  String seconds = '0';
  String ampm = '0';
  double _currentSliderValue = 0;

  List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.black
  ];

  void getTime() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        DateTime now = DateTime.now();
        hour = DateFormat('k').format(now);
        minute = DateFormat('mm ').format(now);
        seconds = DateFormat('ss a').format(now);
        ampm = DateFormat('a').format(now);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        color: _currentSliderValue >= 0 && _currentSliderValue <= 12
            ? colors[0]
            : _currentSliderValue > 12 && _currentSliderValue <= 15
                ? colors[1]
                : _currentSliderValue > 15 && _currentSliderValue <= 18
                    ? colors[2]
                    : colors[3],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                hour.toString(),
              ),
              Lottie.asset(
                'images/cloud.json',
                repeat: true,
                width: 100,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: Colors.red[700],
                  inactiveTickMarkColor: Colors.red[100],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Colors.redAccent,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 24,
                  divisions: 24,
                  label: _currentSliderValue.round().toString() + ':00',
                  onChanged: (double value) {
                    setState(() {
                      debugPrint(value.toString());
                      _currentSliderValue = value;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
