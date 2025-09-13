import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_recipes/cuisine.dart';
import 'recipeCard.dart';
import 'providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_recipes/addRecipe.dart';

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({super.key});

  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  bool vegeterianSwitch = false;
  bool veganSwitch = false;
  var prefs;
  Future<void> getSwitchStates() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      vegeterianSwitch = prefs.getBool('vgt') ?? false;
      veganSwitch = prefs.getBool('veg') ?? false;
    });
  }

  @override
  void initState() {
    getSwitchStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Cuisine>;
    final cuisine = routeArgs['cuisine'];
    final recipesList = Provider.of<Providers>(context).recipes;
    final recipesInThatCuisine = recipesList.where((element) {
      return element.cuisineId.contains(cuisine!.id);
    }).toList();
    final filteredRecipes = recipesInThatCuisine.where((element) {
      if (element.isVegeterian == false && vegeterianSwitch == true) {
        return false;
      } else if (element.isVegan == false && veganSwitch == true) {
        return false;
      } else
        return true;
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text(cuisine!.title)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return RecipeCard(rec: filteredRecipes[index]);
        },
        itemCount: filteredRecipes.length,
      ),

      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => AddRecipe()));
        },
        icon: Icon(Icons.add),
        label: Text("Add New Recipe"),
      ),

      // ElevatedButton.icon(
      //   onPressed: () {
      //     Provider.of<Providers>(context, listen: false).addRecipe(
      //       rec.id,
      //       rec.title,
      //       rec.CuisineId,
      //       rec.difficulty,
      //       rec.ingredients,
      //       rec.steps,
      //       rec.isVegan,
      //       rec.isVegeterian,
      //       rec.imageURL,
      //       rec.isFavorite,
      //     );
      //   },
      //   icon: Icon(Icons.add),
      //   label: Text("Add New Recipe"),
      // ),
    );
  }
}
