import 'package:meals/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridScreen extends StatelessWidget {
  const CategoryGridScreen(
      {super.key, required this.category, required this.onselectCategory});

  final Category category;
  final void Function() onselectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onselectCategory(),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}
