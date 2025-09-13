import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/providers.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final difficultyController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();
  bool isVegan = false;
  bool isVegeterian = false;
  final imageURLController = TextEditingController();
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<Providers>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Recipe'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Add the new Recipe (recipe)
                providers.addRecipe(
                  UniqueKey().toString(),
                  _titleController.text,
                  [], // Empty cuisineId list for now
                  int.parse(difficultyController.text),
                  ingredientsController.text.split(','),
                  stepsController.text,
                  isVegan,
                  isVegeterian,
                  imageURLController.text,
                  isFavourite,
                );

                // Navigate back after saving
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipe title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: difficultyController,
                  decoration: InputDecoration(labelText: 'Difficulty (1-5)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) < 1 ||
                        int.parse(value) > 5) {
                      return 'Please enter a valid difficulty between 1 and 5';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ingredientsController,
                  decoration: InputDecoration(
                    labelText: 'Ingredients: ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least one ingredient';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: stepsController,
                  decoration: InputDecoration(labelText: 'Steps'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the steps';
                    }
                    return null;
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
                  title: Text('Vegeterian'),
                  value: isVegeterian,
                  onChanged: (val) {
                    setState(() {
                      isVegeterian = val;
                    });
                  },
                ),
                TextFormField(
                  controller: imageURLController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
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
      ),
    );
  }
}
