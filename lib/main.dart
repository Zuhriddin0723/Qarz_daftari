import 'package:flutter/material.dart';
import 'package:qarz_daftar/src/ui/add_screen.dart';
import 'package:qarz_daftar/src/ui/bottom_navigation_bar/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BottomNavigationBar1(),
    );
  }
}

