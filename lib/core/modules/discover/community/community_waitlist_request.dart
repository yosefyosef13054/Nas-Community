class CommunityWaitlistRequestModel {
  String? email;
  String? communityCode;
  String? phoneNumber;
  String? country;
  String? device;

  CommunityWaitlistRequestModel(
      {this.email,
      this.communityCode,
      this.phoneNumber,
      this.country,
      this.device});

  CommunityWaitlistRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    communityCode = json['communityCode'];
    phoneNumber = json['phoneNumber'];
    country = json['country'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['communityCode'] = communityCode;
    data['phoneNumber'] = phoneNumber;
    data['country'] = country;
    data['device'] = device;
    return data;
  }
}
