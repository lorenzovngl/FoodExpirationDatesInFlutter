import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/foods_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Foods])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Food>> watchFoods() {
    return (select(foods)
          ..orderBy([
            (food) => OrderingTerm.asc(food.expirationDate),
          ]))
        .watch();
  }

  Future<int> insertFood(FoodsCompanion food) {
    return into(foods).insert(food);
  }

  Future<int> deleteFoodById(int id) {
    return (delete(foods)..where((food) => food.id.equals(id))).go();
  }

  Future<bool> updateFood(Food food) {
    return update(foods).replace(food);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'food_expiration_dates.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
