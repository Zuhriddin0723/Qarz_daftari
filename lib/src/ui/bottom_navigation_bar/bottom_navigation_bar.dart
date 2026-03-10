import 'package:flutter/material.dart';
import 'package:qarz_daftar/src/ui/add_screen.dart';
import 'package:qarz_daftar/src/ui/calculator/calculator_screen.dart';
class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({super.key});

  @override
  State<BottomNavigationBar1> createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    AddScreen(),
    CalculatorScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1E1E2C),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add,color: _currentIndex == 0
                ? Colors.blue
                : Colors.grey,),
            label: "Qarz Daftari",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate,color: _currentIndex == 1
                ? Colors.blue
                : Colors.grey,),
            label: "Savat",
          ),
        ],
      ),
    );
  }
}
