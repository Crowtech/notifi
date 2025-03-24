import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/entities/paging_data_item.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestalert_type.dart';
import 'package:notifi/models/resource_type.dart';

import '../jwt_utils.dart';
import 'crowtech_object.dart';
part 'nest_alert.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class NestAlert extends CrowtechObject implements PagingDataItem {
  static String className = "NestAlert";
  static String tablename = className.toLowerCase();

  int _pageId = 0;
  String? subject;
  String? description;
  String? image_url;

  GPS? gps;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;

  NestAlertType? nestAlertType;
  String? imageUrl;


  NestAlert({
    super.orgid,
    super.id,
    super.code,
    super.created,
    super.updated,
    super.name,
    this.description,
    this.subject,
    this.imageUrl,
    this.gps,
    this.selected = false,
    this.nestAlertType = NestAlertType.unknown,
  });

  factory NestAlert.fromJson(Map<String, dynamic> json) =>
      _$NestAlertFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NestAlertToJson(this);

  @override
  NestAlert fromJson(Map<String, dynamic> json) {
    return NestAlert.fromJson(json);
  }

  @override
  String toString() {
    return "NestAlert=>${super.toString()} $description, $nestAlertType, $imageUrl $gps $selected";
  }

  String getImageUrl() {
    if (imageUrl == null) {
      return "https://gravatar.com/avatar/${generateMd5("unknown@unknown.com")}";
    } else {
      print("imageUrl for $code is $imageUrl");
      return imageUrl!;
    }
  }

  @override
  int get pageId => _pageId;

  @override
  bool operator ==(Object other) =>
      other is NestAlert &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => id.hashCode;
}
