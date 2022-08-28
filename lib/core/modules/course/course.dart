

class Course {
  String id;

  Course ({required this.id});

  factory Course.fromMap (Map<String, dynamic> data){
    return Course(id: data["id"]);
  }


  Map<String, dynamic> toMap (){
    return {
      "id" : id
    };
  }
}