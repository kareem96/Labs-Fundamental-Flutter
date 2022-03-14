import 'package:flutter/material.dart';

class ScreenReturnData extends StatefulWidget {
  const ScreenReturnData({Key? key}) : super(key: key);

  @override
  State<ScreenReturnData> createState() => _ScreenReturnDataState();
}

class _ScreenReturnDataState extends State<ScreenReturnData> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen return data'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Enter your text!'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _textController.text);
                },
                child: Text('Send'))
          ],
        ),
      ),
    );
  }
}
