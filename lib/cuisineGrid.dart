import 'package:my_recipes/providers.dart';
import 'package:provider/provider.dart';
import './cuisineCard.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes/addCuisine.dart';

class CuisineGrid extends StatelessWidget {
  const CuisineGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<Providers>(context);
    final categories = providers.categories;

    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            children: categories.map((c) {
              return CuisineCard(cat: c);
            }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddCuisine()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 16),
          ),
          child: Text('Add New Cuisine', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

// Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('El Matbakh')),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Two columns
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 3 / 2, // Adjust as needed
//           ),
//           itemCount: categoriesList.length,
//           itemBuilder: (ctx, index) {
//             return CuisineCard(cat: categoriesList[index]);
//           },
//         ),
//       ),
//     );
//   }
