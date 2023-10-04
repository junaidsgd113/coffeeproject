import 'package:coffeeproject/screens/category_screen/category_screen.dart';
import 'package:coffeeproject/screens/dashboard_screen/dashboard_screen.dart';
import 'package:coffeeproject/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() {
    return BottomNavigation();
  }
}

class BottomNavigation extends State<Homepage> {
  int selecteditem = 0;
  List itemLabels = [
    const HomeScreen(),
    const CategoryScreen(),
    const DashBoardScreen(),
  ];
  void updateItem(int value) {
    setState(() {
      selecteditem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (MediaQuery.of(context).size.width < 450)
          ? BottomNavigationBar(
              backgroundColor: const Color(0xffF4F6F8),
              // selectedItemColor: const Color(0xff222222),
              unselectedItemColor: const Color(0xff828282),
              iconSize: 20,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category,
                    ),
                    label: 'Category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard')
              ],
              currentIndex: selecteditem,
              onTap: updateItem,
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 450)
            NavigationRail(
                onDestinationSelected: updateItem,
                selectedIndex: selecteditem,
                backgroundColor: const Color(0xffF4F6F8),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.category,
                      size: 30,
                    ),
                    label: Text('Category'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.dashboard,
                      size: 30,
                    ),
                    label: Text('Dashboard'),
                  ),
                ]),
          Expanded(
            child: itemLabels[selecteditem],
          )
        ],
      ),
    );
  }
}