import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_add_bg/compose_page.dart';
import 'package:flutter_add_bg/utils/design_utils.dart';
import 'package:flutter_add_bg/utils/dialog_utils.dart';
import 'package:flutter_add_bg/widget/background_bar.dart';
import 'package:flutter_add_bg/widget/tools/tool.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  var _key = new GlobalKey();

  var _height = 0.0;

  String _text = "This is a sample text. Tap to edit it.";

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
    Colors.yellow[900],
    Colors.cyan[900],
    Colors.brown[900],
  ];
  var _fontList = ['sans-serif', 'Nunito', 'Patrick', 'Roboto', 'Cabin'];
  var _tint;

  final _mainKey = GlobalKey();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _heightFactor = 0.7;

  String _backgroundUrl = 'https://www.gstatic.com/webp/gallery/1.jpg';

  double _blur = 2.0;

  File _backgroundImage;

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/logo1.png',
              height: 40.0,
              width: 40.0,
            ),
            SizedBox(width: 8,),
            Text("Background Editor")
          ],
        ),
        elevation: 4.0,
        // title: Text("Bg Editor"),
        actions: <Widget>[
          FlatButton(
            onPressed: _onSaveTap,
            child: Row(
              children: <Widget>[
                Icon(Icons.save, color: Colors.white.withOpacity(0.9),),
                SizedBox(width: 8.0,),
                Text(
                  "SAVE",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: RepaintBoundary(
              key: _mainKey,
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: _height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: _backgroundImage == null
                                  ? CachedNetworkImageProvider(
                                      _backgroundUrl,
                                    )
                                  : FileImage(_backgroundImage),
                              fit: BoxFit.fill),
                        ),
                        /*child: Image(
                          image: CachedNetworkImageProvider(
                            _backgroundUrl,
                          ),
                          color: _tint.withOpacity(0.5),
                          colorBlendMode: BlendMode.darken,
                          width: _screenWidth,
                          fit: BoxFit.fill,
                        ),*/
                        child: BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
                          child: Container(
                            color: _tint.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _onTextTap,
                          child: Container(
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
                        ),
                      ),
                      Container(
                        height: _height,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(4.0),
                        child: Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            'assets/images/logo1.png',
                            height: 28.0,
                            width: 28.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 4.0,
        color: toolBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.5),
            ),
            BackgroundBar(onBackgroundToolTap, onBackgroundToolFromGalleryTap),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.7),
            ),
            Container(
              color: toolBackgroundColor,
              height: 44.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Tool(Icons.format_bold, onBoldToolTap, isBold(), "Bold"),
                    Tool(Icons.format_size, onSizeToolTap, false, "Font Size"),
                    Tool(Icons.font_download, onFontToolTap, false, "Font Family"),
                    Tool(Icons.format_align_left, onAlignToolTap, false, "Text Align"),
                    Tool(Icons.format_line_spacing, onLineSpacingToolTap, isLineSpacing(), "Line Spacing"),
                    Tool(Icons.blur_on, onBlurToolTap, isBlur(), "Background Blur"),
                    Tool(Icons.aspect_ratio, onOrientationToolTap, false, "Resize Background"),
                    Tool(Icons.gradient, onTintToolTap, false, "Tint"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _resizeImage();
  }

  void _resizeImage() async {
    await Future.delayed(Duration(milliseconds: 100));
    var _textHeight = _key.currentContext.size.height;
    var _imageHeight = _textHeight + 64.0;
    setState(() {
      _height = _imageHeight < _screenWidth * _heightFactor ? _screenWidth * _heightFactor : _imageHeight;
    });
  }

  void onBoldToolTap() {
    setState(() {
      _bold = !_bold;
    });
  }

  bool isBold() {
    return _bold;
  }

  void onSizeToolTap() {
    setState(() {
      _textSize = _textSize > 24.0 ? 18.0 : _textSize + 2;
    });
    _resizeImage();
  }

  bool isSize() {
    return _textSize != 18.0;
  }

  void onFontToolTap() {
    setState(() {
      _fontFamily = _fontList.elementAt((_fontList.indexOf(_fontFamily) + 1) == _fontList.length ? 0 : _fontList.indexOf(_fontFamily) + 1);
    });
    _resizeImage();
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
    _resizeImage();
  }

  bool isLineSpacing() {
    return _lineSpacing != 1.0;
  }

  void onTintToolTap() {
    setState(() {
      _tint = _tintList.elementAt((_tintList.indexOf(_tint) + 1) == _tintList.length ? 0 : _tintList.indexOf(_tint) + 1);
    });
  }

  void _onTextTap() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComposePage(_text),
      ),
    );
    if (result != null)
      setState(() {
        _text = result;
      });
    _resizeImage();
  }

  Future _onSaveTap() async {
    await Future.delayed(Duration(milliseconds: 100));
    DialogUtils.showProgressBar(context, "Processing Image");
    RenderRepaintBoundary boundary = _mainKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 5.0);
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    print("Image Captured");
    await ImagePickerSaver.saveFile(fileData: pngBytes);
    DialogUtils.hideProgressBar(context);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Image successfully saved to camera roll!"),
      ),
    );
  }

  void onOrientationToolTap() {
    setState(() {
      _heightFactor = _heightFactor == 0.7 ? 1.3 : 0.7;
    });
    _resizeImage();
  }

  void onBackgroundToolTap(String url) {
    _backgroundImage = null;
    setState(() {
      _backgroundUrl = url;
    });
  }

  void onBlurToolTap() {
    setState(() {
      _blur = _blur == 2.0 ? 0.0 : 2.0;
    });
  }

  bool isBlur() {
    return _blur != 0.0;
  }

  void onBackgroundToolFromGalleryTap(File image) {
    setState(() {
      this._backgroundImage = image;
    });
  }
}
