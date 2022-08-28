import 'package:nas_academy/core/modules/user/learner.dart';

class User {
  String? id;
  bool learnerRole;
  bool instructorRole;
  bool adminRole;
  Learner learner;
  String? email;
  int userId;
  String? modifiedOn;
  String? status;
  String? createdAt;
  bool creatorRole;
  String? updatedAt;
  bool isActive;
  String? country;

  User({
    required this.id,
    required this.learnerRole,
    required this.instructorRole,
    required this.adminRole,
    required this.learner,
    required this.email,
    required this.userId,
    required this.modifiedOn,
    required this.status,
    required this.createdAt,
    required this.creatorRole,
    required this.updatedAt,
    required this.isActive,
    required this.country
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['_id'] ?? "",
      learnerRole: data['learner_role'] == true,
      instructorRole: data['instructor_role'] == true,
      adminRole: data['admin_role'] == true,
      learner: data['learner'] != null ? Learner.fromMap(data['learner']) : Learner(),
      email: data['email']  ?? "",
      userId: data['user_id'] ?? 0,
      modifiedOn: data['modified_on'] ?? "",
      status: data['status'] ?? "",
      createdAt: data['createdAt'] ?? "",
      creatorRole: data['creator_role'] == true,
      updatedAt: data['updatedAt'] ?? "",
      isActive: data['isActive'] == true,
      country: data['country']?.toString()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "learner_role": learnerRole,
      "instructor_role": instructorRole,
      "admin_role": adminRole,
      "learner": learner.toMap(),
      "email": email,
      "user_id": userId,
      "modified_on": modifiedOn.toString(),
      "status": status,
      "createdAt": createdAt.toString(),
      "creator_role": creatorRole,
      "isActive": isActive,
      "updatedAt": updatedAt.toString(),
      "country" : country,

    };
  }
}

