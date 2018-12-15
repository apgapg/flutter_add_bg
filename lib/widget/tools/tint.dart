import 'package:flutter/material.dart';
import 'package:flutter_add_bg/main.dart';

class TintTool extends StatelessWidget {
  final VoidCallback onTap;

  TintTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.gradient),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
