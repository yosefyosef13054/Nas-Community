class Interests {
  String? communityCode;
  List<String> interests;

  Interests({
    this.communityCode,
    this.interests = const []});
  
  
  factory Interests.fromMap (Map<String, dynamic> data, String? code){
    return Interests(
      interests: List.from(data[code] ?? []).map((e) => e.toString()).toList(),
      communityCode: code
    );
  }


  Map<String, dynamic> toMap (){
    return {
      "$communityCode" : interests.map((e) => e.toString()).toList()
    };
  }
}