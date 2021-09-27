import 'package:flutter/material.dart';
import 'package:hisaab/models/data.dart';
import 'package:hisaab/theme.dart';
import 'khata_screen.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Invalid Input"),
          content: new Text("Please enter specify amount category"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Amount object = Amount();
  var _formKey = GlobalKey<FormState>();
  final Customer customer = Customer(customer: '',contact: '',address: '', amount: object);
  String dropdownval ='';
  int tempamount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Name'),
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'Name is required';
                  }
                },
                onSaved: (String? value){
                  customer.customer = value!;
                },
              ),
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Contact Number'),
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'Phone Number is required';
                  }
                },
                onSaved: (String? value){
                  customer.contact = value!;
                },
              ),
              DropdownButton<String>(
                value: dropdownval,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownval = newValue!;
                  });
                },
                items: <String>['','Lent','Borrowed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Amount'),
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'Amount is required';
                  }
                },
                onSaved: (String? value){
                  tempamount = int.parse(value!);
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
                              Colors.orangeAccent,
                              Colors.amberAccent
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: const Text('Add Customer'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if(!_formKey.currentState!.validate()){
                          return;
                        }
                        _formKey.currentState!.save();
                        if(dropdownval == 'Lent'){
                          object.lent =  tempamount;
                          // Navigator.pop(context, customer);
                        }
                        else if(dropdownval == 'Borrowed'){
                          object.borrowed = tempamount;
                        }
                        else{
                          _showDialog();
                        }
                        Navigator.pop(context, customer);
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












// Text(
//   ''
// ),
// SizedBox(height: 10),
// TextField(
//   onChanged: (value){
//     customer.customer = value;
//   },
//   decoration: InputDecoration(
//     hintText: 'Name'
//   ),
// ),
// TextField(
//   onChanged: (value){
//     customer.contact = value;
//   },
//   decoration: InputDecoration(
//       hintText: 'contact number'
//   ),
// ),
// TextField(
//   onChanged: (value){
//     customer.address = value;
//   },
//   decoration: InputDecoration(
//       hintText: 'Enter amount'
//   ),
// ),
// TextField(
//   onChanged: (value){
//     tempamount = int.parse(value);
//     assert(tempamount is int);
//   },
//   decoration: InputDecoration(
//       hintText: 'Address'
//   ),
// ),