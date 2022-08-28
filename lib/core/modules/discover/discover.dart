// To parse this JSON data, do
//
//     final discover = discoverFromJson(jsonString);

import 'dart:convert';

Discover discoverFromJson(String str) => Discover.fromJson(json.decode(str));

String discoverToJson(Discover data) => json.encode(data.toJson());

class Discover {
  Discover({
    required this.hits,
    required this.nbHits,
    required this.page,
    required this.nbPages,
    required this.hitsPerPage,
    required this.facets,
    required this.exhaustiveFacetsCount,
    required this.exhaustiveNbHits,
    required this.exhaustiveTypo,
    required this.query,
    required this.params,
    required this.index,
    required this.serverUsed,
    required this.indexUsed,
    required this.parsedQuery,
    required this.timeoutCounts,
    required this.timeoutHits,
    required this.appliedRules,
    required this.explain,
    required this.renderingContent,
    required this.processingTimeMs,
  });

  List<Hit>? hits;
  int? nbHits;
  int? page;
  int? nbPages;
  int? hitsPerPage;
  Facets? facets;
  bool? exhaustiveFacetsCount;
  bool? exhaustiveNbHits;
  bool? exhaustiveTypo;
  String? query;
  String? params;
  String? index;
  String? serverUsed;
  String? indexUsed;
  String? parsedQuery;
  bool? timeoutCounts;
  bool? timeoutHits;
  List<AppliedRule>? appliedRules;
  Explain? explain;
  RenderingContent? renderingContent;
  int? processingTimeMs;

  factory Discover.fromJson(Map<String, dynamic> json) => Discover(
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
        nbHits: json["nbHits"],
        page: json["page"],
        nbPages: json["nbPages"],
        hitsPerPage: json["hitsPerPage"],
        facets: Facets.fromJson(json["facets"]),
        exhaustiveFacetsCount: json["exhaustiveFacetsCount"],
        exhaustiveNbHits: json["exhaustiveNbHits"],
        exhaustiveTypo: json["exhaustiveTypo"],
        query: json["query"],
        params: json["params"],
        index: json["index"],
        serverUsed: json["serverUsed"],
        indexUsed: json["indexUsed"],
        parsedQuery: json["parsedQuery"],
        timeoutCounts: json["timeoutCounts"],
        timeoutHits: json["timeoutHits"],
        appliedRules: List<AppliedRule>.from(
            json["appliedRules"].map((x) => AppliedRule.fromJson(x))),
        explain: Explain.fromJson(json["explain"]),
        renderingContent: RenderingContent.fromJson(json["renderingContent"]),
        processingTimeMs: json["processingTimeMS"],
      );

  Map<String, dynamic> toJson() => {
        "hits": List<dynamic>.from(hits!.map((x) => x.toJson())),
        "nbHits": nbHits,
        "page": page,
        "nbPages": nbPages,
        "hitsPerPage": hitsPerPage,
        "facets": facets!.toJson(),
        "exhaustiveFacetsCount": exhaustiveFacetsCount,
        "exhaustiveNbHits": exhaustiveNbHits,
        "exhaustiveTypo": exhaustiveTypo,
        "query": query,
        "params": params,
        "index": index,
        "serverUsed": serverUsed,
        "indexUsed": indexUsed,
        "parsedQuery": parsedQuery,
        "timeoutCounts": timeoutCounts,
        "timeoutHits": timeoutHits,
        "appliedRules":
            List<dynamic>.from(appliedRules!.map((x) => x.toJson())),
        "explain": explain!.toJson(),
        "renderingContent": renderingContent!.toJson(),
        "processingTimeMS": processingTimeMs,
      };
}

class AppliedRule {
  AppliedRule({
    required this.objectId,
  });

  String? objectId;

  factory AppliedRule.fromJson(Map<String, dynamic> json) => AppliedRule(
        objectId: json["objectID"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
      };
}

class Explain {
  Explain({
    required this.match,
    required this.params,
  });

  Match match;
  Params params;

  factory Explain.fromJson(Map<String, dynamic> json) => Explain(
        match: Match.fromJson(json["match"]),
        params: Params.fromJson(json["params"]),
      );

  Map<String, dynamic> toJson() => {
        "match": match.toJson(),
        "params": params.toJson(),
      };
}

class Match {
  Match({
    required this.alternatives,
  });

  List<dynamic> alternatives;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        alternatives: List<dynamic>.from(json["alternatives"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "alternatives": List<dynamic>.from(alternatives.map((x) => x)),
      };
}

class Params {
  Params({
    required this.client,
    required this.apiKey,
    required this.abTest,
    required this.rules,
    required this.paramsFinal,
  });

  Client client;
  RenderingContent apiKey;
  RenderingContent abTest;
  RenderingContent rules;
  Client paramsFinal;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        client: Client.fromJson(json["client"]),
        apiKey: RenderingContent.fromJson(json["apiKey"]),
        abTest: RenderingContent.fromJson(json["abTest"]),
        rules: RenderingContent.fromJson(json["rules"]),
        paramsFinal: Client.fromJson(json["final"]),
      );

  Map<String, dynamic> toJson() => {
        "client": client.toJson(),
        "apiKey": apiKey.toJson(),
        "abTest": abTest.toJson(),
        "rules": rules.toJson(),
        "final": paramsFinal.toJson(),
      };
}

class RenderingContent {
  RenderingContent();

  factory RenderingContent.fromJson(Map<String, dynamic> json) =>
      RenderingContent();

  Map<String, dynamic> toJson() => {};
}

class Client {
  Client({
    required this.query,
    required this.analytics,
    required this.page,
    required this.hitsPerPage,
    required this.attributesToRetrieve,
    required this.attributesToSnippet,
    required this.getRankingInfo,
    required this.highlightPreTag,
    required this.highlightPostTag,
    required this.snippetEllipsisText,
    required this.tagFilters,
    required this.facets,
    required this.facetFilters,
    required this.maxValuesPerFacet,
    required this.responseFields,
    required this.enableAbTest,
    required this.explain,
  });

  String? query;
  bool? analytics;
  int? page;
  int? hitsPerPage;
  List<String>? attributesToRetrieve;
  List<String>? attributesToSnippet;
  bool? getRankingInfo;
  String? highlightPreTag;
  String? highlightPostTag;
  String? snippetEllipsisText;
  List<dynamic> tagFilters;
  List<String>? facets;
  List<String>? facetFilters;
  int? maxValuesPerFacet;
  List<String>? responseFields;
  bool? enableAbTest;
  List<String>? explain;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        query: json["query"],
        analytics: json["analytics"],
        page: json["page"],
        hitsPerPage: json["hitsPerPage"],
        attributesToRetrieve:
            List<String>.from(json["attributesToRetrieve"].map((x) => x)),
        attributesToSnippet:
            List<String>.from(json["attributesToSnippet"].map((x) => x)),
        getRankingInfo: json["getRankingInfo"],
        highlightPreTag: json["highlightPreTag"],
        highlightPostTag: json["highlightPostTag"],
        snippetEllipsisText: json["snippetEllipsisText"],
        tagFilters: List<dynamic>.from(json["tagFilters"].map((x) => x)),
        facets: List<String>.from(json["facets"].map((x) => x)),
        facetFilters: List<String>.from(json["facetFilters"].map((x) => x)),
        maxValuesPerFacet: json["maxValuesPerFacet"],
        responseFields: List<String>.from(json["responseFields"].map((x) => x)),
        enableAbTest: json["enableABTest"],
        explain: List<String>.from(json["explain"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "query": query,
        "analytics": analytics,
        "page": page,
        "hitsPerPage": hitsPerPage,
        "attributesToRetrieve":
            List<dynamic>.from(attributesToRetrieve!.map((x) => x)),
        "attributesToSnippet":
            List<dynamic>.from(attributesToSnippet!.map((x) => x)),
        "getRankingInfo": getRankingInfo,
        "highlightPreTag": highlightPreTag,
        "highlightPostTag": highlightPostTag,
        "snippetEllipsisText": snippetEllipsisText,
        "tagFilters": List<dynamic>.from(tagFilters.map((x) => x)),
        "facets": List<dynamic>.from(facets!.map((x) => x)),
        "facetFilters": List<dynamic>.from(facetFilters!.map((x) => x)),
        "maxValuesPerFacet": maxValuesPerFacet,
        "responseFields": List<dynamic>.from(responseFields!.map((x) => x)),
        "enableABTest": enableAbTest,
        "explain": List<dynamic>.from(explain!.map((x) => x)),
      };
}

class Facets {
  Facets({
    required this.mode,
    required this.isPublic,
    required this.domainAccess,
  });

  Mode mode;
  IsPublic isPublic;
  DomainAccess domainAccess;

  factory Facets.fromJson(Map<String, dynamic> json) => Facets(
        mode: Mode.fromJson(json["mode"]),
        isPublic: IsPublic.fromJson(json["isPublic"]),
        domainAccess: DomainAccess.fromJson(json["domainAccess"]),
      );

  Map<String, dynamic> toJson() => {
        "mode": mode.toJson(),
        "isPublic": isPublic.toJson(),
        "domainAccess": domainAccess.toJson(),
      };
}

class DomainAccess {
  DomainAccess({
    required this.international,
    required this.philippines,
  });

  int? international;
  int? philippines;

  factory DomainAccess.fromJson(Map<String, dynamic> json) => DomainAccess(
        international: json["International"],
        philippines: json["Philippines"],
      );

  Map<String, dynamic> toJson() => {
        "International": international,
        "Philippines": philippines,
      };
}

class IsPublic {
  IsPublic({
    required this.isPublicTrue,
  });

  int? isPublicTrue;

  factory IsPublic.fromJson(Map<String, dynamic> json) => IsPublic(
        isPublicTrue: json["true"],
      );

  Map<String, dynamic> toJson() => {
        "true": isPublicTrue,
      };
}

class Mode {
  Mode({
    required this.community,
  });

  int? community;

  factory Mode.fromJson(Map<String, dynamic> json) => Mode(
        community: json["community"],
      );

  Map<String, dynamic> toJson() => {
        "community": community,
      };
}

class Hit {
  Hit({
    required this.code,
    required this.mode,
    required this.by,
    required this.title,
    required this.domainAccess,
    required this.link,
    required this.searchImageData,
    required this.customTag,
    required this.tags,
    required this.isPublic,
    required this.objectId,
    required this.snippetResult,
    required this.highlightResult,
    required this.discoveryPageImageData,
    required this.discoveryPageDescription,
    required this.discoveryPageCreatorImageData,
    required this.rankingInfo,
  });

  String? code;
  String? mode;
  String? by;
  String? title;
  List<String>? domainAccess;
  String? link;
  HitSearchImageData searchImageData;
  String discoveryPageImageData;
  String discoveryPageCreatorImageData;
  String? customTag;
  String? discoveryPageDescription;
  String? tags;
  bool? isPublic;
  String? objectId;
  SnippetResult? snippetResult;
  HighlightResult? highlightResult;
  RankingInfo? rankingInfo;
//  List.from(data["subtitles"] ?? []).map((e) => VideoSubtitle.fromMap(e)).toList()
  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        code: json["code"],
        mode: json["mode"],
        discoveryPageDescription: json["discoveryPageMobileDescription"],
        by: json["by"],
        title: json["title"],
        domainAccess: List.from(json["domainAccess"].map((x) => x) ?? []),
        link: json["link"],
        searchImageData: HitSearchImageData.fromJson(json["searchImageData"]),
        discoveryPageCreatorImageData:
            json["discoveryPageMobileCreatorImageData"]['src'],
        discoveryPageImageData: json["discoveryPageMobileImageData"]['src'],
        customTag: json["customTag"],
        tags: json["tags"],
        isPublic: json["isPublic"],
        objectId: json["objectID"],
        snippetResult: json["_snippetResult"] == null
            ? null
            : SnippetResult.fromJson(json["_snippetResult"]),
        highlightResult: json["_highlightResult"] == null
            ? null
            : HighlightResult.fromJson(json["_highlightResult"]),
        rankingInfo: json["_rankingInfo"] == null
            ? null
            : RankingInfo.fromJson(json["_rankingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "mode": mode,
        "by": by,
        "title": title,
        "domainAccess": List<dynamic>.from(domainAccess!.map((x) => x)),
        "link": link,
        "searchImageData": searchImageData.toJson(),
        "customTag": customTag,
        "tags": tags,
        "isPublic": isPublic,
        "objectID": objectId,
        "_snippetResult": snippetResult!.toJson(),
        "_highlightResult": highlightResult!.toJson(),
        "_rankingInfo": rankingInfo!.toJson(),
      };
}

class HighlightResult {
  HighlightResult({
    required this.code,
    required this.mode,
    required this.by,
    required this.title,
    required this.domainAccess,
    required this.link,
    required this.searchImageData,
    required this.customTag,
    required this.tags,
  });

  HighlightResultBy code;
  HighlightResultBy mode;
  HighlightResultBy by;
  HighlightResultBy title;
  List<HighlightResultBy> domainAccess;
  HighlightResultBy link;
  HighlightResultSearchImageData searchImageData;
  HighlightResultBy customTag;
  HighlightResultBy tags;

  factory HighlightResult.fromJson(Map<String, dynamic> json) =>
      HighlightResult(
        code: HighlightResultBy.fromJson(json["code"]),
        mode: HighlightResultBy.fromJson(json["mode"]),
        by: HighlightResultBy.fromJson(json["by"]),
        title: HighlightResultBy.fromJson(json["title"]),
        domainAccess: List<HighlightResultBy>.from(
            json["domainAccess"].map((x) => HighlightResultBy.fromJson(x))),
        link: HighlightResultBy.fromJson(json["link"]),
        searchImageData:
            HighlightResultSearchImageData.fromJson(json["searchImageData"]),
        customTag: HighlightResultBy.fromJson(json["customTag"]),
        tags: HighlightResultBy.fromJson(json["tags"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code.toJson(),
        "mode": mode.toJson(),
        "by": by.toJson(),
        "title": title.toJson(),
        "domainAccess": List<dynamic>.from(domainAccess.map((x) => x.toJson())),
        "link": link.toJson(),
        "searchImageData": searchImageData.toJson(),
        "customTag": customTag.toJson(),
        "tags": tags.toJson(),
      };
}

class HighlightResultBy {
  HighlightResultBy({
    required this.value,
    required this.matchLevel,
    required this.matchedWords,
  });

  String? value;
  String? matchLevel;
  List<dynamic> matchedWords;

  factory HighlightResultBy.fromJson(Map<String, dynamic> json) =>
      HighlightResultBy(
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

class HighlightResultSearchImageData {
  HighlightResultSearchImageData({
    required this.alt,
    required this.mobileImgData,
  });

  HighlightResultBy alt;
  PurpleMobileImgData mobileImgData;

  factory HighlightResultSearchImageData.fromJson(Map<String, dynamic> json) =>
      HighlightResultSearchImageData(
        alt: HighlightResultBy.fromJson(json["alt"]),
        mobileImgData: PurpleMobileImgData.fromJson(json["mobileImgData"]),
      );

  Map<String, dynamic> toJson() => {
        "alt": alt.toJson(),
        "mobileImgData": mobileImgData.toJson(),
      };
}

class PurpleMobileImgData {
  PurpleMobileImgData({
    required this.src,
    required this.meta,
  });

  HighlightResultBy src;
  PurpleMeta meta;

  factory PurpleMobileImgData.fromJson(Map<String, dynamic> json) =>
      PurpleMobileImgData(
        src: HighlightResultBy.fromJson(json["src"]),
        meta: PurpleMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "src": src.toJson(),
        "meta": meta.toJson(),
      };
}

class PurpleMeta {
  PurpleMeta({
    required this.width,
    required this.height,
  });

  HighlightResultBy width;
  HighlightResultBy height;

  factory PurpleMeta.fromJson(Map<String, dynamic> json) => PurpleMeta(
        width: HighlightResultBy.fromJson(json["width"]),
        height: HighlightResultBy.fromJson(json["height"]),
      );

  Map<String, dynamic> toJson() => {
        "width": width.toJson(),
        "height": height.toJson(),
      };
}

class RankingInfo {
  RankingInfo({
    required this.nbTypos,
    required this.firstMatchedWord,
    required this.proximityDistance,
    required this.userScore,
    required this.geoDistance,
    required this.geoPrecision,
    required this.nbExactWords,
    required this.words,
    required this.filters,
  });

  int? nbTypos;
  int? firstMatchedWord;
  int? proximityDistance;
  int? userScore;
  int? geoDistance;
  int? geoPrecision;
  int? nbExactWords;
  int? words;
  int? filters;

  factory RankingInfo.fromJson(Map<String, dynamic> json) => RankingInfo(
        nbTypos: json["nbTypos"],
        firstMatchedWord: json["firstMatchedWord"],
        proximityDistance: json["proximityDistance"],
        userScore: json["userScore"],
        geoDistance: json["geoDistance"],
        geoPrecision: json["geoPrecision"],
        nbExactWords: json["nbExactWords"],
        words: json["words"],
        filters: json["filters"],
      );

  Map<String, dynamic> toJson() => {
        "nbTypos": nbTypos,
        "firstMatchedWord": firstMatchedWord,
        "proximityDistance": proximityDistance,
        "userScore": userScore,
        "geoDistance": geoDistance,
        "geoPrecision": geoPrecision,
        "nbExactWords": nbExactWords,
        "words": words,
        "filters": filters,
      };
}

class HitSearchImageData {
  HitSearchImageData({
    required this.alt,
    required this.mobileImgData,
  });

  String? alt;
  TentacledMobileImgData mobileImgData;

  factory HitSearchImageData.fromJson(Map<String, dynamic> json) =>
      HitSearchImageData(
        alt: json["alt"],
        mobileImgData: TentacledMobileImgData.fromJson(json["mobileImgData"]),
      );

  Map<String, dynamic> toJson() => {
        "alt": alt,
        "mobileImgData": mobileImgData.toJson(),
      };
}

class TentacledMobileImgData {
  TentacledMobileImgData({
    required this.src,
    required this.meta,
  });

  String? src;
  TentacledMeta meta;

  factory TentacledMobileImgData.fromJson(Map<String, dynamic> json) =>
      TentacledMobileImgData(
        src: json["src"],
        meta: TentacledMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "meta": meta.toJson(),
      };
}

class TentacledMeta {
  TentacledMeta({
    required this.width,
    required this.height,
  });

  int? width;
  int? height;

  factory TentacledMeta.fromJson(Map<String, dynamic> json) => TentacledMeta(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
      };
}

class SnippetResult {
  SnippetResult({
    required this.code,
    required this.mode,
    required this.by,
    required this.title,
    required this.domainAccess,
    required this.link,
    required this.searchImageData,
    required this.customTag,
    required this.tags,
  });

  SnippetResultBy code;
  SnippetResultBy mode;
  SnippetResultBy by;
  SnippetResultBy title;
  List<SnippetResultBy> domainAccess;
  SnippetResultBy link;
  SnippetResultSearchImageData searchImageData;
  SnippetResultBy customTag;
  SnippetResultBy tags;

  factory SnippetResult.fromJson(Map<String, dynamic> json) => SnippetResult(
        code: SnippetResultBy.fromJson(json["code"]),
        mode: SnippetResultBy.fromJson(json["mode"]),
        by: SnippetResultBy.fromJson(json["by"]),
        title: SnippetResultBy.fromJson(json["title"]),
        domainAccess: List<SnippetResultBy>.from(
            json["domainAccess"].map((x) => SnippetResultBy.fromJson(x))),
        link: SnippetResultBy.fromJson(json["link"]),
        searchImageData:
            SnippetResultSearchImageData.fromJson(json["searchImageData"]),
        customTag: SnippetResultBy.fromJson(json["customTag"]),
        tags: SnippetResultBy.fromJson(json["tags"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code.toJson(),
        "mode": mode.toJson(),
        "by": by.toJson(),
        "title": title.toJson(),
        "domainAccess": List<dynamic>.from(domainAccess.map((x) => x.toJson())),
        "link": link.toJson(),
        "searchImageData": searchImageData.toJson(),
        "customTag": customTag.toJson(),
        "tags": tags.toJson(),
      };
}

class SnippetResultBy {
  SnippetResultBy({
    required this.value,
    required this.matchLevel,
  });

  String? value;
  String? matchLevel;

  factory SnippetResultBy.fromJson(Map<String, dynamic> json) =>
      SnippetResultBy(
        value: json["value"],
        matchLevel: json["matchLevel"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "matchLevel": matchLevel,
      };
}

class SnippetResultSearchImageData {
  SnippetResultSearchImageData({
    required this.alt,
    required this.mobileImgData,
  });

  SnippetResultBy alt;
  FluffyMobileImgData mobileImgData;

  factory SnippetResultSearchImageData.fromJson(Map<String, dynamic> json) =>
      SnippetResultSearchImageData(
        alt: SnippetResultBy.fromJson(json["alt"]),
        mobileImgData: FluffyMobileImgData.fromJson(json["mobileImgData"]),
      );

  Map<String, dynamic> toJson() => {
        "alt": alt.toJson(),
        "mobileImgData": mobileImgData.toJson(),
      };
}

class FluffyMobileImgData {
  FluffyMobileImgData({
    required this.src,
    required this.meta,
  });

  SnippetResultBy src;
  FluffyMeta meta;

  factory FluffyMobileImgData.fromJson(Map<String, dynamic> json) =>
      FluffyMobileImgData(
        src: SnippetResultBy.fromJson(json["src"]),
        meta: FluffyMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "src": src.toJson(),
        "meta": meta.toJson(),
      };
}

class FluffyMeta {
  FluffyMeta({
    required this.width,
    required this.height,
  });

  SnippetResultBy width;
  SnippetResultBy height;

  factory FluffyMeta.fromJson(Map<String, dynamic> json) => FluffyMeta(
        width: SnippetResultBy.fromJson(json["width"]),
        height: SnippetResultBy.fromJson(json["height"]),
      );

  Map<String, dynamic> toJson() => {
        "width": width.toJson(),
        "height": height.toJson(),
      };
}
