import 'package:flutter/material.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Back to First Screen'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('back'))
          ],
        ),
      ),
    );
  }
}
