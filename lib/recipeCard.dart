import 'package:flutter/material.dart';
import 'package:my_recipes/editRecipe.dart';
import 'package:my_recipes/providers.dart';
import 'package:my_recipes/recipe.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RecipeCard extends StatelessWidget {
  Recipe rec;
  RecipeCard({super.key, required this.rec});
  void goToSpecificRecipe() {}

  String getDifficulty(int diff) {
    if (diff == 1) {
      return 'Easy';
    } else if (diff == 2) {
      return 'Medium';
    } else
      return 'Hard';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(rec.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this recipe?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false); // User cancels
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true); // User confirms
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Providers>(context, listen: false).removeRecipe(rec.id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Recipe Deleted')));
      },
      child: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => EditRecipe(recipe: rec)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // child 1 of column is image + title
              Stack(
                children: [
                  // child 1 of stack is the recipe image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      rec.imageURL,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child 2 of stack is the recipe title
                  Positioned.fill(
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Container(
                        color: Colors.black38,
                        child: Center(
                          //color: Colors.black38,
                          child: Text(
                            rec.title,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // child 2 of colum is the white row
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(getDifficulty(rec.difficulty)),
                    Text(rec.isVegan ? 'Vegan' : 'Non-Vegan'),
                    Text(rec.isVegeterian ? 'Vegeterian' : 'NonVegeterian'),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: rec.isFavorite ? Colors.red : null,
                    onPressed: () {
                      Provider.of<Providers>(
                        context,
                        listen: false,
                      ).addFavorite(rec.id);
                    },
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.edit),
                  //   onPressed: () {
                  // Provider.of<Providers>(
                  //   context,
                  //   listen: false,
                  // ).updateRecipe(
                  //   rec.id,
                  //   rec.title,
                  //   rec.categoryId,
                  //   rec.difficulty,
                  //   rec.ingredients,
                  //   rec.steps,
                  //   rec.isVegan,
                  //   rec.isVegeterian,
                  //   rec.imageURL,
                  //   rec.isFavorite,
                  // );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
