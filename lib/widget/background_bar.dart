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
      '[{"url":"https://firebasestorage.googleapis.com/v0/b/connect-it-6bc24.appspot.com/o/extras%2Fpexels-photo-1054289.jpeg?alt=media&token=1b997ad5-f4b8-4e63-bdc6-99a5b108effa"},{"url":"https://firebasestorage.googleapis.com/v0/b/connect-it-6bc24.appspot.com/o/extras%2Fpexels-photo-4173624.jpeg?alt=media&token=81f3df80-2d91-4668-9486-f40338217f61"},{"url":"https://firebasestorage.googleapis.com/v0/b/connect-it-6bc24.appspot.com/o/extras%2FBG2_Desktop_1280x720.jpg?alt=media&token=3b374a79-5a36-49a5-ba07-5e41d5bc6de9"},{"url":"https://firebasestorage.googleapis.com/v0/b/connect-it-6bc24.appspot.com/o/extras%2Fmilky-way-2695569_960_720.jpg?alt=media&token=9de95687-3061-4038-b16c-0fc6eccda0ff"}]';

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
                        placeholder: (context, url) => Container(
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
                _list[index] is BackgroundItem
                    ? widget.onTap(_list[index].url)
                    : getImage();
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
