// Copyright (c) 2025- All postgres_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../postgres_dart_gdbc.dart';

class PostgresConnection implements Connection {
  @override
  String? databaseName;

  @override
  Function()? onClose;

  @override
  String? version;

  late Map<String, dynamic> properties;
  pg.Connection? client;
  PostgresResultHandler handler = PostgresResultHandler();

  PostgresConnection._create(
    Uri address, {
    Map<String, dynamic>? properties,
    required Completer waiter,
    this.onClose,
  }) {
    this.properties = properties ?? <String, dynamic>{};
    databaseName = this.properties['db'];
    pg.Connection.open(
      pg.Endpoint(
        host: address.host,
        port: address.port,
        username: this.properties[DriverManager.usrKey],
        password: this.properties[DriverManager.pwdKey],
        database: this.properties['db'] ?? 'postgres',
      ),
      // The postgres server hosted locally doesn't have SSL by default. If you're
      // accessing a postgres server over the Internet, the server should support
      // SSL and you should swap out the mode with `SslMode.verifyFull`.
      settings: pg.ConnectionSettings(sslMode: pg.SslMode.disable),
    ).then((conn) {
      client = conn;
      waiter.complete();
    });
  }
  @override
  Future<void> close() async {
    client?.close().then((_) {
      onClose?.call();
    });
  }

  @override
  Future<void> commit() {
    // TODO: implement commit
    throw UnimplementedError();
  }

  @override
  Future<Statement> createStatement() {
    // TODO: implement createStatement
    throw UnimplementedError();
  }

  @override
  Future<ResultSet> executeQuery(
    String gql, {
    Map<String, dynamic>? params,
  }) async {
    // FIXME parameters are not supported in this implementation
    try {
      pg.Result rs = await client!.execute(gql, parameters: null);
      return await PostgresResultHandler().handle(rs);
    } catch (e) {
      return PostgresResultSet()
        ..success = false
        ..message = e.toString();
    }
  }

  @override
  Future<int> executeUpdate(String gql) {
    // TODO: implement executeUpdate
    throw UnimplementedError();
  }

  @override
  Future<bool> getAutoCommit() {
    // TODO: implement getAutoCommit
    throw UnimplementedError();
  }

  @override
  Future<ResultSetMetaData> getMetaData() {
    // TODO: implement getMetaData
    throw UnimplementedError();
  }

  @override
  Future<bool> isClosed() {
    // TODO: implement isClosed
    throw UnimplementedError();
  }

  @override
  Future<PreparedStatement> prepareStatement(
    String gql, {
    String Function(String, Map<String, dynamic>?)? render,
  }) async {
    return PostgresPreparedStatement(this, gql: gql, render: render);
  }

  @override
  Future<PreparedStatement> prepareStatementWithParameters(
    String gql,
    List<ParameterMetaData> parameters,
  ) {
    // TODO: implement prepareStatementWithParameters
    throw UnimplementedError();
  }

  @override
  Future<void> rollback() {
    // TODO: implement rollback
    throw UnimplementedError();
  }

  @override
  Future<void> setAutoCommit(bool autoCommit) {
    // TODO: implement setAutoCommit
    throw UnimplementedError();
  }

  // Implementation of PostgresConnection
}
