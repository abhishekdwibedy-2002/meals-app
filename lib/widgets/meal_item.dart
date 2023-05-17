import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});
  final Meal meal;

  String get complexityText =>
      meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);

  String get affordabilityText =>
      meal.affordability.name[0].toUpperCase() +
      meal.affordability.name.substring(1);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                meal.imageUrl,
              ),
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                height: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min',
                          ),
                          const SizedBox(width: 12),
                          MealItemTrait(
                            icon: Icons.work,
                            label: complexityText,
                          ),
                          const SizedBox(width: 12),
                          MealItemTrait(
                            icon: Icons.attach_money,
                            label: affordabilityText,
                          )
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
