const createCustomersTable = '''
CREATE TABLE Customers (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  name        TEXT NOT NULL,
  contact     TEXT NOT NULL,
  address     TEXT NOT NULL,
  lent        INTEGER,
  borrowed    INTEGER,
  time        TEXT NOT NULL
);
''';

const createCashLogsTable = '''
CREATE TABLE CashLogs (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  cashIn      INTEGER,
  cashOut     INTEGER,
  description TEXT NOT NULL,
  time        TEXT NOT NULL
);
''';

/// TODO: add other queries
