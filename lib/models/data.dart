
import 'package:flutter/cupertino.dart';

final String tableCustomer = 'customers';

class CustomerDBFields{

  static final List <String> values = [
    id, customer,contact, address, lent, borrowed, time
  ];

  static final String id = "id";
  static final String customer = "name";
  static final String contact = "_contact";
  static final String address = "address";
  static final String lent = "lent";
  static final String borrowed = "borrowed";
  static final String time = "time";
}


class Amount {

  int lent = 0;
  int borrowed = 0;

  bool? negBalance() {
    if (borrowed - lent < 0) {
      return true;
    }
    else if (borrowed - lent > 0) {
      return false;
    }
    else {

    }
  }

  int dueBalance(){
    return borrowed-lent;
  }

  void updateLent(int lentVal){
    lent = lentVal;
  }
  void updateBorrowed(int borrowedVal){
    borrowed = borrowedVal;
  }
}

class Customer{
  int id;
  String customer;
  String contact;
  String address;
  Amount amount;
  DateTime time;
  Customer({required this.id, required this.customer, required this.contact, required this.address, required this.amount, required this.time});

  // Map<String,dynamic> toMap(){
  //   return{
  //     'name':customer,
  //     'contact':contact,
  //     'address':address,
  //     'amount':amount,
  //   };
  // }

  Map<String, Object?> toJson() => {
    CustomerDBFields.id: id,
    CustomerDBFields.customer : customer,
    CustomerDBFields.contact : contact,
    CustomerDBFields.address : address,
    CustomerDBFields.lent : amount.lent,
    CustomerDBFields.borrowed : amount.borrowed,
    CustomerDBFields.time : time.toIso8601String(),
  };

  Customer copy({
    int? id,
    String? customer,
    String? contact,
    String? address,
    Amount? amount,
    DateTime? time,
}) => Customer(
    id: id?? this.id,
    customer: customer?? this.customer,
    contact: contact?? this.contact,
    address: address?? this.address,
    amount: amount?? this.amount,
    time: time?? this.time,
  );

  static Customer fromJson(Map<String, Object?> json) => Customer(
    id: json[CustomerDBFields.id] as int,
    customer: json[CustomerDBFields.customer] as String,
    contact: json[CustomerDBFields.contact] as String,
    address: json[CustomerDBFields.address] as String,
    amount: json[CustomerDBFields.lent] as Amount,
    time: json[CustomerDBFields.time] as
  );

}

List <Customer> customers = [];


