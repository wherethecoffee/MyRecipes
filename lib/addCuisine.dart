import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/providers.dart';


class AddCuisine extends StatefulWidget {
  const AddCuisine({super.key});

  @override
  State<AddCuisine> createState() => _AddCuisineState();
}

class _AddCuisineState extends State<AddCuisine> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<Providers>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Cuisine'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Add the new Cuisine (cuisine)
                providers.addCuisine(
                  UniqueKey().toString(),
                  _titleController.text,
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
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cuisine title';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
