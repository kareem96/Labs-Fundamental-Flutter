


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';


class FileDialog extends StatelessWidget {
  const FileDialog({Key? key, required this.files}) : super(key: key);
  final List<FileSystemEntity> files;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Choose your file'),
      ),
      child: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index){
          final file = files[index];
          return Material(
            child: ListTile(
              title: Text(split(file.path).last),
              onTap: (){
                Navigator.pop(context, file);
              },
            ),
          );
        },
      ),
    );
  }
}
