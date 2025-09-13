import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/providers.dart';

class EditCuisine extends StatefulWidget {
  final String cuisineId;

  const EditCuisine({super.key, required this.cuisineId});

  @override
  State<EditCuisine> createState() => _EditCuisineState();
}

class _EditCuisineState extends State<EditCuisine> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String catid = '';

  @override
  void initState() {
    super.initState();
    final categories = Provider.of<Providers>(
      context,
      listen: false,
    ).categories;
    final cuisine = categories.firstWhere(
      (Cuisine) => Cuisine.id == widget.cuisineId,
    );
    catid = cuisine.id;
    _title = cuisine.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Cuisine'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Call the updateCuisine method
                Provider.of<Providers>(context, listen: false).updateCuisine(
                  catid, // Cuisine ID
                  _title, // Updated title
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
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Cuisine Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
