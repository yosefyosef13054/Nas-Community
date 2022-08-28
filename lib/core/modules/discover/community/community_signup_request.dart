class CommunitySignUpRequestModel {
  String? communityCode;
  String? timezone;
  String? email;
  bool? isDirectSignUpEmail;
  PricingData? pricingData;

  CommunitySignUpRequestModel(
      {this.communityCode,
      this.timezone,
      this.email,
      this.isDirectSignUpEmail,
      this.pricingData});

  CommunitySignUpRequestModel.fromJson(Map<String, dynamic> json) {
    communityCode = json['communityCode'];
    timezone = json['timezone'];
    email = json['email'];
    isDirectSignUpEmail = json['isDirectSignUpEmail'];
    pricingData = json['pricing_data'] != null
        ? PricingData.fromJson(json['pricing_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['communityCode'] = communityCode;
    data['timezone'] = timezone;
    data['email'] = email;
    data['isDirectSignUpEmail'] = isDirectSignUpEmail;
    if (pricingData != null) {
      data['pricing_data'] = pricingData!.toJson();
    }
    return data;
  }
}

class PricingData {
  String? id;
  int? unitAmount;
  String? currency;

  PricingData({this.id, this.unitAmount, this.currency});

  PricingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitAmount = json['unit_amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_amount'] = unitAmount;
    data['currency'] = currency;
    return data;
  }
}
