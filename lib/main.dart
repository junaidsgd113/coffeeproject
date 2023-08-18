import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'firebase_options.dart';
import 'screens/Cart_Screen/cart_screen.dart';
import 'screens/Home_Screen/home_screen.dart';
import 'screens/Favorite_Screen/Favorite_screen.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

void main()
 async{WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: Ecommerce()),
  );
}

class Ecommerce extends StatefulWidget {
  const Ecommerce({super.key});

  @override
  State<Ecommerce> createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
 //  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      );
    }
  }
}

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
         CartScreen(),
    const FavoriteScreen(),
    
  ];
  void updateItem(int value) {
    setState(() {
      selecteditem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:(MediaQuery.of(context).size.width<450)? BottomNavigationBar(
        backgroundColor: const Color(0xffF4F6F8),
       // selectedItemColor: const Color(0xff222222),
        unselectedItemColor: const Color(0xff828282),
        iconSize: 30,
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
                Icons.shopping_bag,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
         label: 'Favorite'
          )
        ],
        currentIndex: selecteditem,
        onTap: updateItem,
      ):null,
      body: Row(
       
        children: [
          if(MediaQuery.of(context).size.width>=450)
           NavigationRail(onDestinationSelected: updateItem,
            selectedIndex: selecteditem,
    backgroundColor: Color(0xffF4F6F8),
    
          destinations:  const [
           NavigationRailDestination( icon: Icon(
                Icons.home,
              size: 30,),
              label: Text('Home'),),
               NavigationRailDestination( icon: Icon(
                Icons.shopping_bag,size: 30,
              ),
              label: Text('Cart'),),
               NavigationRailDestination( icon: Icon(
                Icons.favorite,size: 30,
              ),
              label: Text('Favorite'),),
          ]),
          
          Expanded(child: itemLabels[selecteditem],)
          
        ],
      ),
    );
  }
}
