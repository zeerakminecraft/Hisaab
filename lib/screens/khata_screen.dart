import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    ///KHATA PAGE
    Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Card(
                // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                color: Colors.green,
                child: ListTile(
                  title: Text(
                    'Borrowed',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Card(
                // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                color: Colors.red,
                child: ListTile(
                  title: Text(
                    'Lent',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    Center(),
    Center(),
  ];

  int _selectedindex = 0;
  void _onItemTapped(int index){
    print(index);
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: pages.elementAt(_selectedindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        elevation: 10,
        backgroundColor: Colors.orangeAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedindex,
        onTap: _onItemTapped,
        items: [
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
    );
  }
}
