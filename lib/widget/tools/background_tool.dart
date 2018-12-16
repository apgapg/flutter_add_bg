import 'package:flutter/material.dart';
import 'package:flutter_add_bg/main.dart';

class BlurTool extends StatelessWidget {
  final VoidCallback onTap;

  BlurTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.blur_on),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
