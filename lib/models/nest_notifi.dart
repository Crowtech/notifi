import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/entities/paging_data_item.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nest_notifi_type.dart';

import '../jwt_utils.dart';
import 'crowtech_object.dart';
 part 'nest_notifi.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class NestNotifi extends CrowtechObject implements PagingDataItem {
  static String className = "NestNotifi";
  static String tablename = className.toLowerCase();

  final int _pageId = 0;

  String? description;
  String? imageUrl;

  GPS? gps;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;

  NestNotifiType? nestNotifiType;


  NestNotifi({
    super.id,
    super.code,
    super.created,
    super.active,
    super.updated,
    super.name,
    this.description,
    this.imageUrl,
    this.gps,
    this.selected = false,
    this.nestNotifiType = NestNotifiType.undefined,
  });

  factory NestNotifi.fromJson(Map<String, dynamic> json) =>
      _$NestNotifiFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NestNotifiToJson(this);

  @override
  NestNotifi fromJson(Map<String, dynamic> json) {
    return NestNotifi.fromJson(json);
  }

  @override
  String toString() {
    return "NestNotifi=>${super.toString()} $description, $nestNotifiType, $imageUrl $gps $selected";
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
  bool operator ==(Object other) =>
      other is NestNotifi &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => code.hashCode;

    @override
  int get pageId => _pageId;
}
