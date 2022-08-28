import 'package:nas_academy/core/utils/assets.dart';

enum AuthType { facebook, google, apple, email }
enum InputType { text, date, number, checkbox, radio, multiSelectModal }
enum UploadType { profileImages, spotlights }
enum ContactType { email, whatsapp, whatsappBusiness, telegram, discord }

enum SocialMediaTypes {
  discord,
  linkedIn,
  openSea,
  snapChat,
  tiktok,
  twitter,
  facebook,
  instagram,
  other
}

enum NotificationType {
  completeApplicationForm,
  applicationApproved,
  completeTodos,
  firstEventAttendance,
  sevenDayEventAttendance,
  eventAdded,
  eventStartingNow,
  eventStartingIn3Hours,
  eventStartingIn10Minutes,
  newMembersLast14Days,
  resourceAdded,
  meetExpertLast28Days,
  formCompletedPaymentMissing,
  other
}


enum ApplicationStatusType {pending, cancelled, current, inactive, rejected}

String authTypeToString(AuthType auth) {
  switch (auth) {
    case AuthType.email:
      return "Email";
    case AuthType.facebook:
      return "facebook";
    case AuthType.google:
      return "google";
    case AuthType.apple:
      return "apple";
  }
}

String contactIcon(ContactType type) {
  switch (type) {
    case ContactType.email:
      return Assets.email;
    case ContactType.discord:
      return Assets.discordInActive;
    case ContactType.whatsapp:
      return Assets.wa;
    case ContactType.whatsappBusiness:
      return Assets.wa;
    case ContactType.telegram:
      return Assets.telegram;
  }
}

String socialMediaTypesToString(SocialMediaTypes type) {
  switch (type) {
    case SocialMediaTypes.snapChat:
      return "Snapchat";
    case SocialMediaTypes.discord:
      return "Discord";
    case SocialMediaTypes.linkedIn:
      return "LinkedIn";
    case SocialMediaTypes.openSea:
      return "OpenSea";
    case SocialMediaTypes.tiktok:
      return "TikTok";
    case SocialMediaTypes.facebook:
      return "Facebook";
    case SocialMediaTypes.instagram:
      return "Instagram";
    case SocialMediaTypes.twitter:
      return "Twitter";
      case SocialMediaTypes.other:
      return "Other";
  }
}

String socialMediaActiveIcon(SocialMediaTypes type) {
  switch (type) {
    case SocialMediaTypes.snapChat:
      return Assets.snapChatActive;
    case SocialMediaTypes.discord:
      return Assets.discordActive;
    case SocialMediaTypes.linkedIn:
      return Assets.linkedinActive;
    case SocialMediaTypes.openSea:
      return Assets.openSeaActive;
    case SocialMediaTypes.tiktok:
      return Assets.tikTokActive;
    case SocialMediaTypes.facebook:
      return Assets.facebookActive;
    case SocialMediaTypes.instagram:
      return Assets.instaActive;
    case SocialMediaTypes.twitter:
      return Assets.twitterActive;
      case SocialMediaTypes.other:
      return Assets.error;
  }
}

String socialMediaInActiveIcon(SocialMediaTypes type) {
  switch (type) {
    case SocialMediaTypes.snapChat:
      return Assets.snapChatInActive;
    case SocialMediaTypes.discord:
      return Assets.discordInActive;
    case SocialMediaTypes.linkedIn:
      return Assets.linkedinInActive;
    case SocialMediaTypes.openSea:
      return Assets.openSeaInActive;
    case SocialMediaTypes.tiktok:
      return Assets.tikTokInActive;
    case SocialMediaTypes.facebook:
      return Assets.facebookInActive;
    case SocialMediaTypes.instagram:
      return Assets.instaInActive;
    case SocialMediaTypes.twitter:
      return Assets.twitterInActive;
    case SocialMediaTypes.other:
      return Assets.error;
  }
}
