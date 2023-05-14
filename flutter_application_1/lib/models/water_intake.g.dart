// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_intake.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWaterIntakeCollection on Isar {
  IsarCollection<WaterIntake> get waterIntakes => this.collection();
}

const WaterIntakeSchema = CollectionSchema(
  name: r'WaterIntake',
  id: 8213131959002925129,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'maxWaterIntake': PropertySchema(
      id: 1,
      name: r'maxWaterIntake',
      type: IsarType.double,
    ),
    r'waterIntake': PropertySchema(
      id: 2,
      name: r'waterIntake',
      type: IsarType.double,
    )
  },
  estimateSize: _waterIntakeEstimateSize,
  serialize: _waterIntakeSerialize,
  deserialize: _waterIntakeDeserialize,
  deserializeProp: _waterIntakeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _waterIntakeGetId,
  getLinks: _waterIntakeGetLinks,
  attach: _waterIntakeAttach,
  version: '3.1.0+1',
);

int _waterIntakeEstimateSize(
  WaterIntake object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _waterIntakeSerialize(
  WaterIntake object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDouble(offsets[1], object.maxWaterIntake);
  writer.writeDouble(offsets[2], object.waterIntake);
}

WaterIntake _waterIntakeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WaterIntake(
    date: reader.readDateTime(offsets[0]),
    maxWaterIntake: reader.readDouble(offsets[1]),
    waterIntake: reader.readDouble(offsets[2]),
  );
  object.id = id;
  return object;
}

P _waterIntakeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _waterIntakeGetId(WaterIntake object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _waterIntakeGetLinks(WaterIntake object) {
  return [];
}

void _waterIntakeAttach(
    IsarCollection<dynamic> col, Id id, WaterIntake object) {
  object.id = id;
}

extension WaterIntakeQueryWhereSort
    on QueryBuilder<WaterIntake, WaterIntake, QWhere> {
  QueryBuilder<WaterIntake, WaterIntake, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WaterIntakeQueryWhere
    on QueryBuilder<WaterIntake, WaterIntake, QWhereClause> {
  QueryBuilder<WaterIntake, WaterIntake, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterWhereClause> idBetween(
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

extension WaterIntakeQueryFilter
    on QueryBuilder<WaterIntake, WaterIntake, QFilterCondition> {
  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      maxWaterIntakeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxWaterIntake',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      maxWaterIntakeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxWaterIntake',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      maxWaterIntakeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxWaterIntake',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      maxWaterIntakeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxWaterIntake',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      waterIntakeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterIntake',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      waterIntakeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterIntake',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      waterIntakeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterIntake',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterFilterCondition>
      waterIntakeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterIntake',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension WaterIntakeQueryObject
    on QueryBuilder<WaterIntake, WaterIntake, QFilterCondition> {}

extension WaterIntakeQueryLinks
    on QueryBuilder<WaterIntake, WaterIntake, QFilterCondition> {}

extension WaterIntakeQuerySortBy
    on QueryBuilder<WaterIntake, WaterIntake, QSortBy> {
  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> sortByMaxWaterIntake() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWaterIntake', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy>
      sortByMaxWaterIntakeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWaterIntake', Sort.desc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> sortByWaterIntake() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntake', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> sortByWaterIntakeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntake', Sort.desc);
    });
  }
}

extension WaterIntakeQuerySortThenBy
    on QueryBuilder<WaterIntake, WaterIntake, QSortThenBy> {
  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenByMaxWaterIntake() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWaterIntake', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy>
      thenByMaxWaterIntakeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWaterIntake', Sort.desc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenByWaterIntake() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntake', Sort.asc);
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QAfterSortBy> thenByWaterIntakeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntake', Sort.desc);
    });
  }
}

extension WaterIntakeQueryWhereDistinct
    on QueryBuilder<WaterIntake, WaterIntake, QDistinct> {
  QueryBuilder<WaterIntake, WaterIntake, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QDistinct> distinctByMaxWaterIntake() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxWaterIntake');
    });
  }

  QueryBuilder<WaterIntake, WaterIntake, QDistinct> distinctByWaterIntake() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterIntake');
    });
  }
}

extension WaterIntakeQueryProperty
    on QueryBuilder<WaterIntake, WaterIntake, QQueryProperty> {
  QueryBuilder<WaterIntake, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WaterIntake, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<WaterIntake, double, QQueryOperations> maxWaterIntakeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxWaterIntake');
    });
  }

  QueryBuilder<WaterIntake, double, QQueryOperations> waterIntakeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterIntake');
    });
  }
}
