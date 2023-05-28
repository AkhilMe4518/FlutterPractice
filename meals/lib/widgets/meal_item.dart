import 'package:flutter/material.dart';
import 'package:meals/Screens/meal_details.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onselectMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onselectMeal;

  String get complexityText {
    return meal.complexity.name[0].toLowerCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toLowerCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onselectMeal(context, meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl)),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration} min'),
                          SizedBox(
                            width: 5,
                          ),
                          MealItemTrait(
                              icon: Icons.work, label: '$complexityText'),
                          SizedBox(
                            width: 5,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: '$affordabilityText'),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
