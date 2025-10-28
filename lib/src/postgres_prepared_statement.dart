// Copyright (c) 2025- All postgres_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../postgres_dart_gdbc.dart';

class PostgresPreparedStatement extends PostgresStatement
    implements PreparedStatement {
  List<ParameterMetaData>? parameters;
  String gql;
  String Function(String, Map<String, dynamic>?)? render;

  PostgresPreparedStatement(
    super.conn, {
    this.parameters,
    required this.gql,
    this.render,
  });

  @override
  Future<bool> execute({Map<String, dynamic>? params, String? gql}) async {
    var rs = await executeQuery(gql: gql, params: params);
    return rs.success;
  }

  @override
  Future<ResultSet> executeQuery({
    String? gql,
    Map<String, dynamic>? params,
  }) async {
    if (params != null && render != null) {
      gql = render?.call(gql ?? this.gql, params);
    }
    return super.executeQuery(gql: gql ?? this.gql, params: params);
  }

  @override
  Future<int> executeUpdate({String? gql, Map<String, dynamic>? params}) async {
    return super.executeUpdate(gql: gql, params: params);
  }
}
