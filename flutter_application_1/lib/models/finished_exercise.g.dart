// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finished_exercise.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFinishedExerciseCollection on Isar {
  IsarCollection<FinishedExercise> get finishedExercises => this.collection();
}

const FinishedExerciseSchema = CollectionSchema(
  name: r'FinishedExercise',
  id: 7422432051351768808,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'exerciseId': PropertySchema(
      id: 1,
      name: r'exerciseId',
      type: IsarType.long,
    ),
    r'exerciseName': PropertySchema(
      id: 2,
      name: r'exerciseName',
      type: IsarType.string,
    ),
    r'reps': PropertySchema(
      id: 3,
      name: r'reps',
      type: IsarType.long,
    ),
    r'resistance': PropertySchema(
      id: 4,
      name: r'resistance',
      type: IsarType.long,
    ),
    r'sets': PropertySchema(
      id: 5,
      name: r'sets',
      type: IsarType.long,
    ),
    r'tmpDate': PropertySchema(
      id: 6,
      name: r'tmpDate',
      type: IsarType.dateTime,
    ),
    r'workoutId': PropertySchema(
      id: 7,
      name: r'workoutId',
      type: IsarType.long,
    )
  },
  estimateSize: _finishedExerciseEstimateSize,
  serialize: _finishedExerciseSerialize,
  deserialize: _finishedExerciseDeserialize,
  deserializeProp: _finishedExerciseDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _finishedExerciseGetId,
  getLinks: _finishedExerciseGetLinks,
  attach: _finishedExerciseAttach,
  version: '3.1.0+1',
);

int _finishedExerciseEstimateSize(
  FinishedExercise object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.exerciseName.length * 3;
  return bytesCount;
}

void _finishedExerciseSerialize(
  FinishedExercise object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.exerciseId);
  writer.writeString(offsets[2], object.exerciseName);
  writer.writeLong(offsets[3], object.reps);
  writer.writeLong(offsets[4], object.resistance);
  writer.writeLong(offsets[5], object.sets);
  writer.writeDateTime(offsets[6], object.tmpDate);
  writer.writeLong(offsets[7], object.workoutId);
}

FinishedExercise _finishedExerciseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FinishedExercise(
    exerciseId: reader.readLong(offsets[1]),
    reps: reader.readLong(offsets[3]),
    resistance: reader.readLong(offsets[4]),
    sets: reader.readLong(offsets[5]),
    tmpDate: reader.readDateTimeOrNull(offsets[6]),
    workoutId: reader.readLong(offsets[7]),
  );
  object.date = reader.readDateTime(offsets[0]);
  object.exerciseName = reader.readString(offsets[2]);
  object.id = id;
  return object;
}

P _finishedExerciseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _finishedExerciseGetId(FinishedExercise object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _finishedExerciseGetLinks(FinishedExercise object) {
  return [];
}

void _finishedExerciseAttach(
    IsarCollection<dynamic> col, Id id, FinishedExercise object) {
  object.id = id;
}

extension FinishedExerciseQueryWhereSort
    on QueryBuilder<FinishedExercise, FinishedExercise, QWhere> {
  QueryBuilder<FinishedExercise, FinishedExercise, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FinishedExerciseQueryWhere
    on QueryBuilder<FinishedExercise, FinishedExercise, QWhereClause> {
  QueryBuilder<FinishedExercise, FinishedExercise, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterWhereClause> idBetween(
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

extension FinishedExerciseQueryFilter
    on QueryBuilder<FinishedExercise, FinishedExercise, QFilterCondition> {
  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      dateGreaterThan(
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      dateLessThan(
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      dateBetween(
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      exerciseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      repsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      repsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      repsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      repsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      resistanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resistance',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      resistanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resistance',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      resistanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resistance',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      resistanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resistance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      setsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      setsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      setsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      setsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      tmpDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tmpDate',
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      tmpDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tmpDate',
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      tmpDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tmpDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      tmpDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tmpDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      tmpDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tmpDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      tmpDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tmpDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      workoutIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      workoutIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      workoutIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterFilterCondition>
      workoutIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FinishedExerciseQueryObject
    on QueryBuilder<FinishedExercise, FinishedExercise, QFilterCondition> {}

extension FinishedExerciseQueryLinks
    on QueryBuilder<FinishedExercise, FinishedExercise, QFilterCondition> {}

extension FinishedExerciseQuerySortBy
    on QueryBuilder<FinishedExercise, FinishedExercise, QSortBy> {
  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByExerciseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByExerciseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByExerciseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> sortByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByResistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resistance', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByResistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resistance', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> sortBySets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortBySetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByTmpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmpDate', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByTmpDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmpDate', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByWorkoutId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutId', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      sortByWorkoutIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutId', Sort.desc);
    });
  }
}

extension FinishedExerciseQuerySortThenBy
    on QueryBuilder<FinishedExercise, FinishedExercise, QSortThenBy> {
  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByExerciseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByExerciseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByExerciseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseName', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> thenByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByResistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resistance', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByResistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resistance', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy> thenBySets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenBySetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sets', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByTmpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmpDate', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByTmpDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tmpDate', Sort.desc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByWorkoutId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutId', Sort.asc);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QAfterSortBy>
      thenByWorkoutIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutId', Sort.desc);
    });
  }
}

extension FinishedExerciseQueryWhereDistinct
    on QueryBuilder<FinishedExercise, FinishedExercise, QDistinct> {
  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct>
      distinctByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseId');
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct>
      distinctByExerciseName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct> distinctByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reps');
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct>
      distinctByResistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resistance');
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct> distinctBySets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sets');
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct>
      distinctByTmpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tmpDate');
    });
  }

  QueryBuilder<FinishedExercise, FinishedExercise, QDistinct>
      distinctByWorkoutId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutId');
    });
  }
}

extension FinishedExerciseQueryProperty
    on QueryBuilder<FinishedExercise, FinishedExercise, QQueryProperty> {
  QueryBuilder<FinishedExercise, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FinishedExercise, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FinishedExercise, int, QQueryOperations> exerciseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseId');
    });
  }

  QueryBuilder<FinishedExercise, String, QQueryOperations>
      exerciseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseName');
    });
  }

  QueryBuilder<FinishedExercise, int, QQueryOperations> repsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reps');
    });
  }

  QueryBuilder<FinishedExercise, int, QQueryOperations> resistanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resistance');
    });
  }

  QueryBuilder<FinishedExercise, int, QQueryOperations> setsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sets');
    });
  }

  QueryBuilder<FinishedExercise, DateTime?, QQueryOperations>
      tmpDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tmpDate');
    });
  }

  QueryBuilder<FinishedExercise, int, QQueryOperations> workoutIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutId');
    });
  }
}
