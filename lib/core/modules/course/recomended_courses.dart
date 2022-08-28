
import 'dart:convert';

RecommendedCourses recommendedCoursesFromJson(String str) =>
    RecommendedCourses.fromJson(json.decode(str));

String recommendedCoursesToJson(RecommendedCourses data) =>
    json.encode(data.toJson());

class RecommendedCourses {
  RecommendedCourses({
    required this.hits,
    required this.nbHits,
    required this.page,
    required this.nbPages,
    required this.hitsPerPage,
    required this.exhaustiveNbHits,
    required this.exhaustiveTypo,
    required this.query,
    required this.params,
    required this.renderingContent,
    required this.processingTimeMs,
  });

  List<Hit> hits;
  int nbHits;
  int page;
  int nbPages;
  int hitsPerPage;
  bool exhaustiveNbHits;
  bool exhaustiveTypo;
  String query;
  String params;
  RenderingContent renderingContent;
  int processingTimeMs;

  factory RecommendedCourses.fromJson(Map<String, dynamic> json) =>
      RecommendedCourses(
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
        nbHits: json["nbHits"],
        page: json["page"],
        nbPages: json["nbPages"],
        hitsPerPage: json["hitsPerPage"],
        exhaustiveNbHits: json["exhaustiveNbHits"],
        exhaustiveTypo: json["exhaustiveTypo"],
        query: json["query"],
        params: json["params"],
        renderingContent: RenderingContent.fromJson(json["renderingContent"]),
        processingTimeMs: json["processingTimeMS"],
      );

  Map<String, dynamic> toJson() => {
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
        "nbHits": nbHits,
        "page": page,
        "nbPages": nbPages,
        "hitsPerPage": hitsPerPage,
        "exhaustiveNbHits": exhaustiveNbHits,
        "exhaustiveTypo": exhaustiveTypo,
        "query": query,
        "params": params,
        "renderingContent": renderingContent.toJson(),
        "processingTimeMS": processingTimeMs,
      };
}

class Hit {
  Hit({
    required this.code,
    required this.mode,
    // required this.discoveryCard,
    required this.by,
    required this.title,
    required this.domainAccess,
    required this.searchImageData,
    required this.link,
    required this.tags,
    required this.isPublic,
    required this.price,
    required this.customTag,
    required this.prioritize,
    required this.score,
    required this.objectId,
    //  required this.highlightResult,
  });

  dynamic code;
  dynamic mode;
  // DiscoveryCard discoveryCard;
  dynamic by;
  dynamic title;
  List<String> domainAccess;
  SearchImageData searchImageData;
  dynamic link;
  dynamic tags;
  dynamic isPublic;
  Price price;
  dynamic customTag;
  dynamic prioritize;
  dynamic score;
  String objectId;
  // HighlightResult highlightResult;

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        code: json["code"],
        mode: json["mode"],
        // discoveryCard: DiscoveryCard.fromJson(json["discoveryCard"]),
        by: json["by"],
        title: json["title"],
        domainAccess: List<String>.from(json["domainAccess"].map((x) => x)),
        searchImageData: SearchImageData.fromJson(json["searchImageData"]),
        link: json["link"],
        tags: json["tags"],
        isPublic: json["isPublic"],
        price: Price.fromJson(json["price"]),
        customTag: json["customTag"],
        prioritize: json["prioritize"],
        score: json["score"],
        objectId: json["objectID"],
        //    highlightResult: HighlightResult.fromJson(json["_highlightResult"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "mode": mode,
        // "discoveryCard": discoveryCard.toJson(),
        "by": by,
        "title": title,
        "domainAccess": List<dynamic>.from(domainAccess.map((x) => x)),
        "searchImageData": searchImageData.toJson(),
        "link": link,
        "tags": tags,
        "isPublic": isPublic,
        "price": price.toJson(),
        "customTag": customTag,
        "prioritize": prioritize,
        "score": score,
        "objectID": objectId,
        //    "_highlightResult": highlightResult.toJson(),
      };
}

class DiscoveryCard {
  DiscoveryCard({
    required this.categories,
    required this.subCategories,
    required this.description,
    required this.link,
    required this.isWaitlist,
    required this.nextCourseDate,
    required this.nextCourseDateTimestamp,
    required this.mode,
    required this.rating,
    required this.ratingsCount,
    required this.totalStudentCount,
    required this.avatarImgData,
    required this.discoveryCardImgData,
  });

  List<String> categories;
  SubCategories subCategories;
  String description;
  String link;
  bool isWaitlist;
  DateTime nextCourseDate;
  int nextCourseDateTimestamp;
  String mode;
  double rating;
  int ratingsCount;
  int totalStudentCount;
  AvatarImgData avatarImgData;
  DiscoveryCardImgData discoveryCardImgData;

  factory DiscoveryCard.fromJson(Map<String, dynamic> json) => DiscoveryCard(
        categories: List<String>.from(json["categories"].map((x) => x)),
        subCategories: SubCategories.fromJson(json["subCategories"]),
        description: json["description"],
        link: json["link"],
        isWaitlist: json["isWaitlist"],
        nextCourseDate: DateTime.parse(json["nextCourseDate"]),
        nextCourseDateTimestamp: json["nextCourseDateTimestamp"],
        mode: json["mode"],
        rating: json["rating"],
        ratingsCount: json["ratingsCount"],
        totalStudentCount: json["totalStudentCount"],
        avatarImgData: AvatarImgData.fromJson(json["avatarImgData"]),
        discoveryCardImgData:
            DiscoveryCardImgData.fromJson(json["discoveryCardImgData"]),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "subCategories": subCategories.toJson(),
        "description": description,
        "link": link,
        "isWaitlist": isWaitlist,
        "nextCourseDate": nextCourseDate.toIso8601String(),
        "nextCourseDateTimestamp": nextCourseDateTimestamp,
        "mode": mode,
        "rating": rating,
        "ratingsCount": ratingsCount,
        "totalStudentCount": totalStudentCount,
        "avatarImgData": avatarImgData.toJson(),
        "discoveryCardImgData": discoveryCardImgData.toJson(),
      };
}

class AvatarImgData {
  AvatarImgData({
    required this.mobileImgProps,
    required this.desktopImgProps,
  });

  ImgProps mobileImgProps;
  ImgProps desktopImgProps;

  factory AvatarImgData.fromJson(Map<String, dynamic> json) => AvatarImgData(
        mobileImgProps: ImgProps.fromJson(json["mobileImgProps"]),
        desktopImgProps: ImgProps.fromJson(json["desktopImgProps"]),
      );

  Map<String, dynamic> toJson() => {
        "mobileImgProps": mobileImgProps.toJson(),
        "desktopImgProps": desktopImgProps.toJson(),
      };
}

class ImgProps {
  ImgProps({
    required this.src,
    required this.height,
    required this.width,
    required this.layout,
  });

  String src;
  int height;
  int width;
  String layout;

  factory ImgProps.fromJson(Map<String, dynamic> json) => ImgProps(
        src: json["src"],
        height: json["height"],
        width: json["width"],
        layout: json["layout"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "height": height,
        "width": width,
        "layout": layout,
      };
}

class DiscoveryCardImgData {
  DiscoveryCardImgData({
    required this.mobileImgProps,
  });

  ImgProps mobileImgProps;

  factory DiscoveryCardImgData.fromJson(Map<String, dynamic> json) =>
      DiscoveryCardImgData(
        mobileImgProps: ImgProps.fromJson(json["mobileImgProps"]),
      );

  Map<String, dynamic> toJson() => {
        "mobileImgProps": mobileImgProps.toJson(),
      };
}

class SubCategories {
  SubCategories({
    required this.sponsoredClasses,
  });

  List<dynamic> sponsoredClasses;

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        sponsoredClasses:
            List<dynamic>.from(json["Sponsored Classes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Sponsored Classes": List<dynamic>.from(sponsoredClasses.map((x) => x)),
      };
}

class HighlightResult {
  HighlightResult({
    required this.title,
  });

  Title title;

  factory HighlightResult.fromJson(Map<String, dynamic> json) =>
      HighlightResult(
        title: Title.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
      };
}

class Title {
  Title({
    required this.value,
    required this.matchLevel,
    required this.matchedWords,
  });

  String value;
  String matchLevel;
  List<dynamic> matchedWords;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        value: json["value"],
        matchLevel: json["matchLevel"],
        matchedWords: List<dynamic>.from(json["matchedWords"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "matchLevel": matchLevel,
        "matchedWords": List<dynamic>.from(matchedWords.map((x) => x)),
      };
}

class Price {
  Price({
    required this.usd,
    required this.php,
    required this.inr,
    required this.showPrice,
  });

  dynamic usd;
  dynamic php;
  dynamic inr;
  dynamic showPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        usd: json["usd"],
        php: json["php"],
        inr: json["inr"],
        showPrice: json["showPrice"],
      );

  Map<String, dynamic> toJson() => {
        "usd": usd,
        "php": php,
        "inr": inr,
        "showPrice": showPrice,
      };
}

class SearchImageData {
  SearchImageData({
    required this.mobileImgData,
  });

  MobileImgData mobileImgData;

  factory SearchImageData.fromJson(Map<String, dynamic> json) =>
      SearchImageData(
        mobileImgData: MobileImgData.fromJson(json["mobileImgData"]),
      );

  Map<String, dynamic> toJson() => {
        "mobileImgData": mobileImgData.toJson(),
      };
}

class MobileImgData {
  MobileImgData({
    required this.src,
    required this.meta,
  });

  String src;
  Meta meta;

  factory MobileImgData.fromJson(Map<String, dynamic> json) => MobileImgData(
        src: json["src"],
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "meta": meta.toJson(),
      };
}

class Meta {
  Meta({
    required this.width,
    required this.height,
  });

  int width;
  int height;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
      };
}

class RenderingContent {
  RenderingContent();

  factory RenderingContent.fromJson(Map<String, dynamic> json) =>
      RenderingContent();

  Map<String, dynamic> toJson() => {};
}
