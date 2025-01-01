import 'package:json_annotation/json_annotation.dart';
import 'crowtech_base.dart';

part 'crowtech_object.g.dart';

@JsonSerializable(explicitToJson: true)
class CrowtechObject extends CrowtechBase<CrowtechObject> {
  static String className = "CrowtechObject";
  static String tablename = className.toLowerCase();

  DateTime? updated = DateTime.now().toUtc();
  String? name;

  CrowtechObject(
      {
      super.id,
      super.code,
      super.created,
      this.name,
      this.updated});


  factory CrowtechObject.fromJson(Map<String, dynamic> json) =>
      _$CrowtechObjectFromJson(json);
  Map<String, dynamic> toJson() => _$CrowtechObjectToJson(this);

  @override
  CrowtechObject fromJson(Map<String, dynamic> json) {
    return CrowtechObject.fromJson(json);
  }

  @override
  String toString() {
    return "${super.toString()} $updated $name ";
  }
}
