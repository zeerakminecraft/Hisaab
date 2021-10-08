import 'package:flutter/material.dart';
import 'package:hisaab/services/database_service.dart';
import 'package:hisaab/theme.dart';
import 'package:hisaab/models/cash_log_data.dart';
import 'package:hisaab/models/cash_log_db.dart';
import 'package:provider/src/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'add_cash_log.dart';

class Cashbook extends StatefulWidget {
  const Cashbook({Key? key}) : super(key: key);

  @override
  _CashbookState createState() => _CashbookState();
}

class _CashbookState extends State<Cashbook> {
  // int? cashIn;
  // int? cashOut;

  List<CashLog> cashLogs = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _refreshCashLogsList();
  }

  Future<void> _refreshCashLogsList() async {
    final database = context.read<Database>();
    final cashLogs = await DatabaseService.getAllCashLogs(database: database);
    this.cashLogs = cashLogs;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Cash In Hand'),
                        SizedBox(width: 10),
                        Text(
                          cashLogs
                              .fold<int>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + (element.cashIn ?? 0))
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
                color: Colors.orangeAccent,
                child: ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Total Balance'),
                        SizedBox(width: 10),
                        Text(
                          cashLogs
                              .fold<int>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + (element.cashOut ?? 0))
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
            itemCount: cashLogs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress:  () async{
                  final database = context.read<Database>();
                  await DatabaseService.deleteCustomer(cashLogs[index].id!, database);
                  await _refreshCashLogsList();
                },
                child: Card(
                  elevation: 10,
                  shadowColor: cashLogs[index].cashIn != null
                      ? Colors.green[700]
                      : Colors.red[900],
                  child: ListTile(
                    dense: true,
                    tileColor: Colors.orangeAccent.withOpacity(0.7),
                    title: Text(
                      cashLogs[index].cashIn != null
                          ? 'Cash In'
                          : 'Cash Out', //logs[index].cashOut.toString(),
                      style: kTextTheme,
                    ),
                    subtitle: Text(
                      cashLogs[index].description != null
                          ? cashLogs[index].description.toString()
                          : '',
                    ),
                    leading: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.orange[700],
                      size: 20,
                    ),
                    trailing: Text(
                      cashLogs[index].cashIn != null
                          ? cashLogs[index].cashIn.toString()
                          : cashLogs[index].cashOut.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange.withOpacity(0.7)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                    ),
                  ),
                  child: Text('CASH IN'),
                  onPressed: () async {
                    final newLog = await Navigator.push<CashLog>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCashInLog(),
                      ),
                    );

                    if (newLog == null) return;

                    final database = context.read<Database>();
                    await DatabaseService.insertCashLog(
                      database: database,
                      cashLog: newLog,
                    );

                    await _refreshCashLogsList();
                  },
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange.withOpacity(0.7)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                    ),
                  ),
                  child: Text('CASH OUT'),
                  onPressed: () async {
                    final newLog = await Navigator.push<CashLog>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCashOutLog(),
                      ),
                    );

                    if (newLog == null) return;

                    final database = context.read<Database>();
                    await DatabaseService.insertCashLog(
                      database: database,
                      cashLog: newLog,
                    );

                    await _refreshCashLogsList();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
