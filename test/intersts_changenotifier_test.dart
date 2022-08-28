import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nas_academy/core/api/category/category.dart';
import 'package:nas_academy/core/modules/category/category.dart';
import 'package:nas_academy/core/providers/boarding/recommendations.dart';
import 'package:uuid/uuid.dart';

class MocInterestsService extends Mock implements CategoryApi {}

void main() {
  late RecommendationsProvider sut;
  late MocInterestsService mocInterestsService;

  setUp(() {
    mocInterestsService = MocInterestsService();
    sut = RecommendationsProvider(mocInterestsService);
  });

  test('initial values are correct', () {
    expect(sut.categoriesList, []);
  });

  group('Interests Categories', () {
    var listcategories = [
      Category(
          subCategories: List.generate(5,
              (index) => SubCategory(name: "Sub Cat $index", domainAccess: [])),
          id: const Uuid().v4(),
          title: "Videography",
          iconImg: "iconImg",
          slug: "slug",
          categoryImgData: CategoryImgData(
              alt: "",
              desktopImgData: ImgData(src: "asd"),
              mobileImgData: ImgData(src: "asd")),
          weight: 30),
      Category(
          subCategories: List.generate(5,
              (index) => SubCategory(name: "Sub Cat $index", domainAccess: [])),
          id: const Uuid().v4(),
          title: "Videography",
          iconImg: "iconImg",
          slug: "slug",
          categoryImgData: CategoryImgData(
              alt: "",
              desktopImgData: ImgData(src: "asd"),
              mobileImgData: ImgData(src: "asd")),
          weight: 30),
    ];
    void arrangeCategoriesApiReturn() {
      when(() => mocInterestsService.getCategoriesapi())
          .thenAnswer((_) async => listcategories);
    }

    test('get categories using InterestsApi', () async {
      arrangeCategoriesApiReturn();

      await sut.getCategories();
      verify(() {
        mocInterestsService.getCategoriesapi();
      }).called(1);
    });
  });
}
