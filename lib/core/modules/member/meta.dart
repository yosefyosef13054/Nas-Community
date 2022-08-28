class MembersMeta {
  int total;
  int limit;
  int page;
  int pages;


  MembersMeta({this.total = 0, this.limit = 0, this.page = 0, this.pages = 0});

  factory MembersMeta.fromMap(Map<String, dynamic> data){
    return MembersMeta(
      limit:  data["limit"] ?? 0,
      page: data["page"] ?? 0,
      pages: data["pages"] ?? 0,
      total: data["total"] ?? 0,
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "total": total,
      "limit": limit,
      "page": page,
      "pages": pages
    };
  }
}