// import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'crowtech_base.dart';

part 'crowtech_basepage.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class CrowtechBasePage<T extends CrowtechBase> {
  DateTime? created;
  int? startIndex;

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
    return "${T.toString()} ${super.toString()} $startIndex ${items != null ? items!.length : 0} $totalItems $processingTime ";
  }
}
