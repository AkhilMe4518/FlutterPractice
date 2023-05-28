import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Data/dummydata.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
