// Copyright (c) 2025- All postgres_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../postgres_dart_gdbc.dart';

class PostgresDriver extends Driver {
  @override
  bool acceptsURL(String url) {
    return url.startsWith('gdbc.postgres:');
  }

  @override
  Future<Connection> connect(
    String url, {
    Map<String, dynamic>? properties,
    Function()? onClose,
  }) async {
    var address = _parseURL(url);
    address.queryParameters.forEach((key, value) {
      properties![key] = value;
    });
    Completer waiter = Completer();
    var conn = PostgresConnection._create(
      address,
      properties: properties,
      waiter: waiter,
      onClose: onClose,
    );
    await waiter.future;
    return conn;
  }

  Uri _parseURL(String url) {
    var uri = Uri.parse(url);
    if (uri.scheme != 'gdbc.postgres' || uri.host.isEmpty || uri.port <= 0) {
      throw ArgumentError('Invalid URL: $url');
    }
    return uri;
  }
}
