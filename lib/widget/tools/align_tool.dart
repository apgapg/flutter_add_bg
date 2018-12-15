import 'package:flutter/material.dart';
import 'package:flutter_add_bg/main.dart';

class AlignTool extends StatelessWidget {
  final VoidCallback onTap;

  AlignTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.format_align_left),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
