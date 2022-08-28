import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:collection/collection.dart';

extension CapExtension on String {
  String get inCaps => length > 0 ?'${this[0].toUpperCase()}${substring(1)}':'';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ").replaceAll("(electric, Plumbing)", "(electric, plumbing)").replaceAll("(electric, Plumming)", "(electric, plumbing)");
}


extension IntFormat on int {
  String get thousandFormat => NumberFormat.decimalPattern("en").format(this);
}


extension DoubleFormat on double {
  String get thousandFormat => NumberFormat.decimalPattern("en").format(double.parse(toStringAsFixed(2)));
}

extension FancyIterable on Iterable<int> {
  int get max => reduce(math.max);
  int get aver => (reduce((a, b) => a + b) / length).round();
  int get min => reduce(math.min);
}

extension Split on Iterable<String> {
  Iterable<List<String>> split(bool Function(int n, String first, String second) test) => splitBetweenIndexed((n, first, second) => test(n, first, second));
}

