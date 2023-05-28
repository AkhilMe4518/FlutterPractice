import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  GlutenFree,
  LactoseFree,
  Vegetarian,
  Vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.GlutenFree: false,
          Filter.LactoseFree: false,
          Filter.Vegetarian: false,
          Filter.Vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.GlutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.LactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.Vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.Vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
