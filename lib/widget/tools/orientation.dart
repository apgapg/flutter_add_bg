import 'package:flutter/material.dart';
import 'package:flutter_add_bg/main.dart';

class OrientationTool extends StatelessWidget {
  final VoidCallback onTap;

  OrientationTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.screen_rotation),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
