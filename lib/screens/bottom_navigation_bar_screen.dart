import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'favorites_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  static const routeName = '/bottom_navigation_bar';

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentScreenIndex = 0;

  @override
  void initState() {
    currentScreenIndex = widget.index ?? 0;
    super.initState();
  }

  final screensList = [
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:  const [
          BottomNavigationBarItem(
            activeIcon:
                Icon(Icons.home, color: Colors.deepPurple),
            icon: Icon(Icons.home_outlined),
            label: 'خانه',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: Colors.red),
            icon: Icon(Icons.favorite_outline),
            label: 'مورد علاقه ها',
          ),
        ],
        currentIndex: currentScreenIndex,
        onTap: (index) {
          setState(() {
            currentScreenIndex = index;
          });
        },
      ),
    );
  }
}
