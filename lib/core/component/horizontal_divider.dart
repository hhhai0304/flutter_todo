import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final bool isHidden;

  const HorizontalDivider({this.isHidden = false});

  @override
  Widget build(BuildContext context) {
    return isHidden
        ? Container()
        : Container(
            width: double.maxFinite,
            height: 1,
            color: const Color(0xFFE7E7E7),
          );
  }
}
