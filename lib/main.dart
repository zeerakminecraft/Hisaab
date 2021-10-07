import 'package:flutter/material.dart';
import 'package:hisaab/services/database_service.dart';
import 'package:hisaab/theme.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/khata_screen.dart';
import 'screens/cashbook_screen.dart';
import 'screens/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedindex = 0;
  double total = 0;

  final pages = const [KhataScreen(), Cashbook(), Account()];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<Database?>(
          create: (context) => DatabaseService.openDb(),
          initialData: null,
          builder: (context, _) {
            final database = context.watch<Database?>();
            if (database == null) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            }

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
            );
          },
        ),
      ],
    );
  }
}
