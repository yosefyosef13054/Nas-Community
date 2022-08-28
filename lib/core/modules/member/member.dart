import 'package:nas_academy/core/modules/common/country.dart';
import 'package:nas_academy/core/modules/community/subs/subscription.dart';
import 'package:nas_academy/core/modules/community/active_community/thumb_nail_image.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/utils/data_type.dart';

class Member {
  String? id;
  String? countryId;
  DateTime? lastModifiedTimeStamp;
  String? firstName;
  int? learnerId;
  DateTime? createdAt;
  String? lastName;
  bool? isActive;
  String? description;
  String? profileImage;
  String? subtitlePreference;
  LearnerCountry? learnerCountry;
  List<SocialMedia> socialMedia;
  List<Subscription> subscriptions;
  List<String> joinedCommunityDate;
  List<String> creations;
  String? spotlightLink;
  String? longDescription;
  String followersCount;
  String? country;
  List<String> interests;
  List<String> skills;
  MemberRole role;
  String? telegramUsername;
  String? email;

  /// TRAINER
  String? calendlylink;
  List<String> trainerInterests;
  List<String> milestones;
  List<String> testimonials;
  String? trainerId;
  String? v;
  String? corporateEmail;
  bool? corporateEmailSameAsLoginEmail;
  String? title;
  String? whatsAppNumber;
  bool? whatsAppNumberSameAsPhoneNumber;
  ThumbnailImgData? meetFacilitatorImg;
  String? zoomLink;

  Member({
    this.id,
    this.countryId,
    this.lastModifiedTimeStamp,
    this.firstName,
    this.learnerId,
    this.createdAt,
    this.lastName,
    this.isActive,
    this.description,
    this.profileImage,
    this.subtitlePreference,
    this.learnerCountry,
    this.followersCount = "0",
    this.spotlightLink,
    this.longDescription,
    this.country,
    this.telegramUsername,
    this.socialMedia = const [],
    this.subscriptions = const [],
    this.joinedCommunityDate = const [],
    this.creations = const [],
    this.interests = const [],
    this.skills = const [],
    required this.role,
    this.email,

    /// TRAINER
    this.trainerId,
    this.title,
    this.calendlylink,
    this.corporateEmail,
    this.corporateEmailSameAsLoginEmail,
    this.meetFacilitatorImg,
    this.milestones = const [],
    this.testimonials = const [],
    this.trainerInterests = const [],
    this.v,
    this.whatsAppNumber,
    this.whatsAppNumberSameAsPhoneNumber,
    this.zoomLink,

  });

  factory Member.fromMap(Map<String, dynamic> data, MemberRole role) {
    return Member(
      lastModifiedTimeStamp: DateTime.tryParse(data["lastModifiedTimeStamp"].toString()),
      createdAt: DateTime.tryParse(data["createdAt"].toString()),
      description: data["description"]?.toString(),
      id: (data["_id"] ?? data["id"])?.toString(),
      isActive: data["isActive"] == true,
      profileImage: data["profileImage"],
      lastName: data["lastName"],
      firstName: data["firstName"],
      learnerId: data["learnerId"],
      countryId: data["countryId"]?.toString(),
      subscriptions: List.from(data["subscriptions"] ?? []).map((e) => Subscription.fromMap(e)).toList(),
      creations: List.from(data["creations"] ?? []).map((e) => e.toString()).toList(),
      joinedCommunityDate: List.from(data["joinedCommunityDate"] ?? []).map((e) => e.toString()).toList(),
      learnerCountry: data["learnerCountry"] != null ? LearnerCountry.fromMap(data["learnerCountry"]) : null,
      socialMedia: List.from(data['socialMedia'] ?? []).map((e) => SocialMedia.fromMap(e)).where((element) => element.link != null && element.iconLink != null).toList(),
      subtitlePreference: data["subtitlePreference"]?.toString(),
      followersCount: data["followersCount"]?.toString() ?? "0",
      longDescription: data["longDescription"] ?? "",
      spotlightLink: data["spotlightLink"],
      country : data["country"],
      interests: Map.from(data["niche"] ?? {}).entries.map((e) => e.key.toString()).toList(),
      skills : data["otherNiche"] != null && data["otherNiche"] is Iterable ? List.from(data["otherNiche"] ?? []) : [],
      role: role,
      email: data["email"]?.toString(),
      telegramUsername: data["telegramUsername"]?.toString(),
      /// TRAINER
      title: data["title"]?.toString(),
      v: data["__v"]?.toString(),
      calendlylink: data['calendlyLink'] ?? data["calendlylink"]?.toString(),
      corporateEmail: data["corporateEmail"]?.toString(),
      corporateEmailSameAsLoginEmail: data["corporateEmailSameAsLoginEmail"] == true,
      meetFacilitatorImg: data["meetFacilitatorImg"] != null? ThumbnailImgData.fromMap(data["meetFacilitatorImg"]) : null,
      trainerId: data["trainerId"]?.toString(),
      whatsAppNumber: data["whatsAppNumber"]?.toString(),
      whatsAppNumberSameAsPhoneNumber: data["whatsAppNumberSameAsPhoneNumber"] == true,
      zoomLink: data["zoomLink"]?.toString(),
      milestones: List.from(data["milestones"] ?? []).map((e) => e.toString()).toList(),
      testimonials: List.from(data["testimonials"] ?? []).map((e) => e.toString()).toList(),
      trainerInterests: List.from(data["interests"] ?? []).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "countryId": countryId,
      "lastModifiedTimeStamp": lastModifiedTimeStamp.toString(),
      "firstName": firstName,
      "learnerId": learnerId,
      "createdAt": createdAt,
      "lastName": lastName,
      "isActive": isActive,
      "creations": creations.map((e) => e.toString()).toList(),
      "description": description,
      "profileImage": profileImage,
      "socialMedia": socialMedia.map((e) => e.toMap()).toList(),
      "subtitlePreference": subtitlePreference,
      "learnerCountry": learnerCountry?.toMap(),
      "subscriptions": subscriptions.map((e) => e.toMap()).toList(),
      "joinedCommunityDate": joinedCommunityDate.map((e) => e.toString()).toList(),
      "longDescription": longDescription,
      "spotlightLink": spotlightLink,
      "followersCount": followersCount,
      "country": country,
      "email": email,
      "telegramUsername" : telegramUsername,

      /// TRAINER
      "calendlylink": calendlylink,
      "interests": trainerInterests.map((e) => e.toString()).toList(),
      "milestones": milestones.map((e) => e.toString()).toList(),
      "testimonials": testimonials.map((e) => e.toString()).toList(),
      "trainerId": trainerId,
      "__v": v,
      "corporateEmail": corporateEmail,
      "corporateEmailSameAsLoginEmail": corporateEmailSameAsLoginEmail,
      "title": title,
      "whatsAppNumber": whatsAppNumber,
      "whatsAppNumberSameAsPhoneNumber": whatsAppNumberSameAsPhoneNumber,
      "meetFacilitatorImg": meetFacilitatorImg?.toMap(),
      "zoomLink": zoomLink,
    };
  }




  bool isNew (){
    if(joinedCommunityDate.isNotEmpty){
      DateTime? joinDate = DateTime.tryParse(joinedCommunityDate.last);
      if(joinDate != null){
        return DateTime.now().difference(joinDate).inDays < 7;
      }else {
        return false;
      }
    }else {
      return false;
    }
  }


  DateTime? joiningDate (){
    if(joinedCommunityDate.isNotEmpty){
      return DateTime.tryParse(joinedCommunityDate.last);
    }
    return null;
  }
}



