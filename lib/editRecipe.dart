import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/providers.dart';
import 'package:my_recipes/recipe.dart';

class EditRecipe extends StatefulWidget {
  final Recipe recipe;
  const EditRecipe({super.key, required this.recipe});

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  List<String> _cuisineId = [];
  String _difficulty = '';
  List<String> _ingredients = [];
  String _steps = '';
  bool isVegan = false;
  bool isVegeterian = false;
  String _imageURL = '';
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    _title = widget.recipe.title;
    _cuisineId = widget.recipe.cuisineId;
    _difficulty = widget.recipe.difficulty.toString();
    _ingredients = widget.recipe.ingredients;
    _steps = widget.recipe.steps;
    isVegan = widget.recipe.isVegan;
    isVegeterian = widget.recipe.isVegeterian;
    _imageURL = widget.recipe.imageURL;
    isFavourite = widget.recipe.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<Providers>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recipe'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Call the updateRecipe method with correct parameters
                providers.updateRecipe(
                  widget.recipe.id, // USE THE ACTUAL RECIPE ID!
                  _title,
                  _cuisineId, // USE THE ACTUAL CUISINE IDs!
                  int.parse(_difficulty),
                  _ingredients,
                  _steps,
                  isVegan,
                  isVegeterian,
                  _imageURL,
                  isFavourite,
                );

                // Navigate back
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipe title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _cuisineId.join(', '),
                decoration: InputDecoration(labelText: 'Cuisine IDs (comma separated)'),
                onSaved: (value) {
                  _cuisineId = value!
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList();
                },
              ),
              TextFormField(
                initialValue: _difficulty,
                decoration: InputDecoration(labelText: 'Difficulty (1-5)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter difficulty level';
                  }
                  final difficulty = int.tryParse(value);
                  if (difficulty == null || difficulty < 1 || difficulty > 5) {
                    return 'Difficulty must be between 1 and 5';
                  }
                  return null;
                },
                onSaved: (value) {
                  _difficulty = value!;
                },
              ),
              TextFormField(
                initialValue: _ingredients.join(', '),
                decoration: InputDecoration(labelText: 'Ingredients (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ingredients';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ingredients = value!
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList();
                },
              ),
              TextFormField(
                initialValue: _steps,
                decoration: InputDecoration(labelText: 'Steps'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the steps';
                  }
                  return null;
                },
                onSaved: (value) {
                  _steps = value!;
                },
              ),
              SwitchListTile(
                title: Text('Vegan'),
                value: isVegan,
                onChanged: (val) {
                  setState(() {
                    isVegan = val;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Vegetarian'),
                value: isVegeterian,
                onChanged: (val) {
                  setState(() {
                    isVegeterian = val;
                  });
                },
              ),
              TextFormField(
                initialValue: _imageURL,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageURL = value!;
                },
              ),
              SwitchListTile(
                title: Text('Favorite'),
                value: isFavourite,
                onChanged: (val) {
                  setState(() {
                    isFavourite = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}