class Host {
  String? firstName;
  String? lastName;
  String? profileImage;

  Host({this.firstName, this.lastName, this.profileImage});

  factory Host.fromMap (Map<String, dynamic> data){
    return Host(
      firstName: data["firstName"]?.toString(),
      lastName: data["lastName"]?.toString(),
      profileImage: data["profileImage"]?.toString()
    );
  }
  Map<String, dynamic> toMap (){
    return {
      "firstName": firstName,
      "lastName": lastName,
      "profileImage": profileImage
    };
  }
}