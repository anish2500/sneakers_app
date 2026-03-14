import 'package:flutter/material.dart';
import 'package:sneakers_app/features/home/cart_page.dart';
import 'package:sneakers_app/features/home/categories_page.dart';
import 'package:sneakers_app/features/home/home_page.dart';
import 'package:sneakers_app/features/home/profile_page.dart';

class BottomNavigationLayout extends StatefulWidget {
  const BottomNavigationLayout({super.key});

  @override
  State<BottomNavigationLayout> createState() => _BottomNavigationLayoutState();
}

class _BottomNavigationLayoutState extends State<BottomNavigationLayout> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    ProfilePage(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changePage,
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,

        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 156, 156, 156),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
