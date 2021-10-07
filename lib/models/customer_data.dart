import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const String tableCustomer = 'customers';

class CustomerDBFields {
  static final List<String> values = [
    id,
    customer,
    contact,
    address,
    lent,
    borrowed,
    time
  ];

  static const String id = "_id";
  static const String customer = "name";
  static const String contact = "contact";
  static const String address = "address";
  static const String lent = "lent";
  static const String borrowed = "borrowed";
  static const String time = "time";
}

class Amount {
  int lent = 0;
  int borrowed = 0;

  bool? negBalance() {
    if (borrowed - lent < 0) {
      return true;
    } else if (borrowed - lent > 0) {
      return false;
    } else {}
  }

  int dueBalance() {
    return borrowed - lent;
  }

  void updateLent(int lentVal) {
    lent = lentVal;
  }

  void updateBorrowed(int borrowedVal) {
    borrowed = borrowedVal;
  }
}

class Customer {
  int? id;
  String name;
  String contact;
  String address;
  Amount amount;
  DateTime time;
  Customer({
    this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.amount,
    required this.time,
  });

  // Map<String,dynamic> toMap(){
  //   return{
  //     'name':customer,
  //     'contact':contact,
  //     'address':address,
  //     'amount':amount,
  //   };
  // }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'contact': contact,
      'address': address,
      'lent': amount.lent,
      'borrowed': amount.borrowed,
      'time': time.toIso8601String(),
    };

    if (id != null) map['id'] = id;

    return map;
  }

  Map<String, Object?> toJson() => {
        CustomerDBFields.id: id,
        CustomerDBFields.customer: name,
        CustomerDBFields.contact: contact,
        CustomerDBFields.address: address,
        CustomerDBFields.lent: amount.lent,
        CustomerDBFields.borrowed: amount.borrowed,
        CustomerDBFields.time: time.toIso8601String(),
      };

  Customer copy({
    int? id,
    String? customer,
    String? contact,
    String? address,
    Amount? amount,
    DateTime? time,
  }) =>
      Customer(
        id: id ?? this.id,
        name: customer ?? name,
        contact: contact ?? this.contact,
        address: address ?? this.address,
        amount: amount ?? this.amount,
        time: time ?? this.time,
      );

  factory Customer.fromJson(Map<String, Object?> json) {
    print(json);
    final amt = Amount();
    amt.lent = (json['lent'] as int?) ?? 0;
    amt.borrowed = (json['borrowed'] as int?) ?? 0;

    return Customer(
      id: json['id'] as int?,
      name: json['name'] as String,
      contact: json[CustomerDBFields.contact] as String,
      address: json[CustomerDBFields.address] as String,
      amount: amt,
      time: DateTime.parse(json[CustomerDBFields.time] as String),
    );
  }
}
