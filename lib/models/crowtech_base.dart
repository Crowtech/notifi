import 'package:json_annotation/json_annotation.dart';

//part 'crowtech_base.g.dart';

@JsonSerializable(explicitToJson: true)
abstract class CrowtechBase<T> {
  static String className = "CrowtechBase";
  static String tablename = className.toLowerCase();

  int? orgid;
  int? id;
  DateTime? created = DateTime.now().toUtc();
  String? code;

  CrowtechBase({this.orgid,this.id, this.created, this.code}); 

  //CrowtechBase.namedConstructor({this.id, required this.created, this.code});

   T fromJson(Map<String, dynamic> json);
  static Type typeOf<T>() => T;

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return "$orgid, $id, $created, $code ";
  }
}
