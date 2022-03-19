import 'package:flavor_mode/flavor_config.dart';
import 'package:flavor_mode/flutter_mode_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(FlavorConfig.instance.values.titleApp),
        ),
        body: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
            if (!snapshot.hasData) return Container();
            PackageInfo? _packageInfo = snapshot.data;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belajar Flavor Mode',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                  const Divider(
                    height: 32,
                    thickness: 2,
                  ),
                  Text(
                    'Flavor: ${FlavorConfig.instance.flavor.name}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Mode: ${FlutterModeConfig.flutterMode}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Divider(
                    height: 32,
                    thickness: 2,
                  ),
                  Text(
                    'App Name: ${_packageInfo?.appName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Package Name: ${_packageInfo?.packageName}',
                    style: const TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Version Name: ${_packageInfo?.version}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            );
          },
        ));
  }
}

class FlavorValues {
  final String titleApp;

  const FlavorValues({this.titleApp = 'Development App'});
}
