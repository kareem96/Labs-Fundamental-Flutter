

import 'package:flutter/material.dart';

class MaxWidthWidget extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const MaxWidthWidget({
    Key? key,
    required this.child,
    required this.maxWidth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child:
      Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
