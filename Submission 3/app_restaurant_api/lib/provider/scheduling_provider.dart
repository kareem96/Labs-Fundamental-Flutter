import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_restaurant_api/utils/background_service.dart';
import 'package:app_restaurant_api/helper/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;


  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      Fluttertoast.showToast(msg: 'Mengaktifkan Penjadwalan');
      print('Scheduling Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(seconds: 1),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true
      );
    } else {
      Fluttertoast.showToast(msg: 'Menonaktifkan Penjadwalan');
      print('Scheduling Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}