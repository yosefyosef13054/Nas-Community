
class ExtraInfoItem {

  bool? hasItem;
  String? type;
  String? id;


  ExtraInfoItem({
    required this.hasItem,
    required this.type,
    required this.id,
  });

  factory ExtraInfoItem.fromJson(dynamic data) {
    return ExtraInfoItem(
      hasItem : data['hasItem'] == true,
      type : data['type'] ?? "",
      id : data['_id'] ?? "",
    );
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasItem'] = hasItem;
    map['type'] = type;
    map['_id'] = id;
    return map;
  }
}