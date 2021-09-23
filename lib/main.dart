import 'package:flutter/material.dart';
import 'package:hisaab/theme.dart';
import 'screens/khata_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedindex = 0;
  double total = 0;

  final List<Widget> pages = [
    const KhataScreen(),
  ];

  void _onItemTapped(int index) {
    // print(index);
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kTheme,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: pages.elementAt(_selectedindex),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          elevation: 10,
          backgroundColor: Colors.orangeAccent,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          currentIndex: _selectedindex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.ballot_outlined),
              label: 'Khata',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_sharp),
              label: 'Cashbook',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Account',
            ),
          ],
        ),
      ),
      // AnimatedSplashScreen(
      //   splash: 'assets/something.jpg',
      //   nextScreen: MainScreen(),
      //   duration: 3000,
      //   splashTransition: SplashTransition.fadeTransition,
      // ),
    );
  }
}
