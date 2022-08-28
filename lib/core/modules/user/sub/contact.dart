class Contact {
  String? type;
  String? username;

  Contact({this.type, this.username});

  factory Contact.fromMap (Map<String, dynamic> data){
    return Contact(
      type: data["type"]?.toString(),
      username: data["username"]?.toString(),
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "type" : type,
      "username" : username
    };
  }
}