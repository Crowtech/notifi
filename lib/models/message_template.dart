import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/entities/paging_data_item.dart';

import 'crowtech_object.dart';
 part 'message_template.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class MessageTemplate extends CrowtechObject implements PagingDataItem {
  static String className = "MessageTemplate";
  static String tablename = className.toLowerCase();
  static String PREFIX = "MTL_";

  final int _pageId = 0;

  String? description;


  MessageTemplate({
    super.id,
    super.code,
    super.created,
    super.active,
    super.updated,
    super.name,
    this.description,
  });

  factory MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MessageTemplateToJson(this);

  @override
  MessageTemplate fromJson(Map<String, dynamic> json) {
    return MessageTemplate.fromJson(json);
  }

  @override
  String toString() {
    return "MessageTemplate=>${super.toString()} $description";
  }

 

  @override
  bool operator ==(Object other) =>
      other is MessageTemplate &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => code.hashCode;

    @override
  int get pageId => _pageId;
}
