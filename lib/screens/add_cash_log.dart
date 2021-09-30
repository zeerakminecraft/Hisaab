import 'package:flutter/material.dart';
import 'package:hisaab/models/cash_log_data.dart';
import 'package:hisaab/theme.dart';
import 'package:intl/intl.dart';

class AddCashInLog extends StatefulWidget {
  const AddCashInLog({Key? key}) : super(key: key);

  @override
  _AddCashInLogState createState() => _AddCashInLogState();
}

class _AddCashInLogState extends State<AddCashInLog> {

  List <CashLog> log = [];
  var _formKey = GlobalKey<FormState>();
  final CashLog cashLog = CashLog(time: DateTime.now());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Amount'),
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'Amount is required';
                  }
                },
                onSaved: (String? value){
                  cashLog.cashIn = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Description'),
                onSaved: (String? value){
                  cashLog.description = value;
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
                      child: const Text('Add Cash Log'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        log.add(cashLog);
                        Navigator.pop(context, cashLog);
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




class AddCashOutLog extends StatefulWidget {
  const AddCashOutLog({Key? key}) : super(key: key);

  @override
  _AddCashOutLogState createState() => _AddCashOutLogState();
}

class _AddCashOutLogState extends State<AddCashOutLog> {

  List <CashLog> log = [];
  var _formKey = GlobalKey<FormState>();
  final CashLog cashLog = CashLog(time: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Amount'),
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'Amount is required';
                  }
                },
                onSaved: (String? value){
                  cashLog.cashOut = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: kFormStyle.copyWith(labelText: 'Description'),
                onSaved: (String? value){
                  cashLog.description = value;
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
                      child: const Text('Add Cash Log'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        log.add(cashLog);
                        Navigator.pop(context, cashLog);
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

