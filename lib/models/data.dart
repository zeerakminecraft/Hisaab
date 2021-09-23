class Amount {
  final int lent = 0;
  final int borrowed = 0;

  bool? negBalance() {
    if (borrowed - lent < 0) {
      return true;
    } else if (borrowed - lent > 0) {
      return false;
    } else {}
  }
}

class Customer {
  String customer;
  String contact;
  String address;
  Amount? amount;
  Customer(
      {required this.customer,
      required this.contact,
      required this.address,
      this.amount});
}
