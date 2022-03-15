import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/provider/done_module_provider.dart';

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;

  const ModuleList({Key? key, required this.doneModuleList}) : super(key: key);

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> _moduleList = [
    'Module 1 - Pengenalan dart',
    'Module 2 - Memulai Pemograman dengan Dart',
    'Module 3 - Dart Fundamental',
    'Module 4 - Control Flow dart',
    'Module 5 - Collections',
    'Module 6 - Object Oriented Programming',
    'Module 7 - Functional Styles',
    'Module 8 - Dart Type System',
    'Module 9 - Dart Futures dart',
    'Module 10 - Effective Dart',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _moduleList.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, DoneModuleProvider data, widget) {
            return ModuleTile(
              moduleName: _moduleList[index],
              isDone: data.doneModuleList.contains(_moduleList[index]),
              onClick: () {
                setState(() {
                  data.doneModuleList.add(_moduleList[index]);
                });
              },
            );
          },
        );
      },
    );
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function() onClick;

  const ModuleTile(
      {Key? key,
      required this.moduleName,
      required this.isDone,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? const Icon(Icons.done)
          : ElevatedButton(onPressed: onClick, child: const Text('Done')),
    );
  }
}
