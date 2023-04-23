import 'dart:convert';

class BaseModel extends Object {
  int? code;
  String? msg;

}

abstract class RecordModel extends Object {
  factory RecordModel.fromJson(Type classType, Map<String, dynamic> json) {
    // TODO: implement fromJson

    var className = classType.toString();
    if (className == 'AccountModel') {
      // return AccountModel.fromJson(json);
    } else if (className == 'VehicleModel') {
      // return VehicleModel.fromJson(json);
    }
    AssertionError('必须实现泛型特有的构造方法');
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson();
}

/// 列表页面的model
class RecordsDataModel<Record extends RecordModel> {
  RecordsDataModel({
    this.total = 0,
    this.size = 0,
    this.current = 0,
    this.records,
    this.pages = 1,
  });

  int total;
  int size;
  int current;
  List<Record>? records;
  int pages;

  factory RecordsDataModel.fromRawJson(String str) =>
      RecordsDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecordsDataModel.fromJson(Map<String, dynamic> json) {
    return RecordsDataModel(
      total: json["total"],
      size: json["size"],
      current: json["current"],
      records: List<Record>.from(
          json["records"].map((x) => RecordModel.fromJson(Record, x))),
      pages: json["pages"],
    );
  }

  Map<String, dynamic> toJson() => {
        "total": total,
        "size": size,
        "current": current,
        "records": records == null
            ? null
            : List<dynamic>.from(records!.map((x) => x.toJson())),
        "pages": pages,
      };
}
