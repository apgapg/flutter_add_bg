import 'package:flutter/material.dart';
import 'package:flutter_add_bg/utils/design_utils.dart';

class Tool extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final isSelected;
  final String tooltip;

  Tool(this.icon, this.onTap, this.isSelected, this.tooltip);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            height: toolSize,
            width: toolSize,
            child: Center(
              child: Container(
                /* decoration: isSelected?BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ):null,*/
                child: Icon(
                  icon,
                  color: isSelected ? Theme
                      .of(context)
                      .primaryColor : Colors.black87,
                ),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
