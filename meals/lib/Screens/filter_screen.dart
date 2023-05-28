import 'package:flutter/material.dart';

import '../providers/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.GlutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.GlutenFree, isChecked);
            },
            title: Text(
              'Gluten-Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Gluten-Free Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          //........
          SwitchListTile(
            value: activeFilters[Filter.LactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.LactoseFree, isChecked);
            },
            title: Text(
              'Lactose-Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Lactose-Free Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          //........
          SwitchListTile(
            value: activeFilters[Filter.Vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.Vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Vegetarian Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          //........
          SwitchListTile(
            value: activeFilters[Filter.Vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.Vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include Vegan Meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
