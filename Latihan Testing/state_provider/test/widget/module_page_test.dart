

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/main.dart';
import 'package:state_provider/provider/done_module_provider.dart';


Widget createHomeScreen() => ChangeNotifierProvider<DoneModuleProvider>(
    create: (context) => DoneModuleProvider(),
    child: MaterialApp(
      home: MyHomePage(),
    )
);


void main(){

  group('Module List Page Widget Test', (){
    testWidgets('Testing if Listview shows up', (WidgetTester tester) async{
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);

    });
    testWidgets('Test Done Button', (tester) async{
      ///render widget
      await tester.pumpWidget(createHomeScreen());
      ///mencari ElevatedButton pertama kemuadian melakukan gestur tap
      await tester.tap(find.byType(ElevatedButton).first);
      ///rebuild tampilan karena perubahan state
      await tester.pumpAndSettle();
      ///verifikasi apakah ditemukan 2 icon done termasuk icon done yang berada di appBar
      expect(find.byIcon(Icons.done), findsNWidgets(2));
    });

  });
}