import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_restaurant_api/utils/background_service.dart';
import 'package:app_restaurant_api/utils/date_time_helper.dart';
import 'package:flutter/cupertino.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;


  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 1),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format()
      );
    } else {
      print('');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}