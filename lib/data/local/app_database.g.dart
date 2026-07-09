// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodNameMeta =
      const VerificationMeta('foodName');
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
      'food_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expirationDateMeta =
      const VerificationMeta('expirationDate');
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>('expiration_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _openingDateMeta =
      const VerificationMeta('openingDate');
  @override
  late final GeneratedColumn<DateTime> openingDate = GeneratedColumn<DateTime>(
      'opening_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _timeSpanDaysMeta =
      const VerificationMeta('timeSpanDays');
  @override
  late final GeneratedColumn<int> timeSpanDays = GeneratedColumn<int>(
      'time_span_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, foodName, expirationDate, openingDate, timeSpanDays, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<Food> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_name')) {
      context.handle(_foodNameMeta,
          foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta));
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
          _expirationDateMeta,
          expirationDate.isAcceptableOrUnknown(
              data['expiration_date']!, _expirationDateMeta));
    } else if (isInserting) {
      context.missing(_expirationDateMeta);
    }
    if (data.containsKey('opening_date')) {
      context.handle(
          _openingDateMeta,
          openingDate.isAcceptableOrUnknown(
              data['opening_date']!, _openingDateMeta));
    }
    if (data.containsKey('time_span_days')) {
      context.handle(
          _timeSpanDaysMeta,
          timeSpanDays.isAcceptableOrUnknown(
              data['time_span_days']!, _timeSpanDaysMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Food map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Food(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_name'])!,
      expirationDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}expiration_date'])!,
      openingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opening_date']),
      timeSpanDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_span_days']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class Food extends DataClass implements Insertable<Food> {
  final int id;
  final String foodName;
  final DateTime expirationDate;
  final DateTime? openingDate;
  final int? timeSpanDays;
  final int quantity;
  const Food(
      {required this.id,
      required this.foodName,
      required this.expirationDate,
      this.openingDate,
      this.timeSpanDays,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_name'] = Variable<String>(foodName);
    map['expiration_date'] = Variable<DateTime>(expirationDate);
    if (!nullToAbsent || openingDate != null) {
      map['opening_date'] = Variable<DateTime>(openingDate);
    }
    if (!nullToAbsent || timeSpanDays != null) {
      map['time_span_days'] = Variable<int>(timeSpanDays);
    }
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: Value(id),
      foodName: Value(foodName),
      expirationDate: Value(expirationDate),
      openingDate: openingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(openingDate),
      timeSpanDays: timeSpanDays == null && nullToAbsent
          ? const Value.absent()
          : Value(timeSpanDays),
      quantity: Value(quantity),
    );
  }

  factory Food.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Food(
      id: serializer.fromJson<int>(json['id']),
      foodName: serializer.fromJson<String>(json['foodName']),
      expirationDate: serializer.fromJson<DateTime>(json['expirationDate']),
      openingDate: serializer.fromJson<DateTime?>(json['openingDate']),
      timeSpanDays: serializer.fromJson<int?>(json['timeSpanDays']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodName': serializer.toJson<String>(foodName),
      'expirationDate': serializer.toJson<DateTime>(expirationDate),
      'openingDate': serializer.toJson<DateTime?>(openingDate),
      'timeSpanDays': serializer.toJson<int?>(timeSpanDays),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  Food copyWith(
          {int? id,
          String? foodName,
          DateTime? expirationDate,
          Value<DateTime?> openingDate = const Value.absent(),
          Value<int?> timeSpanDays = const Value.absent(),
          int? quantity}) =>
      Food(
        id: id ?? this.id,
        foodName: foodName ?? this.foodName,
        expirationDate: expirationDate ?? this.expirationDate,
        openingDate: openingDate.present ? openingDate.value : this.openingDate,
        timeSpanDays:
            timeSpanDays.present ? timeSpanDays.value : this.timeSpanDays,
        quantity: quantity ?? this.quantity,
      );
  Food copyWithCompanion(FoodsCompanion data) {
    return Food(
      id: data.id.present ? data.id.value : this.id,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
      openingDate:
          data.openingDate.present ? data.openingDate.value : this.openingDate,
      timeSpanDays: data.timeSpanDays.present
          ? data.timeSpanDays.value
          : this.timeSpanDays,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('id: $id, ')
          ..write('foodName: $foodName, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('openingDate: $openingDate, ')
          ..write('timeSpanDays: $timeSpanDays, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, foodName, expirationDate, openingDate, timeSpanDays, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          other.id == this.id &&
          other.foodName == this.foodName &&
          other.expirationDate == this.expirationDate &&
          other.openingDate == this.openingDate &&
          other.timeSpanDays == this.timeSpanDays &&
          other.quantity == this.quantity);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> id;
  final Value<String> foodName;
  final Value<DateTime> expirationDate;
  final Value<DateTime?> openingDate;
  final Value<int?> timeSpanDays;
  final Value<int> quantity;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.foodName = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.timeSpanDays = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    required String foodName,
    required DateTime expirationDate,
    this.openingDate = const Value.absent(),
    this.timeSpanDays = const Value.absent(),
    this.quantity = const Value.absent(),
  })  : foodName = Value(foodName),
        expirationDate = Value(expirationDate);
  static Insertable<Food> custom({
    Expression<int>? id,
    Expression<String>? foodName,
    Expression<DateTime>? expirationDate,
    Expression<DateTime>? openingDate,
    Expression<int>? timeSpanDays,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodName != null) 'food_name': foodName,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (openingDate != null) 'opening_date': openingDate,
      if (timeSpanDays != null) 'time_span_days': timeSpanDays,
      if (quantity != null) 'quantity': quantity,
    });
  }

  FoodsCompanion copyWith(
      {Value<int>? id,
      Value<String>? foodName,
      Value<DateTime>? expirationDate,
      Value<DateTime?>? openingDate,
      Value<int?>? timeSpanDays,
      Value<int>? quantity}) {
    return FoodsCompanion(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      expirationDate: expirationDate ?? this.expirationDate,
      openingDate: openingDate ?? this.openingDate,
      timeSpanDays: timeSpanDays ?? this.timeSpanDays,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (openingDate.present) {
      map['opening_date'] = Variable<DateTime>(openingDate.value);
    }
    if (timeSpanDays.present) {
      map['time_span_days'] = Variable<int>(timeSpanDays.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('foodName: $foodName, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('openingDate: $openingDate, ')
          ..write('timeSpanDays: $timeSpanDays, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodsTable foods = $FoodsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [foods];
}

typedef $$FoodsTableCreateCompanionBuilder = FoodsCompanion Function({
  Value<int> id,
  required String foodName,
  required DateTime expirationDate,
  Value<DateTime?> openingDate,
  Value<int?> timeSpanDays,
  Value<int> quantity,
});
typedef $$FoodsTableUpdateCompanionBuilder = FoodsCompanion Function({
  Value<int> id,
  Value<String> foodName,
  Value<DateTime> expirationDate,
  Value<DateTime?> openingDate,
  Value<int?> timeSpanDays,
  Value<int> quantity,
});

class $$FoodsTableFilterComposer extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
      column: $table.expirationDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openingDate => $composableBuilder(
      column: $table.openingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeSpanDays => $composableBuilder(
      column: $table.timeSpanDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));
}

class $$FoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
      column: $table.expirationDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openingDate => $composableBuilder(
      column: $table.openingDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeSpanDays => $composableBuilder(
      column: $table.timeSpanDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));
}

class $$FoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
      column: $table.expirationDate, builder: (column) => column);

  GeneratedColumn<DateTime> get openingDate => $composableBuilder(
      column: $table.openingDate, builder: (column) => column);

  GeneratedColumn<int> get timeSpanDays => $composableBuilder(
      column: $table.timeSpanDays, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$FoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodsTable,
    Food,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (Food, BaseReferences<_$AppDatabase, $FoodsTable, Food>),
    Food,
    PrefetchHooks Function()> {
  $$FoodsTableTableManager(_$AppDatabase db, $FoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> foodName = const Value.absent(),
            Value<DateTime> expirationDate = const Value.absent(),
            Value<DateTime?> openingDate = const Value.absent(),
            Value<int?> timeSpanDays = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              FoodsCompanion(
            id: id,
            foodName: foodName,
            expirationDate: expirationDate,
            openingDate: openingDate,
            timeSpanDays: timeSpanDays,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String foodName,
            required DateTime expirationDate,
            Value<DateTime?> openingDate = const Value.absent(),
            Value<int?> timeSpanDays = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              FoodsCompanion.insert(
            id: id,
            foodName: foodName,
            expirationDate: expirationDate,
            openingDate: openingDate,
            timeSpanDays: timeSpanDays,
            quantity: quantity,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodsTable,
    Food,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (Food, BaseReferences<_$AppDatabase, $FoodsTable, Food>),
    Food,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodsTableTableManager get foods =>
      $$FoodsTableTableManager(_db, _db.foods);
}
