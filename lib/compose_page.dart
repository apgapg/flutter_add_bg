import 'package:flutter/material.dart';
import 'package:flutter_add_bg/main.dart';

class ComposePage extends StatefulWidget {
  final String text;

  ComposePage(this.text);

  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: toolBackgroundColor,
        title: Text(
          "Edit Text",
          style: TextStyle(
            color: Colors.blueGrey[900].withOpacity(0.9),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: _onDonePress,
            child: Text(
              "DONE",
              style: TextStyle(
                color: Colors.blueGrey[900].withOpacity(0.9),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            autofocus: true,
            controller: _textController,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Enter text here...",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  void _onDonePress() {
    if (_textController.text.isEmpty)
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Text cannot be empty!"),
        ),
      );
    else
      Navigator.pop(context, _textController.text);
  }
}
