import 'package:flutter/material.dart';
import 'package:sneakers_app/features/home/bottom_navigation_layout.dart';
import 'package:sneakers_app/features/home/home_page.dart';
import 'package:sneakers_app/features/home/profile_page.dart';
import 'package:sneakers_app/features/home/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', colorScheme: ColorScheme.light(surface: Colors.white, primary: Colors.blue),
      scaffoldBackgroundColor: Colors.white),
      
      home: BottomNavigationLayout(),
    );
  }
}
