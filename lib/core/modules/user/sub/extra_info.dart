import 'package:nas_academy/core/modules/user/sub/extra_info_item.dart';

class ExtraInfo {
  ExtraInfoItem? laptop;
  ExtraInfoItem? editingSoftware;
  ExtraInfoItem? camera;
  String? id;

  ExtraInfo({
    this.laptop,
    this.editingSoftware,
    this.camera,
    this.id,
  });

  factory ExtraInfo.fromJson(dynamic data) {
    return ExtraInfo(
      laptop: data['laptop'] != null ? ExtraInfoItem.fromJson(data['laptop']) : null,
      editingSoftware: data['editingSoftware'] != null ? ExtraInfoItem.fromJson(data['editingSoftware']) : null,
      camera: data['camera'] != null ? ExtraInfoItem.fromJson(data['camera']) : null,
      id: data['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (laptop != null) {
      map['laptop'] = laptop?.toJson();
    }
    if (editingSoftware != null) {
      map['editingSoftware'] = editingSoftware?.toJson();
    }
    if (camera != null) {
      map['camera'] = camera?.toJson();
    }
    map['_id'] = id;
    return map;
  }
}
