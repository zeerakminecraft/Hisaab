import 'package:flutter/material.dart';
import 'package:hisaab/models/customer_data.dart';
import 'package:hisaab/models/customer_db.dart';
import 'package:hisaab/services/database_service.dart';
import 'package:hisaab/theme.dart';
import 'package:hisaab/screens/add_customer.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class KhataScreen extends StatefulWidget {
  const KhataScreen({Key? key}) : super(key: key);

  @override
  _KhataScreenState createState() => _KhataScreenState();
}

class _KhataScreenState extends State<KhataScreen> {
  List<Customer> customers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _refreshCustomersList();
  }

  Future<void> _refreshCustomersList() async {
    final database = context.read<Database>();
    final customers = await DatabaseService.getAllCustomers(database: database);
    this.customers = customers;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.green,
                child: ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Borrowed'),
                        SizedBox(width: 10),
                        Text(
                          customers
                              .fold<int>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.amount.borrowed)
                              .toString(),
                          style: kNumberTheme,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Card(
                color: Colors.red,
                child: ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Lent'),
                        SizedBox(width: 10),
                        Text(
                          customers
                              .fold<int>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.amount.lent)
                              .toString(),
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
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  dense: true,
                  tileColor: Colors.orangeAccent.withOpacity(0.7),
                  title: Text(
                    customers[index].name,
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
                  trailing: Text(
                    customers[index].amount.dueBalance().toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
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
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ),
            child: Text('ADD CUTOMER'),
            onPressed: () async {
              final newCustomer = await Navigator.push<Customer>(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCustomer(),
                ),
              );

              if (newCustomer == null) return;

              final database = context.read<Database>();
              await DatabaseService.insertCustomer(
                database: database,
                customer: newCustomer,
              );

              await _refreshCustomersList();
            },
          ),
        )
      ],
    );
  }
}
