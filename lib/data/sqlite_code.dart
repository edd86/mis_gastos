String createUserTable = '''
  create table users (
  id integer primary key autoincrement,
  name text not null,
  email text not null unique,
  password text not null
);
''';

String createTransactionTable = '''
  create table transactions (
  id integer primary key autoincrement,
  date text not null,
  amount real not null,
  type text not null check (type in ('income', 'expense')),
  category text,
  description text,
  user_id integer,
  foreign key (user_id) references users (id)
);
''';

String createIncomeTable = '''
  create table incomes (
  id integer primary key autoincrement,
  transaction_id integer not null,
  amount real not null,
  foreign key (transaction_id) references transactions (id)
);
''';

String createDebtTable = '''
  create table debts (
  id integer primary key autoincrement,
  creditor text not null,
  amount real not null,
  date text not null,
  description text,
  user_id integer,
  foreign key (user_id) references users (id)
);
''';

String createExpenseTable = '''
  create table expenses (
  id integer primary key autoincrement,
  transaction_id integer not null,
  amount real not null,
  budget_id integer,
  foreign key (transaction_id) references transactions (id)
  foreign key (budget_id) references budgets (id)
);
''';

String createBudgetTable = '''
  create table budgets (
  id integer primary key autoincrement,
  init_date text not null,
  end_date text not null,
  amount real not null,
  expense_budget real not null,
  user_id integer,
  foreign key (user_id) references users (id)
);
''';
