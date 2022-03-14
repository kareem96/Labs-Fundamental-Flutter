

import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigating and routing'),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Second Screen'),
              onPressed: (){
                Navigator.pushNamed(context, '/secondScreen');
              },
            ),

            ElevatedButton(
              child: Text('Navigation with data'),
              onPressed: (){
                Navigator.pushNamed(context, '/screenWithData', arguments: 'im from first screen');
              },
            ),

            ElevatedButton(
              child: Text('Return data from another screen'),
              onPressed: () async{
                final result = await Navigator.pushNamed(context, '/screenReturnData');
                SnackBar snackBar = SnackBar(content: Text('$result'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),

            ElevatedButton(
              child: Text('Replace screen'),
              onPressed: (){
                Navigator.pushNamed(context, '/screenReplacement');
              },
            ),


          ],
        ),
      ),
    );
  }
}
