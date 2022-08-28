// To parse this JSON data, do
//
//     final contentFulll = contentFulllFromJson(jsonString);
import 'dart:convert';

ContentFulll contentFulllFromJson(String str) =>
    ContentFulll.fromJson(json.decode(str));

class ContentFulll {
  ContentFulll({
    required this.sys,
    required this.total,
    required this.skip,
    required this.limit,
    required this.items,
  });

  ContentFulllSys? sys;
  int? total;
  int? skip;
  int? limit;
  List<Item>? items;

  factory ContentFulll.fromJson(Map<String, dynamic> json) => ContentFulll(
        sys: json["sys"] == null ? null : ContentFulllSys.fromJson(json["sys"]),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
        items: List.from(json["items"] ?? [])
            .map((e) => Item.fromJson(e))
            .toList(),
      );
}

class Item {
  Item({
    required this.metadata,
    required this.sys,
    required this.fields,
  });

  Metadata? metadata;
  ItemSys? sys;
  Fields? fields;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        sys: json["sys"] == null ? null : ItemSys.fromJson(json["sys"]),
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
      );
}

class Fields {
  Fields(
      {required this.slug,
      required this.communityCode,
      required this.isLiveOnProduction,
      required this.isOnWaitlist,
      required this.isFreeCommunity,
      required this.isTokenGatedCommunity,
      required this.isTokenGatedOnlyCommunity,
      required this.joinWaitlistModalStaticProps,
      required this.ctaLabel,
      required this.mobileSectionsOrder,
      required this.desktopSectionsOrder,
      required this.openGraphPageMetadata,
      required this.bannerSection,
      required this.descriptionSection,
      required this.whyJoinSection,
      required this.whoIsThisForSection,
      required this.whoIsThisForDarkSection,
      required this.pricingSection,
      required this.faq,
      required this.members,
      required this.appSubscriptionProductId});

  dynamic slug;
  String? communityCode;
  bool? isLiveOnProduction;
  bool? isOnWaitlist;
  bool? isFreeCommunity;
  bool? isTokenGatedCommunity;
  bool? isTokenGatedOnlyCommunity;
  JoinWaitlistModalStaticProps? joinWaitlistModalStaticProps;
  dynamic ctaLabel;
  String? mobileSectionsOrder;
  String? desktopSectionsOrder;
  OpenGraphPageMetadata? openGraphPageMetadata;
  BannerSection? bannerSection;
  DescriptionSection? descriptionSection;
  WhyJoinSection? whyJoinSection;
  WhoIsThisForSection? whoIsThisForSection;
  WhoIsThisForDarkSection? whoIsThisForDarkSection;
  PricingSection? pricingSection;
  FieldsFaq? faq;
  String? appSubscriptionProductId;
  Members? members;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        slug: json["slug"],
        communityCode: json["communityCode"],
        isLiveOnProduction: json["isLiveOnProduction"],
        isOnWaitlist: json["isOnWaitlist"],
        members: json["communityMembersSectionV2"] == null
            ? null
            : Members.fromJson(json["communityMembersSectionV2"]),
        isFreeCommunity: json["isFreeCommunity"],
        isTokenGatedCommunity: json["isTokenGatedCommunity"],
        isTokenGatedOnlyCommunity: json["isTokenGatedOnlyCommunity"],
        appSubscriptionProductId: json["appSubscriptionProductId"],
        joinWaitlistModalStaticProps:
            json["joinWaitlistModalStaticProps"] == null
                ? null
                : JoinWaitlistModalStaticProps.fromJson(
                    json["joinWaitlistModalStaticProps"]),
        ctaLabel: json["ctaLabel"] is List
            ? List<List<DescriptionItem>>.from(json["ctaLabel"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["ctaLabel"],
        mobileSectionsOrder: json["mobileSectionsOrder"],
        desktopSectionsOrder: json["desktopSectionsOrder"],
        openGraphPageMetadata: json["openGraphPageMetadata"] == null
            ? null
            : OpenGraphPageMetadata.fromJson(json["openGraphPageMetadata"]),
        bannerSection: json["bannerSection"] == null
            ? null
            : BannerSection.fromJson(json["bannerSection"]),
        descriptionSection: json["descriptionSection"] == null
            ? null
            : DescriptionSection.fromJson(json["descriptionSection"]),
        whyJoinSection: json["whyJoinSection"] == null
            ? null
            : WhyJoinSection.fromJson(json["whyJoinSection"]),
        whoIsThisForSection: json["whoIsThisForSection"] == null
            ? null
            : WhoIsThisForSection.fromJson(json["whoIsThisForSection"]),
        whoIsThisForDarkSection: json["whoIsThisForDarkSection"] == null
            ? null
            : WhoIsThisForDarkSection.fromJson(json["whoIsThisForDarkSection"]),
        pricingSection: json["pricingSection"] == null
            ? null
            : PricingSection.fromJson(json["pricingSection"]),
        faq: json["faq"] == null ? null : FieldsFaq.fromJson(json["faq"]),
      );
}

class BannerSection {
  BannerSection({
    required this.communityTitle,
    required this.communitySubtitle,
    required this.fullScreenBannerImgData,
    required this.hostedBy,
  });

  dynamic communityTitle;
  String? communitySubtitle;
  FullScreenBannerImgData? fullScreenBannerImgData;
  String? hostedBy;

  factory BannerSection.fromJson(Map<String, dynamic> json) => BannerSection(
        communityTitle: json["communityTitle"] is List
            ? List<List<DescriptionItem>>.from(json["communityTitle"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["communityTitle"],
        communitySubtitle: json["communitySubtitle"] is List
            ? List<List<DescriptionItem>>.from(json["communitySubtitle"].map(
                (x) => List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["communitySubtitle"],
        fullScreenBannerImgData:
            FullScreenBannerImgData.fromJson(json["fullScreenBannerImgData"]),
        hostedBy: json["hostedBy"],
      );

  Map<String, dynamic> toJson() => {
        "communityTitle": communityTitle,
        "communitySubtitle": communitySubtitle,
        "fullScreenBannerImgData": fullScreenBannerImgData!.toJson(),
        "hostedBy": hostedBy,
      };
}

class FullScreenBannerImgData {
  FullScreenBannerImgData({
    required this.alt,
    required this.mobileImgProps,
  });

  String? alt;
  FullScreenBannerImgDataMobileImgProps mobileImgProps;

  factory FullScreenBannerImgData.fromJson(Map<String, dynamic> json) =>
      FullScreenBannerImgData(
        alt: json["alt"],
        mobileImgProps: FullScreenBannerImgDataMobileImgProps.fromJson(
            json["mobileImgProps"]),
      );

  Map<String, dynamic> toJson() => {
        "alt": alt,
        "mobileImgProps": mobileImgProps.toJson(),
      };
}

class FullScreenBannerImgDataMobileImgProps {
  FullScreenBannerImgDataMobileImgProps({
    required this.src,
    required this.layout,
    required this.objectFit,
    required this.objectPosition,
  });

  String? src;
  String? layout;
  String? objectFit;
  String? objectPosition;

  factory FullScreenBannerImgDataMobileImgProps.fromJson(
          Map<String, dynamic> json) =>
      FullScreenBannerImgDataMobileImgProps(
        src: json["src"],
        layout: json["layout"],
        objectFit: json["objectFit"],
        objectPosition: json["objectPosition"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "layout": layout,
        "objectFit": objectFit,
        "objectPosition": objectPosition,
      };
}

class DescriptionSection {
  DescriptionSection(
      {required this.imageSection,
      required this.descriptionItems,
      required this.isstring});

  bool isstring;
  ImageSection imageSection;
  List<List<DescriptionItem>> descriptionItems;

  factory DescriptionSection.fromJson(Map<String, dynamic> json) =>
      DescriptionSection(
          isstring: json["descriptionItems"] is String,
          imageSection: ImageSection.fromJson(json["imageSection"]),
          descriptionItems: json["descriptionItems"] is List
              ? List<List<DescriptionItem>>.from(json["descriptionItems"].map(
                  (x) => List<DescriptionItem>.from(
                      x.map((x) => DescriptionItem.fromJson(x)))))
              : json["descriptionItems"]);

  Map<String, dynamic> toJson() => {
        "imageSection": imageSection.toJson(),
        "descriptionItems": List<dynamic>.from(descriptionItems
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class DescriptionItem {
  DescriptionItem({
    required this.text,
    required this.isHighlighted,
    required this.isUnderlined,
    required this.isBolder,
    required this.isNewLine,
    required this.isNewParagraph,
  });

  String? text;
  bool? isHighlighted;
  bool? isUnderlined;
  bool? isBolder;
  bool? isNewLine;
  bool? isNewParagraph;

  factory DescriptionItem.fromJson(Map<String, dynamic> json) =>
      DescriptionItem(
        text: json["text"],
        isHighlighted: json["isHighlighted"],
        isUnderlined: json["isUnderlined"],
        isBolder: json["isBolder"],
        isNewLine: json["isNewLine"],
        isNewParagraph: json["isNewParagraph"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class ImageSection {
  ImageSection({
    required this.imgData,
    required this.primaryText,
    required this.primaryTextSuffix,
  });

  ImgData? imgData;
  String? primaryText;
  String? primaryTextSuffix;

  factory ImageSection.fromJson(Map<String, dynamic> json) => ImageSection(
        imgData: ImgData.fromJson(json["imgData"]),
        primaryText: json["primaryText"],
        primaryTextSuffix: json["primaryTextSuffix"],
      );

  Map<String, dynamic> toJson() => {
        "imgData": imgData!.toJson(),
        "primaryText": primaryText,
        "primaryTextSuffix": primaryTextSuffix,
      };
}

class ImgData {
  ImgData({
    required this.alt,
    required this.mobileImgProps,
  });

  String? alt;
  ImgDataMobileImgProps mobileImgProps;

  factory ImgData.fromJson(Map<String, dynamic> json) => ImgData(
        alt: json["alt"],
        mobileImgProps: ImgDataMobileImgProps.fromJson(json["mobileImgProps"]),
      );

  Map<String, dynamic> toJson() => {
        "alt": alt,
        "mobileImgProps": mobileImgProps.toJson(),
      };
}

class ImgDataMobileImgProps {
  ImgDataMobileImgProps({
    required this.src,
    required this.width,
    required this.height,
    required this.layout,
    required this.objectFit,
  });

  String? src;
  int? width;
  int? height;
  String? layout;
  String? objectFit;

  factory ImgDataMobileImgProps.fromJson(Map<String, dynamic> json) =>
      ImgDataMobileImgProps(
        src: json["src"],
        width: json["width"],
        height: json["height"],
        layout: json["layout"],
        objectFit: json["objectFit"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "width": width,
        "height": height,
        "layout": layout,
        "objectFit": objectFit,
      };
}

class FieldsFaq {
  FieldsFaq({
    required this.faqs,
    required this.description,
  });

  List<FaqElement> faqs;
  String? description;

  factory FieldsFaq.fromJson(Map<String, dynamic> json) => FieldsFaq(
        faqs: List<FaqElement>.from(
            json["faqs"].map((x) => FaqElement.fromJson(x))),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "faqs": List<dynamic>.from(faqs.map((x) => x.toJson())),
        "description": description,
      };
}

class FaqElement {
  FaqElement({
    required this.title,
    required this.content,
  });

  dynamic title;
  dynamic content;

  factory FaqElement.fromJson(Map<String, dynamic> json) => FaqElement(
        title: json["title"] is List
            ? List<List<DescriptionItem>>.from(json["title"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["title"],
        content: json["content"] is List
            ? List<List<DescriptionItem>>.from(json["content"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}

class JoinWaitlistModalStaticProps {
  JoinWaitlistModalStaticProps({
    required this.text,
    required this.title,
  });

  String? text;
  String? title;

  factory JoinWaitlistModalStaticProps.fromJson(Map<String, dynamic> json) =>
      JoinWaitlistModalStaticProps(
        text: json["text"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "title": title,
      };
}

class OpenGraphPageMetadata {
  OpenGraphPageMetadata({
    required this.url,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  String? url;
  String? title;
  String? imageUrl;
  String? description;

  factory OpenGraphPageMetadata.fromJson(Map<String, dynamic> json) =>
      OpenGraphPageMetadata(
        url: json["url"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "title": title,
        "imageUrl": imageUrl,
        "description": description,
      };
}

class PricingSection {
  PricingSection({
    required this.title,
    required this.members,
    required this.ctaItems,
    required this.ctaSupportText,
  });

  dynamic title;
  List<Member> members;
  List<String> ctaItems;
  dynamic ctaSupportText;

  factory PricingSection.fromJson(Map<String, dynamic> json) => PricingSection(
        title: json["title"] is List
            ? List<List<DescriptionItem>>.from(json["title"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["title"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        ctaItems: List<String>.from(json["ctaItems"].map((x) => x)),
        ctaSupportText: json["ctaSupportText"] is List
            ? List<List<DescriptionItem>>.from(json["ctaSupportText"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["ctaSupportText"],
      );
}

class WhoIsThisForDarkSection {
  WhoIsThisForDarkSection({
    required this.title,
    required this.ctaItems,
    required this.isDarkMode,
    required this.isListNumbered,
  });

  List<Title> title;
  List<CtaItem> ctaItems;
  bool? isDarkMode;
  bool? isListNumbered;

  factory WhoIsThisForDarkSection.fromJson(Map<String, dynamic> json) =>
      WhoIsThisForDarkSection(
        title: List<Title>.from(json["title"].map((x) => Title.fromJson(x))),
        ctaItems: List<CtaItem>.from(
            json["ctaItems"].map((x) => CtaItem.fromJson(x))),
        isDarkMode: json["isDarkMode"],
        isListNumbered: json["isListNumbered"],
      );

  Map<String, dynamic> toJson() => {
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "ctaItems": List<dynamic>.from(ctaItems.map((x) => x.toJson())),
        "isDarkMode": isDarkMode,
        "isListNumbered": isListNumbered,
      };
}

class CtaItem {
  CtaItem({
    required this.title,
  });

  String? title;

  factory CtaItem.fromJson(Map<String, dynamic> json) => CtaItem(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class Title {
  Title({
    required this.text,
    required this.isHighlighted,
  });

  String? text;
  bool? isHighlighted;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        text: json["text"],
        isHighlighted: json["isHighlighted"] == true,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "isHighlighted": isHighlighted == true,
      };
}

class WhoIsThisForSection {
  WhoIsThisForSection({
    required this.title,
    required this.ctaItems,
    required this.isDarkMode,
    required this.isListNumbered,
  });

  dynamic title;
  List<CtaItem> ctaItems;
  bool? isDarkMode;
  bool? isListNumbered;

  factory WhoIsThisForSection.fromJson(Map<String, dynamic> json) =>
      WhoIsThisForSection(
        title: json["title"] is List
            ? List<List<DescriptionItem>>.from(json["title"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["title"],
        ctaItems: List<CtaItem>.from(
            json["ctaItems"].map((x) => CtaItem.fromJson(x))),
        isDarkMode: json["isDarkMode"],
        isListNumbered: json["isListNumbered"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "ctaItems": List<dynamic>.from(ctaItems.map((x) => x.toJson())),
        "isDarkMode": isDarkMode,
        "isListNumbered": isListNumbered,
      };
}

class WhyJoinSection {
  WhyJoinSection({
    required this.cards,
    required this.title,
    required this.sectionTitle,
  });

  List<Card> cards;
  dynamic title;
  String? sectionTitle;

  factory WhyJoinSection.fromJson(Map<String, dynamic> json) => WhyJoinSection(
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        title: json["title"] is List
            ? List<List<DescriptionItem>>.from(json["title"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["title"],
        sectionTitle: json["sectionTitle"],
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "title": title,
        "sectionTitle": sectionTitle,
      };
}

class Card {
  Card({
    required this.icon,
    required this.image,
    required this.title,
    required this.description,
  });

  String? icon;
  ImgData image;
  dynamic title;
  dynamic description;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        icon: json["icon"],
        image: ImgData.fromJson(json["image"]),
        title: json["title"] is List
            ? List<List<DescriptionItem>>.from(json["title"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["title"],
        description: json["description"] is List
            ? List<List<DescriptionItem>>.from(json["description"].map((x) =>
                List<DescriptionItem>.from(
                    x.map((x) => DescriptionItem.fromJson(x)))))
            : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "image": image.toJson(),
        "title": title,
        "description": description,
      };
}

class Metadata {
  Metadata({
    required this.tags,
  });

  List<dynamic> tags;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}

class ItemSys {
  ItemSys({
    required this.space,
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.environment,
    required this.revision,
    required this.contentType,
    required this.locale,
  });

  ContentType space;
  String? id;
  String? type;
  DateTime createdAt;
  DateTime updatedAt;
  ContentType environment;
  int? revision;
  ContentType contentType;
  String? locale;

  factory ItemSys.fromJson(Map<String, dynamic> json) => ItemSys(
        space: ContentType.fromJson(json["space"]),
        id: json["id"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        environment: ContentType.fromJson(json["environment"]),
        revision: json["revision"],
        contentType: ContentType.fromJson(json["contentType"]),
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "space": space.toJson(),
        "id": id,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "environment": environment.toJson(),
        "revision": revision,
        "contentType": contentType.toJson(),
        "locale": locale,
      };
}

class ContentType {
  ContentType({
    required this.sys,
  });

  ContentTypeSys sys;

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
        sys: ContentTypeSys.fromJson(json["sys"]),
      );

  Map<String, dynamic> toJson() => {
        "sys": sys.toJson(),
      };
}

class ContentTypeSys {
  ContentTypeSys({
    required this.type,
    required this.linkType,
    required this.id,
  });

  String? type;
  String? linkType;
  String? id;

  factory ContentTypeSys.fromJson(Map<String, dynamic> json) => ContentTypeSys(
        type: json["type"],
        linkType: json["linkType"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "linkType": linkType,
        "id": id,
      };
}

class ContentFulllSys {
  ContentFulllSys({
    required this.type,
  });

  String? type;

  factory ContentFulllSys.fromJson(Map<String, dynamic> json) =>
      ContentFulllSys(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

Members membersFromJson(String str) => Members.fromJson(json.decode(str));

class Members {
  Members({
    required this.members,
    required this.cardData,
    required this.showStats,
    required this.sectionTitle,
  });

  List<Member>? members;
  CardData? cardData;
  bool? showStats;
  String? sectionTitle;

  factory Members.fromJson(Map<String, dynamic> json) => Members(
        members: json["members"] == null
            ? null
            : List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        cardData: json["cardData"] == null
            ? null
            : CardData.fromJson(json["cardData"]),
        showStats: json["showStats"],
        sectionTitle: json["sectionTitle"],
      );
}

class CardData {
  CardData({
    required this.name,
    required this.role,
    required this.imgData,
    required this.subText,
    required this.mediaLinks,
  });

  String? name;
  String? role;
  ImgData? imgData;
  String? subText;
  List<MediaLink>? mediaLinks;

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        name: json["name"],
        role: json["role"],
        imgData:
            json["imgData"] == null ? null : ImgData.fromJson(json["imgData"]),
        subText: json["subText"],
        mediaLinks: json["mediaLinks"] == null
            ? null
            : List<MediaLink>.from(
                json["mediaLinks"].map((x) => MediaLink.fromJson(x))),
      );
}

class MobileImgProps {
  MobileImgProps({
    required this.src,
    required this.width,
    required this.height,
    required this.layout,
    required this.objectFit,
  });

  String src;
  int width;
  int height;
  String layout;
  String objectFit;

  factory MobileImgProps.fromJson(Map<String, dynamic> json) => MobileImgProps(
        src: json["src"],
        width: json["width"],
        height: json["height"],
        layout: json["layout"],
        objectFit: json["objectFit"],
      );
}

class MediaLink {
  MediaLink({
    required this.link,
    required this.text,
    required this.type,
  });

  String? link;
  String? text;
  String? type;

  factory MediaLink.fromJson(Map<String, dynamic> json) => MediaLink(
        link: json["link"],
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "link": link?.toString(),
        "text": text?.toString(),
        "type": type?.toString(),
      };
}

class Member {
  Member({
    required this.name,
    required this.imgData,
    required this.subText,
  });

  String? name;
  ImgData? imgData;
  String? subText;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        name: json["name"],
        imgData:
            json["imgData"] == null ? null : ImgData.fromJson(json["imgData"]),
        subText: json["subText"],
      );
}
