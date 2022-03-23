import 'dart:io';

import 'package:app_restaurant_api/provider/preference_provider.dart';
import 'package:app_restaurant_api/provider/scheduling_provider.dart';
import 'package:app_restaurant_api/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  static const String routeName = '/setting_page';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsTitle),
      ),
      resizeToAvoidBottomInset: true,
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
    return Consumer<PreferenceProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  }),
            ),
            ListTile(
              title: const Text('Notification'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                      value: provider.isDailyRestaurant,
                      onChanged: (value) {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledReminder(value);
                          provider.enableDarkTheme(value);
                        }
                      });
                },
              ),
            )
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
