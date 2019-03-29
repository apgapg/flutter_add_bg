import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_bg/model/background_model.dart';
import 'package:image_picker/image_picker.dart';

typedef void OnTap(String url);
typedef void OnTapGallery(File image);

class BackgroundBar extends StatefulWidget {
  final OnTap onTap;

  final OnTapGallery onTapGallery;

  BackgroundBar(this.onTap, this.onTapGallery);

  @override
  _BackgroundBarState createState() => _BackgroundBarState();
}

class _BackgroundBarState extends State<BackgroundBar> {
  final _json =
      '[{"url":"https://ayushpgupta.site/bg/images/b1.png"},{"url":"https://ayushpgupta.site/bg/images/b2.png"},{"url":"https://ayushpgupta.site/bg/images/b3.jpg"},{"url":"https://ayushpgupta.site/bg/images/b4.jpeg"},{"url":"https://ayushpgupta.site/bg/images/b5.jpg"},{"url":"https://ayushpgupta.site/bg/images/b6.jpg"},{"url":"https://ayushpgupta.site/bg/images/b7.jpg"}]';

  List _list;

  @override
  void initState() {
    super.initState();
    BackgroundModel _model = BackgroundModel.fromJson(json.decode(_json));
    this._list = new List();
    this._list.add("asset");

    this._list.addAll(_model.list);
  }

  @override
  Widget build(BuildContext context) {
    assert(_list != null);
    return Container(
      height: 80.0,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                height: 60.0,
                width: 80.0,
                alignment: Alignment.center,
                child: _list[index] is BackgroundItem
                    ? CachedNetworkImage(
                        imageUrl: _list[index].url,
                        fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(
                        height: 24.0,
                        width: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                        ),
                      ),
                      )
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.image,
                      size: 20.0,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      "GALLERY",
                      style: TextStyle(fontSize: 12.0),
                    )
                  ],
                      ),
              ),
              onTap: () {
                _list[index] is BackgroundItem ? widget.onTap(_list[index].url) : getImage();
              },
            ),
          );
        },
        itemCount: _list.length,
      ),
    );
  }

  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) widget.onTapGallery(image);
  }
}
