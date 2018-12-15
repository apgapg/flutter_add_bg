import 'package:flutter/material.dart';
import 'package:flutter_add_bg/main.dart';

class LineSpacingTool extends StatelessWidget {
  final VoidCallback onTap;

  LineSpacingTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.format_line_spacing),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
