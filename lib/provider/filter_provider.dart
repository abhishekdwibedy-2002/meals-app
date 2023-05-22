import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/provider/meals_provider.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter,bool>> {
  FiltersNotifier() : super({
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegan:false,
    Filter.vegetarian:false,

  }
  );
void setFilters(Map<Filter,bool> choosenFilters)   {
  state=choosenFilters;
}

  void setFilter (Filter filter,bool isActive) {
    state = {
      ...state,filter : isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>((ref) => FiltersNotifier());

final filteredMealsprovider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filterProvider);
  return meals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

});