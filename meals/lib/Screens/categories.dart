import 'package:flutter/material.dart';
import 'package:meals/Data/dummydata.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  // final void Function(Meal meal) onToggleFavaroties;

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animaationController;

  @override
  void initState() {
    super.initState();
    _animaationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animaationController.forward();
  }

  @override
  void dispose() {
    _animaationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // Navigator.push(context, route);
    final filterdMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filterdMeals,
              // onToggleFavaroties: onToggleFavaroties,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animaationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: availableCategories
              .map(
                (category) => CategoryGridScreen(
                    category: category,
                    onselectCategory: () {
                      _selectCategory(context, category);
                    }),
              )
              .toList(),
          // [for (final category in availableCategories)
          // CategoryGridScreen(category: category)]
        ),
        builder: (context, child) => SlideTransition(
              child: child,
              position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
                  CurvedAnimation(
                      parent: _animaationController, curve: Curves.easeInOut)),
            ));
  }
}
// Padding(
//               padding:
//                   EdgeInsets.only(top: 100 - _animaationController.value * 100),
//               child: child,
//             )
