import 'package:nas_academy/core/modules/user/sub/address.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/modules/user/sub/extra_info.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/utils/data_types.dart';

class Learner {
  String? id;
  String? learnerId;
  String? createdAt;
  bool? isActive;
  String? firstName;
  String? phoneNumber;
  String? lastModifiedTimeStamp;
  String? countryId;
  String? lastName;
  String? email;
  String? primaryContact;
  String? v;
  String? description;
  String? longDescription;
  String? profileImage;
  bool? corporateEmailSameAsLoginEmail;
  String? subtitlePreference;
  bool? whatsAppNumberSameAsPhoneNumber;
  bool? showWelcomeToClassroomModal;
  bool? showWelcomeToCourseVideosModal;
  bool? showWelcomeToLpModal;
  Address? address;
  ExtraInfo? extraInfo;
  bool? hasSubscribedToCommentEmails;
  String? modifiedBy;
  String? modifiedDate;
  String? modifiedReason;
  List<SocialMedia> socialMedia;
  List<String> achievements;
  List<String> creations;
  List<String> knowledgeSource;
  String? lastViewedCourseTimeStamp;
  String? bio;
  List<Contact> contactUsernames;
  int? followersCount;
  List<String> secondaryWallets;
  String? lastViewedCourse;
  String? walletType;
  List<String> interests;
  List<SpotLight> spotlights;
  List<String> skills;
  String? country;


  Learner({
    this.id,
    this.learnerId,
    this.createdAt,
    this.isActive,
    this.firstName,
    this.phoneNumber,
    this.lastModifiedTimeStamp,
    this.countryId,
    this.lastName,
    this.email,
    this.v,
    this.corporateEmailSameAsLoginEmail,
    this.description,
    this.longDescription,
    this.profileImage,
    this.subtitlePreference,
    this.whatsAppNumberSameAsPhoneNumber,
    this.showWelcomeToClassroomModal,
    this.showWelcomeToCourseVideosModal,
    this.showWelcomeToLpModal,
    this.address,
    this.extraInfo,
    this.hasSubscribedToCommentEmails,
    this.modifiedBy,
    this.modifiedDate,
    this.modifiedReason,
    this.lastViewedCourseTimeStamp,
    this.followersCount,
    this.bio,
    this.walletType,
    this.lastViewedCourse,
    this.country,
    this.primaryContact,
    this.achievements = const [],
    this.socialMedia = const [],
    this.knowledgeSource = const [],
    this.creations = const [],
    this.interests = const [],
    this.contactUsernames = const [],
    this.secondaryWallets = const [],
    this.spotlights = const [],
    this.skills = const []
  });

  factory Learner.fromMap(Map<String, dynamic> data) {
    return Learner(
      id: data['_id'],
      learnerId: data['learnerId']?.toString(),
      createdAt: data['createdAt']?.toString(),
      isActive: data['isActive'] == true,
      firstName: data['firstName']?.toString(),
      phoneNumber: data["whatsappNumber"]?.toString() ?? data['phoneNumber']?.toString(),
      lastModifiedTimeStamp: data['lastModifiedTimeStamp']?.toString(),
      countryId: data['countryId']?.toString(),
      lastName: data['lastName']?.toString(),
      email: data['email']?.toString(),
      v: data['__v']?.toString(),
      corporateEmailSameAsLoginEmail: data['corporateEmailSameAsLoginEmail'] == true,
      description: data['description']?.toString(),
      longDescription: data['longDescription']?.toString(),
      profileImage: data['profileImage']?.toString(),
      subtitlePreference: data['subtitlePreference']?.toString(),
      whatsAppNumberSameAsPhoneNumber: data['whatsAppNumberSameAsPhoneNumber'] == true,
      showWelcomeToClassroomModal: data['showWelcomeToClassroomModal'] == true,
      showWelcomeToCourseVideosModal: data['showWelcomeToCourseVideosModal'] == true,
      showWelcomeToLpModal: data['showWelcomeToLpModal']== true,
      address: data['address'] != null ? Address.fromMap(data['address']) : null,
      extraInfo: data['extraInfo'] != null ? ExtraInfo.fromJson(data['extraInfo']) : null,
      hasSubscribedToCommentEmails: data['hasSubscribedToCommentEmails'] == true,
      modifiedBy: data['modifiedBy']?.toString(),
      modifiedDate: data['modifiedDate']?.toString(),
      modifiedReason: data['modifiedReason']?.toString(),
      primaryContact: data["primaryContact"] ?? ContactType.email.name,
      socialMedia: List.from(data['socialMedia'] ?? []).map((e) => SocialMedia.fromMap(e)).toList(),
      knowledgeSource: List.from(data['knowledgeSource'] ?? []).map((e) => e.toString()).toList(),
      followersCount: int.tryParse(data["followersCount"].toString()),
      bio: data["bio"]?.toString(),
      contactUsernames: List.from(data["contactUsernames"] ?? []).map((e) => Contact.fromMap(e)).toList(),
      lastViewedCourse: data["lastViewedCourse"]?.toString(),
      lastViewedCourseTimeStamp: data["lastViewedCourseTimeStamp"]?.toString(),
      secondaryWallets: List.from(data["secondaryWallets"] ?? []).map((e) => e.toString()).toList(),
      spotlights: List.from(data["spotlights"] ?? []).map((e) => SpotLight.fromMap(e)).toList(),
      walletType: data["walletType"]?.toString(),
      interests: List.from(data["interests"] ?? []).map((e) => e.toString()).toList(),
      skills: List.from(data["skills"] ?? []).map((e) => e.toString()).toList(),
      country: data["country"]?.toString(),
      /// TODO : check for the shape of object inside each list once they're not empty
      achievements: List.from(data['achievements'] ?? []).map((e) => e.toString()).toList(),
      creations: List.from(data['creations'] ?? []).map((e) => e.toString()).toList(),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "whatsappNumber": phoneNumber,
      "createdAt": createdAt?.toString(),
      "countryId": countryId,
      "isActive": isActive,
      "lastModifiedTimeStamp": lastModifiedTimeStamp,
      "learnerId": learnerId,
      "email": email,
      "lastName": lastName,
      "firstName": firstName,
      "__v": v,
      "achievements": achievements.map((e) => e.toString()).toList(),
      "corporateEmailSameAsLoginEmail": corporateEmailSameAsLoginEmail,
      "creations": creations.map((e) => e.toString()).toList(),
      "description": description,
      "hasSubscribedToCommentEmails": hasSubscribedToCommentEmails,
      "knowledgeSource": knowledgeSource.map((e) => e.toString()).toList(),
      "longDescription": longDescription,
      "profileImage": profileImage,
      "showWelcomeToClassroomModal": showWelcomeToClassroomModal,
      "showWelcomeToCourseVideosModal": showWelcomeToCourseVideosModal,
      "showWelcomeToLpModal": showWelcomeToLpModal,
      "socialMedia": socialMedia.map((e) => e.toMap()).toList(),
      "subtitlePreference": subtitlePreference,
      "whatsAppNumberSameAsPhoneNumber": false,
      "country" : country,
      "lastViewedCourseTimeStamp": lastViewedCourseTimeStamp,
      "bio": bio,
      "primaryContact" : primaryContact,
      "contactUsernames": contactUsernames.map((e) => e.toMap()).toList(),
      "skills" : skills.map((e) => e.toString()).toList(),
      "followersCount": followersCount.toString(),
      "interests": interests.map((e) => e.toString()).toList(),
      "spotlights": spotlights.map((e) => e.toMap()).toList(),
      "secondaryWallets": secondaryWallets.map((e) => e.toString()).toList(),
      "lastViewedCourse": lastViewedCourse.toString(),
      "walletType": walletType,

    };
  }
}
