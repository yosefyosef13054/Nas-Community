import 'package:algolia/algolia.dart';

import '../../modules/discover/discover.dart';
// import 'package:nas_academy/core/modules/course/recomended_courses.dart';

class AlgoliaService {
  static Algolia initalgolia = const Algolia.init(
    applicationId: 'C8FI3TT5K2',
    apiKey: '20a52b43a974c63b1db7f84c3c2e7b15',
  );
  void getRecommended5(interst1, interst2) async {
    Algolia algolia = initalgolia;

    AlgoliaQuery searchQuery1;

    searchQuery1 = algolia.instance
        .index('test_courses_discovery_page')
        .query('')
        .filters('mode:community');
    AlgoliaQuerySnapshot querySnap = await searchQuery1.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits.toList();

    List<Hit> recommendedCoursesList = [];
    for (var item in results) {
      recommendedCoursesList.add(Hit.fromJson(item.data));
    }
    // for (var item in results) {
    //   List<String> domainAccessList = [];

    //   if (recommendedCoursesList.length < 3) {
    //     recommendedCoursesList.add(Hit(
    //       code: item.data['code'].toString() == 'null' ? '' : item.data['code'],
    //       mode: item.data['mode'].toString() == 'null' ? '' : item.data['mode'],
    //       by: item.data['by'].toString() == 'null' ? '' : item.data['by'],
    //       title:
    //           item.data['title'].toString() == 'null' ? '' : item.data['title'],
    //       domainAccess: domainAccessList,
    //       searchImageData:
    //           SearchImageData.fromJson(item.data['searchImageData']),
    //       link: item.data['link'].toString() == 'null' ? '' : item.data['link'],
    //       tags: item.data['tags'].toString() == 'null' ? '' : item.data['tags'],
    //       isPublic: item.data['isPublic'].toString() == 'null'
    //           ? ''
    //           : item.data['isPublic'],
    //       price: Price.fromJson(item.data['price']),
    //       customTag: item.data['customTag'].toString(),
    //       prioritize: item.data['prioritize'].toString() == 'null'
    //           ? false
    //           : item.data['prioritize'],
    //       score:
    //           item.data['score'].toString() == 'null' ? 0 : item.data['score'],
    //       objectId: item.data['objectID'].toString() == 'null'
    //           ? ''
    //           : item.data['objectID'],
    //     ));
    //   }
    // }
  }

  getDiscover() async {
    Algolia algolia = initalgolia;

    AlgoliaQuery searchQuery;

    searchQuery = algolia.instance
        .index('test_courses_discovery_page')
        .query('')
        .filters('mode:community');
    AlgoliaQuerySnapshot querySnap = await searchQuery.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits.toList();

    List<Hit> discoverList = [];
    for (var item in results) {
      discoverList.add(Hit.fromJson(item.data));
    }
    return discoverList;
  }
}
