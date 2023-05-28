import 'package:flutter/material.dart';
import 'package:meals/Screens/meal_details.dart';
import 'package:meals/models/meal.dart';

import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;
  // final void Function(Meal meal) onToggleFavaroties;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
              meal: meal,
              // onToggleFavaroties: onToggleFavaroties,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Uh oh Nothing in Here!!!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
        const SizedBox(height: 16),
        Text(
          "Try selecting different category!!!",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    ));
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
                meal: meals[index],
                onselectMeal: (context, meal) {
                  selectMeal(context, meal);
                },
              ));
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
