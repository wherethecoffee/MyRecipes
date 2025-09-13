import 'package:flutter/material.dart';
import 'package:my_recipes/cuisine.dart';
import 'package:my_recipes/editCuisine.dart';


class CuisineCard extends StatelessWidget {
  final Cuisine cat;

  const CuisineCard({super.key, required this.cat});

  void navigateToKitchenPage(BuildContext myContext) {
    Navigator.of(
      myContext,
    ).pushNamed('/kitchenRoute', arguments: {'cuisine': cat});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToKitchenPage(context),
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.lime,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cat.title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Align(
              alignment:
                  Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditCuisine(cuisineId: cat.id),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
