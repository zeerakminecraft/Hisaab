import 'package:flutter/material.dart';
import 'package:hisaab/theme.dart';
import 'package:hisaab/models/cash_log_data.dart';
import 'package:hisaab/models/cash_log_db.dart';
import 'add_cash_log.dart';
import 'package:intl/intl.dart';

class Cashbook extends StatefulWidget {
  const Cashbook({Key? key}) : super(key: key);

  @override
  _CashbookState createState() => _CashbookState();
}

class _CashbookState extends State<Cashbook> {

  int? cashIn;
  int? cashOut;

  List <CashLog> logs = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  Future<Function()?> refreshList() async{
    setState(() => isLoading = true);
    this.logs = await CashLogDatabase.instance.readAllNodes();
    setState(() => isLoading = false);
  }


  Future deleteCard(int id) async{
    await CashLogDatabase.instance.delete(id);
    setState(() {
      logs.remove(id);
    });
  }

  // Future updateCard(int id) async{
  //   if (isLoading) return;
  //   await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCustomer()));
  //   setState(() {
  //     refreshList();
  //   });
  // }

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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onLongPress: () => deleteCard(logs[index].id!),
                  onDoubleTap: (){

                  },
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.orangeAccent.withOpacity(0.7),
                      title: Text(
                        logs[index].cashIn != null? 'Cash In' : 'Cash Out',//logs[index].cashOut.toString(),
                        style: kTextTheme,
                      ),
                      subtitle: Text(
                        logs[index].description != null? logs[index].description.toString() : '',
                      ),
                      leading: Icon(
                        Icons.account_circle_sharp,
                        color: Colors.orange[700],
                        size: 20,
                      ),
                      trailing: Row(
                        children: [
                          Text(
                            logs[index].cashIn != null? logs[index].cashIn.toString() : logs[index].cashOut.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy - kk:mm').format(logs[index].time),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
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
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black)
                            ),
                        ),
                    ),
                    child: Text(
                      'CASH IN',
                    ),
                    onPressed: () async {
                      await AddCashInLog();
                    },
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black)
                            ),
                        ),
                    ),
                    child: Text(
                      'CASH OUT',
                    ),
                    onPressed: () async {
                      await AddCashOutLog();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
