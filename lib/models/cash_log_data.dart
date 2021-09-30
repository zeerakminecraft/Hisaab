

final String tableCashLog = 'cashlogs';

class CashLogDBFields{

  static final List <String> values = [
    id, cashIn, cashOut, description, time
  ];

  static final String id = "_id";
  static final String cashIn = "cash in";
  static final String cashOut = "cash out";
  static final String description = "description";
  static final String time = "time";
}

class CashLog{
  int? id;
  int? cashIn;
  int? cashOut;
  DateTime time;
  String? description;

  CashLog({this.id, this.cashIn, this.cashOut, this.description, required this.time});

  Map<String, Object?> toJson() => {
    CashLogDBFields.id: id,
    CashLogDBFields.cashIn : cashIn,
    CashLogDBFields.cashOut : cashOut,
    CashLogDBFields.description : description,
    CashLogDBFields.time : time.toIso8601String(),
  };

  CashLog copy({
    int? id,
    int? cashIn,
    int? cashOut,
    String? description,
    DateTime? time,
  }) => CashLog(
    id: id?? this.id,
    cashIn: cashIn?? this.cashIn,
    cashOut: cashOut?? this.cashOut,
    description: description?? this.description,
    time: time?? this.time,
  );

  factory CashLog.fromJson(Map<String, Object?> json) {
    return CashLog(
      id: json[CashLogDBFields.id] as int,
      cashIn: json[CashLogDBFields.cashIn] as int,
      cashOut: json[CashLogDBFields.cashOut] as int,
      description: json[CashLogDBFields.description] as String,
      time: DateTime.parse( json[CashLogDBFields.time] as String),
    );
  }
}
