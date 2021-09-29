import 'package:flutter/material.dart';
import 'package:hisaab/theme.dart';

class Cashbook extends StatefulWidget {
  const Cashbook({Key? key}) : super(key: key);

  @override
  _CashbookState createState() => _CashbookState();
}

class _CashbookState extends State<Cashbook> {

  int? cashIn;
  int? cashOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  // margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  color: Colors.orangeAccent,
                  child: ListTile(
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Cash In Hand',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            cashIn != null ? cashIn.toString() : '',
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
                  color: Colors.orangeAccent,
                  child: ListTile(
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Total Balance',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            cashOut != null ? cashOut.toString() : '',
                            style: kNumberTheme,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
