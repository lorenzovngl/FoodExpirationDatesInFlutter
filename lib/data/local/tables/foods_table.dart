import 'package:drift/drift.dart';

class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get foodName => text()();

  DateTimeColumn get expirationDate => dateTime()();

  DateTimeColumn get openingDate => dateTime().nullable()();

  IntColumn get timeSpanDays => integer().nullable()();

  IntColumn get quantity => integer().withDefault(const Constant(1))();
}
