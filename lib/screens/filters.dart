import 'package:flutter/material.dart';
// import 'package:mealapp/screens/tab.dart';
// import 'package:mealapp/widgets/main_drawer.dart';

enum Filter {
  gluten,
  lactose,
  vegan,
  vegetarian,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});
  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isGlutenFree = false;
  var isLactoseFree = false;
  var isVegeterianFree = false;
  var isVeganFree = false;

  @override
  void initState() {
    super.initState();
    isGlutenFree = widget.currentFilters[Filter.gluten]!;
    isLactoseFree = widget.currentFilters[Filter.lactose]!;
    isVeganFree = widget.currentFilters[Filter.vegan]!;
    isVegeterianFree = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: ((identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'Meals') {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (ctx) => const TabScreen()));
      //     }
      //   }),
      // ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.lactose: isLactoseFree,
            Filter.gluten: isGlutenFree,
            Filter.vegan: isVeganFree,
            Filter.vegetarian: isVegeterianFree,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: isGlutenFree,
              onChanged: (isChecked) {
                setState(() {
                  isGlutenFree = isChecked;
                });
              },
              title: Text(
                'Gulten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only Include Gulten-Free Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
            ),
            SwitchListTile(
              value: isLactoseFree,
              onChanged: (isChecked) {
                setState(() {
                  isLactoseFree = isChecked;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only Include Lactose-Free Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
            ),
            SwitchListTile(
              value: isVegeterianFree,
              onChanged: (isChecked) {
                setState(() {
                  isVegeterianFree = isChecked;
                });
              },
              title: Text(
                'Vegeterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only Include Vegeterian Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
            ),
            SwitchListTile(
              value: isVeganFree,
              onChanged: (isChecked) {
                setState(() {
                  isVeganFree = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only Include Vegan Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
            )
          ],
        ),
      ),
    );
  }
}
