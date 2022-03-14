import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyGesture());

class MyGesture extends StatelessWidget {
  const MyGesture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detector',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: GesturePage(),
    );
  }
}

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  _GesturePageState createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  final double boxSize = 150;
  int numTaps = 0;
  int numDoubleTaps = 0;
  int numLongTaps = 0;
  double posY = 0.0;
  double posX = 0.0;

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30;

    setState(() {
      posX = posX;
      posY = posY;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (posX == 0) {
      center(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detector'),
      ),
      body: Stack(
        children: [
          Positioned(
              top: posY,
              left: posX,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    numTaps++;
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    numDoubleTaps++;
                  });
                },
                onLongPress: () {
                  setState(() {
                    numLongTaps++;
                  });
                },
                /*onVerticalDragUpdate: (DragUpdateDetails details) {
                  print(details);
                  setState(() {
                    double delta = details.delta.dy;
                    posY += delta;
                  });
                },
                onHorizontalDragUpdate: (DragUpdateDetails details){
                  setState(() {
                    double delta = details.delta.dx;
                    posX += delta;
                  });
                },*/
                onPanUpdate: (DragUpdateDetails details){
                  setState(() {
                    double deltaX = details.delta.dx;
                    double deltaY = details.delta.dy;
                    posX += deltaX;
                    posY += deltaY;
                  });
                },
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(color: Colors.red),
                ),
              )),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16),
        child: Text(
          'Taps: $numTaps - Double Taps: $numDoubleTaps - Long Press: $numLongTaps',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
