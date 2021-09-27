

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
  String customer;
  String contact;
  String address;
  Amount amount;
  Customer({required this.customer, required this.contact, required this.address, required this.amount});
}


