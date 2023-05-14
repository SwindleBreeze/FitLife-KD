// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_cycle.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSleepCycleCollection on Isar {
  IsarCollection<SleepCycle> get sleepCycles => this.collection();
}

const SleepCycleSchema = CollectionSchema(
  name: r'SleepCycle',
  id: -5807998620236137720,
  properties: {
    r'bedTime': PropertySchema(
      id: 0,
      name: r'bedTime',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'sleepCycleDate': PropertySchema(
      id: 2,
      name: r'sleepCycleDate',
      type: IsarType.dateTime,
    ),
    r'sleepTime': PropertySchema(
      id: 3,
      name: r'sleepTime',
      type: IsarType.long,
    ),
    r'wakeUpTime': PropertySchema(
      id: 4,
      name: r'wakeUpTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _sleepCycleEstimateSize,
  serialize: _sleepCycleSerialize,
  deserialize: _sleepCycleDeserialize,
  deserializeProp: _sleepCycleDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sleepCycleGetId,
  getLinks: _sleepCycleGetLinks,
  attach: _sleepCycleAttach,
  version: '3.1.0+1',
);

int _sleepCycleEstimateSize(
  SleepCycle object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sleepCycleSerialize(
  SleepCycle object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.bedTime);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDateTime(offsets[2], object.sleepCycleDate);
  writer.writeLong(offsets[3], object.sleepTime);
  writer.writeDateTime(offsets[4], object.wakeUpTime);
}

SleepCycle _sleepCycleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SleepCycle(
    bedTime: reader.readDateTime(offsets[0]),
    date: reader.readDateTime(offsets[1]),
    sleepTime: reader.readLong(offsets[3]),
    wakeUpTime: reader.readDateTime(offsets[4]),
  );
  object.id = id;
  return object;
}

P _sleepCycleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sleepCycleGetId(SleepCycle object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sleepCycleGetLinks(SleepCycle object) {
  return [];
}

void _sleepCycleAttach(IsarCollection<dynamic> col, Id id, SleepCycle object) {
  object.id = id;
}

extension SleepCycleQueryWhereSort
    on QueryBuilder<SleepCycle, SleepCycle, QWhere> {
  QueryBuilder<SleepCycle, SleepCycle, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SleepCycleQueryWhere
    on QueryBuilder<SleepCycle, SleepCycle, QWhereClause> {
  QueryBuilder<SleepCycle, SleepCycle, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepCycleQueryFilter
    on QueryBuilder<SleepCycle, SleepCycle, QFilterCondition> {
  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> bedTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bedTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      bedTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bedTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> bedTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bedTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> bedTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bedTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      sleepCycleDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sleepCycleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      sleepCycleDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sleepCycleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      sleepCycleDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sleepCycleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      sleepCycleDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sleepCycleDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> sleepTimeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sleepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      sleepTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sleepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> sleepTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sleepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> sleepTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sleepTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> wakeUpTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      wakeUpTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition>
      wakeUpTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterFilterCondition> wakeUpTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wakeUpTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SleepCycleQueryObject
    on QueryBuilder<SleepCycle, SleepCycle, QFilterCondition> {}

extension SleepCycleQueryLinks
    on QueryBuilder<SleepCycle, SleepCycle, QFilterCondition> {}

extension SleepCycleQuerySortBy
    on QueryBuilder<SleepCycle, SleepCycle, QSortBy> {
  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortByBedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bedTime', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortByBedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bedTime', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortBySleepCycleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepCycleDate', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy>
      sortBySleepCycleDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepCycleDate', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortBySleepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortBySleepTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> sortByWakeUpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.desc);
    });
  }
}

extension SleepCycleQuerySortThenBy
    on QueryBuilder<SleepCycle, SleepCycle, QSortThenBy> {
  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByBedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bedTime', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByBedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bedTime', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenBySleepCycleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepCycleDate', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy>
      thenBySleepCycleDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepCycleDate', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenBySleepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenBySleepTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.desc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.asc);
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QAfterSortBy> thenByWakeUpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.desc);
    });
  }
}

extension SleepCycleQueryWhereDistinct
    on QueryBuilder<SleepCycle, SleepCycle, QDistinct> {
  QueryBuilder<SleepCycle, SleepCycle, QDistinct> distinctByBedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bedTime');
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QDistinct> distinctBySleepCycleDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sleepCycleDate');
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QDistinct> distinctBySleepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sleepTime');
    });
  }

  QueryBuilder<SleepCycle, SleepCycle, QDistinct> distinctByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wakeUpTime');
    });
  }
}

extension SleepCycleQueryProperty
    on QueryBuilder<SleepCycle, SleepCycle, QQueryProperty> {
  QueryBuilder<SleepCycle, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SleepCycle, DateTime, QQueryOperations> bedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bedTime');
    });
  }

  QueryBuilder<SleepCycle, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<SleepCycle, DateTime, QQueryOperations>
      sleepCycleDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sleepCycleDate');
    });
  }

  QueryBuilder<SleepCycle, int, QQueryOperations> sleepTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sleepTime');
    });
  }

  QueryBuilder<SleepCycle, DateTime, QQueryOperations> wakeUpTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wakeUpTime');
    });
  }
}
