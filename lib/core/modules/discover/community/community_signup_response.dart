class CommunitySignUpResponseModel {
  int? learnerId;
  bool? isFree;
  String? accessToken;
  String? id;

  CommunitySignUpResponseModel(
      {this.learnerId, this.isFree, this.accessToken, this.id});

  CommunitySignUpResponseModel.fromJson(Map<String, dynamic> json) {
    learnerId = json['learnerId'];
    isFree = json['is_free'];
    accessToken = json['access_token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['learnerId'] = learnerId;
    data['is_free'] = isFree;
    data['access_token'] = accessToken;
    data['id'] = id;
    return data;
  }
}
