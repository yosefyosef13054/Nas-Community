import 'dart:convert';

List<Category> categoriesFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoriesToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.subCategories,
    required this.id,
    required this.title,
    required this.iconImg,
    required this.slug,
    required this.categoryImgData,
    required this.weight,
  });

  List<SubCategory> subCategories;
  String id;
  String title;
  String iconImg;
  String slug;
  CategoryImgData categoryImgData;
  int weight;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    subCategories: List<SubCategory>.from(
        json["subCategories"].map((x) => SubCategory.fromJson(x))),
    id: json["_id"],
    title: json["title"],
    iconImg: json["iconImg"],
    slug: json["slug"],
    categoryImgData: CategoryImgData.fromJson(json["categoryImgData"]),
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "subCategories":
    List<dynamic>.from(subCategories.map((x) => x.toJson())),
    "_id": id,
    "title": title,
    "iconImg": iconImg,
    "slug": slug,
    "categoryImgData": categoryImgData.toJson(),
    "weight": weight,
  };
}

class CategoryImgData {
  CategoryImgData({
    required this.alt,
    required this.mobileImgData,
    required this.desktopImgData,
  });

  String alt;
  ImgData mobileImgData;
  ImgData desktopImgData;

  factory CategoryImgData.fromJson(Map<String, dynamic> json) =>
      CategoryImgData(
        alt: json["alt"],
        mobileImgData: ImgData.fromJson(json["mobileImgData"]),
        desktopImgData: ImgData.fromJson(json["desktopImgData"]),
      );

  Map<String, dynamic> toJson() => {
    "alt": alt,
    "mobileImgData": mobileImgData.toJson(),
    "desktopImgData": desktopImgData.toJson(),
  };
}

class ImgData {
  ImgData({
    required this.src,
  });

  String src;

  factory ImgData.fromJson(Map<String, dynamic> json) => ImgData(
    src: json["src"],
  );

  Map<String, dynamic> toJson() => {
    "src": src,
  };
}

class SubCategory {
  SubCategory({
    required this.name,
    required this.domainAccess,
  });

  String name;
  List<String> domainAccess;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    name: json["name"],
    domainAccess: List<String>.from(json["domainAccess"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "domainAccess": List<dynamic>.from(domainAccess.map((x) => x)),
  };
}
