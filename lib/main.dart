import 'package:my_recipes/addCuisine.dart';
import 'package:my_recipes/editCuisine.dart';
import 'package:my_recipes/providers.dart';
import 'package:my_recipes/settings.dart';
import 'package:my_recipes/tabController.dart';
import 'package:flutter/material.dart';
import 'kitchenScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => Providers(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/editCuisineRoute') {
          final args = settings.arguments as Map<String, String>;
          final cuisineId = args['cuisineId']!;
          return MaterialPageRoute(
            builder: (context) => EditCuisine(cuisineId: cuisineId),
          );
        }
        return null; // Return null for undefined routes
      },
      routes: {
        '/': (dummCtx) => TabsControllerScreen(),
        '/kitchenRoute': (dummyCtx) => KitchenScreen(),
        '/settingsRoute': (dummyCtx) => SettingsScreen(),
        '/addCuisineRoute': (dummyCtx) => AddCuisine(),
      },
    );
  }
}
