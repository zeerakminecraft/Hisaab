import 'package:flutter/material.dart';
import 'package:hisaab/models/data.dart';
import 'package:hisaab/models/database_helpers.dart';
import 'package:hisaab/theme.dart';
import 'package:hisaab/screens/add_customer.dart';
import 'package:intl/intl.dart';


class KhataScreen extends StatefulWidget {
  const KhataScreen({Key? key}) : super(key: key);

  @override
  _KhataScreenState createState() => _KhataScreenState();
}

class _KhataScreenState extends State<KhataScreen> {

  List <Customer> customers = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  Future<Function()?> refreshList() async{
    setState(() => isLoading = true);
    this.customers = await CustomerDatabase.instance.readAllNodes();
    setState(() => isLoading = false);
  }

  Future deleteCard(int id) async{
    await CustomerDatabase.instance.delete(id);
  }

  Future updateCard(int id) async{
    if (isLoading) return;

    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCustomer()));
    refreshList();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  color: Colors.green,
                  child: ListTile(
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Borrowed',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            customers.fold <int> (0, (previousValue, element) => previousValue + element.amount.borrowed).toString(),
                            style: kNumberTheme,
                          ),
                        ],
                      ),
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
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Lent',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            customers.fold <int> (0, (previousValue, element) => previousValue + element.amount.lent).toString(),
                            style: kNumberTheme,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onLongPress: () => deleteCard(customers[index].id!),
                  onDoubleTap: (){

                  },
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.orangeAccent.withOpacity(0.7),
                      title: Text(
                        customers[index].customer,
                        style: kTextTheme,
                      ),
                      subtitle: Text(
                        customers[index].contact,
                        style: kTextTheme,
                      ),
                      leading: Icon(
                        Icons.account_circle_sharp,
                        color: Colors.orange[700],
                        size: 20,
                      ),
                      trailing: Row(
                        children: [
                          Text(
                            customers[index].amount.dueBalance().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy - kk:mm').format(customers[index].time),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)
                      )
                  )
              ),
              child: Text(
                'ADD CUTOMER',
              ),
              onPressed: () async {
                final x = await Navigator.push<Customer>(
                    context,
                    MaterialPageRoute(builder: (context) => AddCustomer())
                );
                setState(() {
                  customers.add(x!);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}







// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final List<Widget> pages = [
//     ///KHATA PAGE
//     Column(
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: Card(
//                 // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//                 color: Colors.green,
//                 child: ListTile(
//                   title: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           'Borrowed',
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           amountobj.borrowed.toString(),
//                           style: kNumberTheme,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10.0,
//             ),
//             Expanded(
//               child: Card(
//                 // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//                 color: Colors.red,
//                 child: ListTile(
//                   title: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           'Lent',
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           amountobj.lent.toString(),
//                           style: kNumberTheme,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: customers.length,
//             itemBuilder: (context, index){
//               return Card(
//                 elevation: 10,
//                 child: ListTile(
//                   dense: true,
//                   tileColor: Colors.orangeAccent.withOpacity(0.7),
//                   title: Text(
//                     customers[index].customer,
//                     style: kTextTheme,
//                   ),
//                   subtitle: Text(
//                     customers[index].contact,
//                     style: kTextTheme,
//                   ),
//                   leading: Icon(
//                     Icons.account_circle_sharp,
//                     color: Colors.orange[700],
//                     size: 20,
//                   ),
//                   trailing: Text(
//                     balanceDue.toString(),
//                     style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: TextButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                       side: BorderSide(color: Colors.black)
//                   )
//               )
//             ),
//             child: Text(
//               'ADD CUTOMER',
//             ),
//             onPressed: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddCustomer())
//               )
//             },
//           ),
//         )
//       ],
//     ),
//     Center(),
//     Center(),
//   ];
//
//   int _selectedindex = 0;
//   void _onItemTapped(int index){
//     print(index);
//     setState(() {
//       _selectedindex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: pages.elementAt(_selectedindex),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         iconSize: 20,
//         elevation: 10,
//         backgroundColor: Colors.orangeAccent,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black54,
//         currentIndex: _selectedindex,
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.ballot_outlined),
//             label: 'Khata',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_sharp),
//             label: 'Cashbook',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle_sharp),
//             label: 'Account',
//           ),
//         ],
//       ),
//     );
//   }
// }
