import 'package:flutter/material.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/filter_screen.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filter_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:';

const kInitialFilters = {
  Filter.GlutenFree: false,
  Filter.LactoseFree: false,
  Filter.Vegan: false,
  Filter.Vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favorateMeals = [];

  // Map<Filter, bool> _selectedFilters = {
  //   Filter.GlutenFree: false,
  //   Filter.LactoseFree: false,
  //   Filter.Vegan: false,
  //   Filter.Vegetarian: false
  // };

  // void _showInfoMessage(String message) {

  // }

  // void _togglesMealFavorites(Meal meal) {
  //   final isExisting = _favorateMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favorateMeals.remove(meal);
  //       _showInfoMessage('Removed Favorite');
  //     });
  //   } else {
  //     setState(() {
  //       _favorateMeals.add(meal);
  //       _showInfoMessage('Marked as Favorite');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filter') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));

      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
      // onToggleFavaroties: _togglesMealFavorites,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        // onToggleFavaroties: _togglesMealFavorites,
        meals: favoriteMeals,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Color.fromARGB(255, 208, 187, 112),
        title: Text(activePageTitle),
      ),
      body: activeScreen,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: BottomNavigationBar(
            selectedItemColor: Colors.amber,
            onTap: _selectPage,
            backgroundColor: Colors.transparent,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.set_meal),
                  ),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star_outline_rounded), label: "Favorites"),
            ]),
      ),
    );
  }
}
