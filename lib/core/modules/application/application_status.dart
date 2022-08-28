import 'package:nas_academy/core/utils/data_types.dart';

class ApplicationStatus {
  final String? communityCode;
  final String? communityObjectId;
  final ApplicationStatusType? communitySubscriptionStatus;

  const ApplicationStatus(
      {required this.communityCode,
      required this.communityObjectId,
      this.communitySubscriptionStatus = ApplicationStatusType.inactive});

  factory ApplicationStatus.fromMap(Map<String, dynamic> data, String comCode) {
    return ApplicationStatus(
        communityCode: comCode,
        communityObjectId: data["communityObjectId"],
        communitySubscriptionStatus: data["communitySubscriptionStatus"] == null
            ? null
            : ApplicationStatusType.values
                .where((element) =>
                    element.name.toLowerCase() ==
                    data["communitySubscriptionStatus"]
                        .toString()
                        .toLowerCase())
                .first);
  }

  Map<String, dynamic> toMap() {
    return {
      communityCode ?? "communityCode": {
        "communityObjectId": communityObjectId,
        "communitySubscriptionStatus": communitySubscriptionStatus
      }
    };
  }
}
