import 'package:json_annotation/json_annotation.dart';

import 'package:logger/logger.dart';
import 'package:notifi/entities/paging_data_item.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/resource_type.dart';

import '../jwt_utils.dart';
import 'crowtech_object.dart';
part 'resource.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

@JsonSerializable(explicitToJson: true)
class Resource extends CrowtechObject implements PagingDataItem  {
  static String className = "Resource";
  static String tablename = className.toLowerCase();

  int pageId=0;
  String? description;
  String? location;
  String? devicecode;
  String? avatarUrl;
  GPS? gps;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;

  @JsonKey(includeFromJson: false, includeToJson: false)
  ResourceType resourceType;

  Resource(
      {super.orgid,
      super.id,
      super.code,
      super.created,
      super.updated,
      super.name,
      this.description,
      this.location,
      this.devicecode,
      this.avatarUrl,
      this.gps,
      this.selected=false,
      this.resourceType=ResourceType.unknown,
      });

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ResourceToJson(this);

  @override
  Resource fromJson(Map<String, dynamic> json) {
    return Resource.fromJson(json);
  }

  @override
  String toString() {
    return "Resource=>${super.toString()} $description, $location, $devicecode $gps";
  }

  String getAvatarUrl() {
    if (avatarUrl == null) {
      return "https://gravatar.com/avatar/${generateMd5("unknown@unknown.com")}";
    } else {
      print("avatarUrl for $code is $avatarUrl");
      return avatarUrl!;
    }
  }
  
  @override
  int get pageId => pageId;
}
