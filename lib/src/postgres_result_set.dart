// Copyright (c) 2025- All postgres_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../postgres_dart_gdbc.dart';

class PostgresResultSet extends ResultSet {
  @override
  List<ValueMetaData> metas = [];

  @override
  List<List> rows = [];
}
