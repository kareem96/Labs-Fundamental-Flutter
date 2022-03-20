


import 'package:flutter_test/flutter_test.dart';
import 'package:state_provider/provider/done_module_provider.dart';

void main(){
  group('Provider Test', (){
    ///arrange
    var testModuleName = 'Test Module';
    var doneModuleProvider = DoneModuleProvider();

    setUp((){
      doneModuleProvider = DoneModuleProvider();
    });

    test('should contain new item when module completed', (){
      ///act
      doneModuleProvider.complete(testModuleName);
      ///assert
      var result = doneModuleProvider.doneModuleList.contains(testModuleName);
      expect(result, true);
    });

  });
}