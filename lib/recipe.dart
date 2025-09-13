class Recipe {
 final String id;
 final String title;
 final List<String> cuisineId;
 final int difficulty;
 final List<String> ingredients;
 final String steps;
 final bool isVegan;
 final bool isVegeterian;
 final String imageURL;
 bool isFavorite = false;
 Recipe(
 {required this.id,
 required this.title,
 required this.cuisineId,
 required this.difficulty,
 required this.ingredients,
 required this.steps,
 required this.isVegan,
 required this.isVegeterian,
 required this.imageURL,
 required this.isFavorite});
}

