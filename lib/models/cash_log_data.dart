const String tableCashLog = 'cashlogs';

class CashLogDBFields {
  static final List<String> values = [id, cashIn, cashOut, description, time];

  static const String id = "_id";
  static const String cashIn = "cash in";
  static const String cashOut = "cash out";
  static const String description = "description";
  static const String time = "time";
}

class CashLog {
  int? id;
  int? cashIn;
  int? cashOut;
  DateTime time;
  String? description;

  CashLog({
    this.id,
    this.cashIn,
    this.cashOut,
    this.description,
    required this.time,
  });

  Map<String, Object?> toJson() => {
        CashLogDBFields.id: id,
        CashLogDBFields.cashIn: cashIn,
        CashLogDBFields.cashOut: cashOut,
        CashLogDBFields.description: description,
        CashLogDBFields.time: time.toIso8601String(),
      };

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'time': time.toIso8601String(),
    };

    if (id != null) map['id'] = id;
    if (cashIn != null) map['cashIn'] = cashIn;
    if (cashOut != null) map['cashOut'] = cashOut;
    if (description != null) map['description'] = description;

    return map;
  }

  CashLog copy({
    int? id,
    int? cashIn,
    int? cashOut,
    String? description,
    DateTime? time,
  }) =>
      CashLog(
        id: id ?? this.id,
        cashIn: cashIn ?? this.cashIn,
        cashOut: cashOut ?? this.cashOut,
        description: description ?? this.description,
        time: time ?? this.time,
      );

  factory CashLog.fromJson(Map<String, Object?> json) {
    return CashLog(
      id: json['id'] as int?,
      cashIn: json['cashIn'] as int?,
      cashOut: json['cashOut'] as int?,
      description: json['description'] as String?,
      time: DateTime.parse(json['time'] as String),
    );
  }
}
