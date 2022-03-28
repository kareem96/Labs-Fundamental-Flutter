import 'dart:isolate';
import 'dart:ui';
import 'package:app_restaurant_api/main.dart';
import 'package:http/http.dart';
import '../data/api/api_service.dart';
import '../helper/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializedIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getTopHeadLines(Client());
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
