

import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ElevatedButton(
          child: Text('Back'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
