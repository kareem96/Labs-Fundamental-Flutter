import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/provider/preferences_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                    value: provider.isDarkTheme,
                    onChanged: (value) {
                      provider.enableDarkTheme(value);
                      /*defaultTargetPlatform == TargetPlatform.iOS
                          ? showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text('Coming soon'),
                                  content: const Text(
                                      'This feature will be coming soon!'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                );
                              })
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Coming soon!'),
                                  content: const Text(
                                      'This feature will be coming soon'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    )
                                  ],
                                );
                              });*/
                    }
                    ),
              ),
            ),
            /*Material(
              child: ListTile(
                title: Text('Scheduling News'),
                trailing: Consumer<SchedulerProvider>(
                  builder: (context, scheduled, _){
                    return Switch.adaptive(
                        value: provider.isDailyNewsActive,
                        onChanged: (value) async{
                          if(Platform.isIOS){
                            customDialog(context);
                          }else{
                            scheduled.scheduledNews(value);
                            provider.enableDailyNews(value);
                          }
                        }
                    )
                  },
                ),
              ),
            )*/
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
