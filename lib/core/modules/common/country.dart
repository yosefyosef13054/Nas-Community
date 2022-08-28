class LearnerCountry {

  String? country;
  String? countryCode;
  String? longCountryCode;


  LearnerCountry({this.country, this.countryCode, this.longCountryCode});

  factory LearnerCountry.fromMap (Map<String, dynamic> data){
    return LearnerCountry(
      country: data["country"].toString(),
      countryCode: data["countryCode"].toString(),
      longCountryCode: data["longCountryCode"].toString()
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "country": "Pakistan",
      "countryCode": "PK",
      "longCountryCode": "PAK"
    };
  }
}