import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/discover/discover.dart';

class DiscoverProvider extends ChangeNotifier {
  List<Hit> discoverList = [];

  Future<List<Hit>> getDiscover() async {
    Algolia algolia = const Algolia.init(
      applicationId: 'C8FI3TT5K2',
      apiKey: '20a52b43a974c63b1db7f84c3c2e7b15',
    );

    AlgoliaQuery searchQuery;

    searchQuery = algolia.instance
        .index('test_courses_discovery_page')
        .query('')
        .filters('mode:community');
    AlgoliaQuerySnapshot querySnap = await searchQuery.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits.toList();
    discoverList.clear();
    for (var item in results) {
      discoverList.add(Hit.fromJson(item.data));
    }
    return discoverList;
    // recommendedCoursesList = AlgoliaService().getDiscover() as List<Hit>;
  }
}
