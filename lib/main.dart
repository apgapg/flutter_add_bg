import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_bg/widget/tools/align_tool.dart';
import 'package:flutter_add_bg/widget/tools/line_spacing.dart';
import 'package:flutter_add_bg/widget/tools/tint.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
      home: HomePage(),
    );
  }
}

double toolsize = 44.0;
Color toolBackgroundColor = Colors.grey[300];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  var _key = new GlobalKey();

  var _height = 0.0;

  String _text = "The trouble is you think you have time.";

  double _screenWidth;

  var _textSize = 18.0;

  bool _bold = false;

  final _textAlignList = [TextAlign.center, TextAlign.right, TextAlign.left];

  var _textAlign;

  String _fontFamily = 'sans-serif';

  var _lineSpacing = 1.0;
  var _tintList = [
    Colors.black,
    Colors.blue[900],
    Colors.red[900],
    Colors.green[900],
    Colors.purple[900],
  ];
  var _tint;

  @override
  void initState() {
    super.initState();
    _textAlign = _textAlignList.elementAt(0);
    _tint = _tintList.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: toolBackgroundColor,
        title: Text(
          "bgEditor",
          style: TextStyle(
            color: Colors.blueGrey[900].withOpacity(0.9),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              "SAVE",
              style: TextStyle(
                color: Colors.blueGrey[900].withOpacity(0.9),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: _height,
                child: Image(
                  image: CachedNetworkImageProvider(
                    'https://www.gstatic.com/webp/gallery/1.jpg',
                  ),
                  color: _tint.withOpacity(0.5),
                  colorBlendMode: BlendMode.darken,
                  width: _screenWidth,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                key: _key,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _text,
                  textAlign: _textAlign,
                  style: TextStyle(
                    fontSize: _textSize,
                    fontWeight: _bold ? FontWeight.w700 : FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                    fontFamily: _fontFamily,
                    height: _lineSpacing,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 44.0,
          color: toolBackgroundColor,
          child: Row(
            children: <Widget>[
              BoldTool(onBoldToolTap),
              SizeTool(onSizeToolTap),
              FontTool(onFontToolTap),
              AlignTool(onAlignToolTap),
              LineSpacingTool(onLineSpacingToolTap),
              ContrastTool(onFontToolTap),
              ColorTool(onFontToolTap),
              TintTool(onTintToolTap),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _resizeImage();
  }

  void _resizeImage() async {
    await Future.delayed(Duration(milliseconds: 1));
    var _textHeight = _key.currentContext.size.height;
    var _imageHeight = _textHeight + 64.0;
    setState(() {
      _height = _imageHeight < _screenWidth * 0.7 ? _screenWidth * 0.7 : _imageHeight;
    });
  }

  void onBoldToolTap() {
    setState(() {
      _bold = !_bold;
    });
  }

  void onSizeToolTap() {
    setState(() {
      _textSize = _textSize > 24.0 ? 18.0 : _textSize + 2;
    });
  }

  void onFontToolTap() {
    setState(() {
      _fontFamily = 'Nunito';
      //_textSize = _textSize > 24.0 ? 18.0 : _textSize+2;
    });
  }

  void onAlignToolTap() {
    setState(() {
      _textAlign = _textAlignList.elementAt((_textAlignList.indexOf(_textAlign) + 1) == _textAlignList.length ? 0 : _textAlignList.indexOf(_textAlign) + 1);
    });
  }

  void onLineSpacingToolTap() {
    _lineSpacing = _lineSpacing + 0.2;
    setState(() {
      _lineSpacing = _lineSpacing > 1.4 ? 0.8 : _lineSpacing;
    });
  }

  void onTintToolTap() {
    setState(() {
     _tint = _tintList.elementAt((_tintList.indexOf(_tint) + 1) == _tintList.length ? 0 : _tintList.indexOf(_tint) + 1);
    });
  }
}

class BoldTool extends StatelessWidget {
  final VoidCallback onTap;

  BoldTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.format_bold),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class SizeTool extends StatelessWidget {
  final VoidCallback onTap;

  SizeTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.format_size),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class FontTool extends StatelessWidget {
  final VoidCallback onTap;

  FontTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.font_download),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ContrastTool extends StatelessWidget {
  final VoidCallback onTap;

  ContrastTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.brightness_4),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ColorTool extends StatelessWidget {
  final VoidCallback onTap;

  ColorTool(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: toolsize,
          width: toolsize,
          child: Center(
            child: Icon(Icons.color_lens),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
