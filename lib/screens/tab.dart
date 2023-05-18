import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/categories_screen.dart';
import 'package:mealapp/screens/filters.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.gluten: false,
  Filter.lactose: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex = 0;
  final List<Meal> favMeal = [];
  Map<Filter, bool> selectFilters = {
    Filter.gluten: false,
    Filter.lactose: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };



  void showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void favMealSelect(Meal meal) {
    final isExisting = favMeal.contains(meal);
    if (isExisting) {
      setState(() {
        favMeal.remove(meal);
        showMessage('Meal is no longer a favorite...');
      });
    } else {
      setState(() {
        favMeal.add(meal);
        showMessage('Marked as favorite!');
      });
    }
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (context) => FilterScreen(currentFilters: selectFilters,)));

      setState(() {
        selectFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (selectFilters[Filter.gluten]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectFilters[Filter.lactose]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (selectFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onSelectFunction: favMealSelect,
      selectMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favMeal,
        onSelectFunction: favMealSelect,
      );
      activePageTitle = 'Yours Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
