

import 'package:flutter/material.dart';

class ScreenReplacement extends StatelessWidget {
  const ScreenReplacement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Open Another Screen'),
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/screenAnother');
          },
        ),
      ),
    );
  }
}
