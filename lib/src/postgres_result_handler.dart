// Copyright (c) 2025- All postgres_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../postgres_dart_gdbc.dart';

class PostgresResultHandler {
  Map<pg.Type, GdbTypes> typeMapping = {
    pg.Type.smallInteger: GdbTypes.short,
    pg.Type.integer: GdbTypes.int,
    pg.Type.bigInteger: GdbTypes.long,
    pg.Type.real: GdbTypes.float,
    pg.Type.double: GdbTypes.double,
    pg.Type.varChar: GdbTypes.string,
    pg.Type.text: GdbTypes.string,
    pg.Type.boolean: GdbTypes.bool,
    pg.Type.date: GdbTypes.date,
    pg.Type.time: GdbTypes.time,
    pg.Type.timestamp: GdbTypes.timestamp,
    pg.Type.uuid: GdbTypes.string,
    pg.Type.json: GdbTypes.string,
    pg.Type.jsonb: GdbTypes.string,
    // MySQLColumnType.tinyType: GdbTypes.byte,
    // MySQLColumnType.shortType: GdbTypes.short,
    // MySQLColumnType.longType: GdbTypes.long,
    // MySQLColumnType.floatType: GdbTypes.float,
    // MySQLColumnType.doubleType: GdbTypes.double,
    // MySQLColumnType.nullType: GdbTypes.none,
    // MySQLColumnType.timestampType: GdbTypes.timestamp,
    // MySQLColumnType.longLongType: GdbTypes.long,
    // MySQLColumnType.int24Type: GdbTypes.int,
    // MySQLColumnType.dateType: GdbTypes.date,
    // MySQLColumnType.timeType: GdbTypes.time,
    // MySQLColumnType.dateTimeType: GdbTypes.dateTime,
    // MySQLColumnType.yearType: GdbTypes.int,
    // MySQLColumnType.newDateType: GdbTypes.date,
    // MySQLColumnType.vatChartType: GdbTypes.unknown,
    // MySQLColumnType.bitType: GdbTypes.unknown,
    // MySQLColumnType.timestamp2Type: GdbTypes.timestamp,
    // MySQLColumnType.dateTime2Type: GdbTypes.dateTime,
    // MySQLColumnType.time2Type: GdbTypes.time,
    // MySQLColumnType.newDecimalType: GdbTypes.double,
    // MySQLColumnType.enumType: GdbTypes.short,
    // MySQLColumnType.setType: GdbTypes.set,
    // MySQLColumnType.tinyBlobType: GdbTypes.bytes,
    // MySQLColumnType.mediumBlobType: GdbTypes.bytes,
    // MySQLColumnType.longBlobType: GdbTypes.bytes,
    // MySQLColumnType.blocType: GdbTypes.bytes,
    // MySQLColumnType.varStringType: GdbTypes.string,
    // MySQLColumnType.stringType: GdbTypes.string,
    // MySQLColumnType.geometryType: GdbTypes.geo,
  };

  Future<ResultSet> handle(pg.Result rs) async {
    var metas =
        rs.schema.columns.map((col) {
          return ValueMetaData()
            ..name = col.columnName
            ..type = typeMapping[col.type];
        }).toList();
    var rows =
        rs.toList().map((row) {
          return row.toList();
        }).toList();
    return PostgresResultSet()
      ..rows = rows
      ..metas.addAll(metas);
  }
}
