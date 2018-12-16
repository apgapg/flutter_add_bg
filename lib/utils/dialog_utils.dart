import 'package:flutter/material.dart';

class DialogUtils {
  static void showProgressBar(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new Dialog(
            child: new Container(
              height: 80.0,
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      strokeWidth: 1.5,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: new Text(
                      text,
                      style: new TextStyle(color: Colors.grey[700], fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static void hideProgressBar(BuildContext context) {
    Navigator.pop(context);
  }
}
