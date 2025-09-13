import 'package:flutter/material.dart';
import 'package:my_recipes/cuisineGrid.dart';
import 'package:my_recipes/favourites.dart';

class TabsControllerScreen extends StatefulWidget {
  const TabsControllerScreen({super.key});

  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Recipes'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood_rounded)),
              Tab(icon: Icon(Icons.favorite_rounded)),
            ],
          ),
        ),
        body: TabBarView(children: [CuisineGrid(), FavoriteScreen()]),
      ),
    );
  }
}

// class TabsControllerScreen extends StatefulWidget {
//   const TabsControllerScreen({super.key});

//   @override
//   _TabsControllerScreenState createState() => _TabsControllerScreenState();
// }

// class _TabsControllerScreenState extends State<TabsControllerScreen> {
//   final List<Widget> myPages = [CategoryGrid(), FavoriteScreen()];
//   var selectedTabIndex = 0;
//   void switchPage(int index) {
//     setState(() {
//       selectedTabIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ElMatbakh')),
//       drawer: MainDrawer(),

//       body: myPages[selectedTabIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fastfood_rounded),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_rounded),
//             label: 'Favorites',
//           ),
//         ],
//         currentIndex: selectedTabIndex,
//         onTap: switchPage,
//       ),
//     );
//   }
// }