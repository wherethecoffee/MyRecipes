import 'package:flutter/material.dart';
import 'package:my_recipes/providers.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the list of favorite recipes from the provider
    final favorites = Provider.of<Providers>(context).favorites;

    // If there are no favorites, display a message
    if (favorites.isEmpty) {
      return Center(
        child: Text(
          'No favorite recipes yet!',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    // Display the list of favorite recipes
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final recipe = favorites[index];
        return ListTile(
          title: Text(recipe.title),
          trailing: IconButton(
            icon: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: recipe.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              // Toggle favorite status when the icon is pressed
              Provider.of<Providers>(context, listen: false)
                  .addFavorite(recipe.id);
            },
          ),
        );
      },
    );
  }
}