
import 'package:flutter/material.dart';
import 'package:my_recipes/cuisine.dart';
import 'package:my_recipes/favourites.dart';
import 'package:my_recipes/recipe.dart';
import 'package:provider/provider.dart';


class Providers with ChangeNotifier {
  final List<Recipe> recipes = [
    Recipe(
      id: 'r1',
      title: 'Fattoush',
      cuisineId: ['c3'],
      difficulty: 1,
      ingredients: ['Lettuce', 'Tomato', 'Summac', 'Onion', 'Olive oil'],
      steps: 'Mix all together',
      isVegan: true,
      isVegeterian: true,
      isFavorite: false,
      imageURL:
          'https://assets.bonappetit.com/photos/57af6bea53e63daf11a4e565/16:9/w_1280,c_limit/fattoush.jpg',
    ),
    Recipe(
      id: 'r2',
      title: 'Falafel',
      cuisineId: ['c2', 'c3'],
      difficulty: 2,
      ingredients: ['Fava beans', 'Hummus', 'Spices', 'frying oil'],
      steps: 'Mix ingredients into balls and fry them',
      isVegan: true,
      isVegeterian: true,
      isFavorite: false,
      imageURL: 'https://toriavey.com/images/2011/01/TOA109_18.jpeg',
    ),
    Recipe(
      id: 'r3',
      title: 'Chicken Alfredo',
      cuisineId: ['c1'],
      difficulty: 2,
      ingredients: ['pasta', 'chicken', 'alredo sauce'],
      steps: 'Boil pasta, prepare chicken and pour sauce over',
      isVegan: false,
      isVegeterian: false,
      isFavorite: false,
      imageURL:
          'https://bellyfull.net/wpcontent/uploads/2021/02/Chicken-Alfredo-blog-4.jpg',
    ),
  ];

  final FavoriteScreen favourite = FavoriteScreen();

  // ignore: prefer_final_fields
  List<Cuisine> _categories = [
    Cuisine(id: 'c1', title: 'Italian'),
    Cuisine(id: 'c2', title: 'Egyptian'),
    Cuisine(id: 'c3', title: 'Lebanese'),
    Cuisine(id: 'c4', title: 'Japanese'),
    Cuisine(id: 'c5', title: 'American'),
    Cuisine(id: 'c6', title: 'Chinese'),
    Cuisine(id: 'c7', title: 'Thai'),
    Cuisine(id: 'c8', title: 'Greek'),
    Cuisine(id: 'c9', title: 'Brazilian'),
  ];

  void addRecipe(
    String id,
    String title,
    List<String> cuisineId,
    int difficulty,
    List<String> ingredients,
    String steps,
    bool isVegan,
    bool isVegeterian,
    String imageURL,
    bool isFavourite,
  ) {
    // Check if recipe already exists
    recipes.add(
      Recipe(
        id: id,
        title: title,
        cuisineId: cuisineId,
        difficulty: difficulty,
        ingredients: ingredients,
        steps: steps,
        isVegan: isVegan,
        isVegeterian: isVegeterian,
        imageURL: imageURL,
        isFavorite: isFavourite,
      ),
    );
    notifyListeners();
  }

  void removeRecipe(String id) {
    recipes.removeWhere((rec) => rec.id == id);
    notifyListeners();
  }

  void updateRecipe(
    String id,
    String title,
    List<String> cuisineId,
    int difficulty,
    List<String> ingredients,
    String steps,
    bool isVegan,
    bool isVegeterian,
    String imageURL,
    bool isFavourite,
  ) {
    final index = recipes.indexWhere((rec) => rec.id == id);
    if (index >= 0) {
      recipes[index] = Recipe(
        id: id,
        title: title,
        cuisineId: cuisineId,
        difficulty: difficulty,
        ingredients: ingredients,
        steps: steps,
        isVegan: isVegan,
        isVegeterian: isVegeterian,
        imageURL: imageURL,
        isFavorite: isFavourite,
      );
      notifyListeners();
    }
  }

  final List<Recipe> favorites = []; // List to store favorite recipes

  void addFavorite(String id) {
    // Find the recipe by its id
    final recipe = recipes.firstWhere((rec) => rec.id == id);

    // Toggle the isFavorite property
    recipe.isFavorite = !recipe.isFavorite;

    // Add or remove the recipe from the favorites list
    if (recipe.isFavorite) {
      // Add to favorites if marked as favorite
      if (!favorites.contains(recipe)) {
        favorites.add(recipe);
      }
    } else {
      // Remove from favorites if unmarked
      favorites.removeWhere((fav) => fav.id == id);
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

  void addCuisine(String id, String title) {
    _categories.add(Cuisine(id: id, title: title));
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void updateCuisine(String id, String title) {
    // Find the index of the Cuisine to update
    final index = _categories.indexWhere((Cuisine) => Cuisine.id == id);

    if (index >= 0) {
      // Update the Cuisine title
      _categories[index] = Cuisine(id: id, title: title);

      notifyListeners(); // Notify listeners to rebuild the UI
    }
  }

  List<Cuisine> get categories => _categories;

  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, providers, child) {
        final recipes = providers.recipes;
        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(recipes[i].title),
          ),
        );
      },
    );
  }
}
