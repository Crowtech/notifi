// import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'crowtech_base.dart';

part 'crowtech_basepage.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class CrowtechBasePage<T extends CrowtechBase> {
  DateTime? created = DateTime.now().toUtc();
  int? startIndex = 0;

  List<T>? items;

  int? totalItems = 0;
  int? processingTime = 0;

  @JsonKey(includeFromJson: false, includeToJson: false)
  T Function(Map<String, dynamic>)? itemFromJson;

  CrowtechBasePage(
      {this.created,
      this.startIndex,
      this.items,
      this.itemFromJson,
      this.totalItems,
      this.processingTime});

  CrowtechBasePage<T> fromJson(Map<String, dynamic> json) {
    try {
      created = json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String);
      startIndex = (json['startIndex'] as num?)?.toInt() ?? 0;
      totalItems = (json['totalItems'] as num?)?.toInt() ?? 0;
      processingTime = (json['processingTime'] as num?)?.toInt() ?? 0;
      items = (json['items'] as List<dynamic>)
          .map((e) => itemFromJson!.call(e as Map<String, dynamic>))
          .toList();
    } on Exception catch (e) {
      print(e.toString());
      print("Nothing in Items");
    }

    return this;
  }

  @override
  String toString() {
    String ret =
        "${T.toString()}  i:$startIndex s:${items != null ? items!.length : 0} total:$totalItems ns:$processingTime \n";
    if ((items != null) && (items!.isNotEmpty)) {
      for (int i = 0; i < items!.length; i++) {
        ret += "${items![i].toString()}\n";
      }
    }
    return ret;
  }
}
