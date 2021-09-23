import 'package:flutter/material.dart';
import 'package:hisaab/models/data.dart';
import 'khata_screen.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final Customer customer = Customer(customer: '', contact: '', address: '');
  String dropdownval = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              const Text(''),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  customer.customer = value;
                },
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  customer.contact = value;
                },
                decoration: const InputDecoration(hintText: 'contact number'),
              ),
              TextField(
                onChanged: (value) {
                  customer.address = value;
                },
                decoration: const InputDecoration(hintText: 'Address'),
              ),
              DropdownButton(
                items: <String>['Lended', 'Borrowed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownval = newValue!;
                  });
                },
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: const Text('Gradient'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          customers.add(customer);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
