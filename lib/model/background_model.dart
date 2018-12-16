import 'package:json_annotation/json_annotation.dart';

part 'background_model.g.dart';

class BackgroundModel {
  List<BackgroundItem> list;

  BackgroundModel._internal(this.list);

  factory BackgroundModel.fromJson(dynamic json) {
    return BackgroundModel.fromMapList(list: json as List);
  }

  factory BackgroundModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return BackgroundItem.fromJson(item);
    }).toList();

    return BackgroundModel._internal(items);
  }
}

@JsonSerializable()
class BackgroundItem {
  @JsonKey(name: 'url')
  final String url;

  BackgroundItem(this.url);

  factory BackgroundItem.fromJson(Map<String, dynamic> json) => _$BackgroundItemFromJson(json);
}
