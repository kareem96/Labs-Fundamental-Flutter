


import 'package:flutter/material.dart';

class ScreenWithData extends StatelessWidget {
  final String data;
  const ScreenWithData(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen With Data'),),
      body: Center(
        child: Container(
          child: Text(data.toString()),
        ),
      ),
    );
  }
}
