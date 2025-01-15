import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:scheduleme/utils/logger.dart';
import 'package:scheduleme/utils/type_registry.dart';

enum ApiStatus {
  success,
  failed;

  static ApiStatus fromString(String str) => switch (str) {
        "success" => ApiStatus.success,
        _ => ApiStatus.failed, // fallback
      };
}

class ApiResponse<T extends From<T>> {
  static ApiResponse<T> decodeResponse<T extends From<T>>(String str) {
    final decoded = json.decode(str);
    return ApiResponse<T>(
      ApiStatus.fromString(decoded["status"]),
      data: decoded["data"] != null
          ? TypeRegistry.instance.make<T>(decoded["data"])
          : null,
      error: decoded["error"] != null
          ? TypeRegistry.instance.make<ApiError>(decoded["error"])
          : null,
    );
  }

  ApiResponse(this.status, {this.data, this.error});

  final ApiStatus status;
  final T? data;
  final ApiError? error;
}

@immutable
class ApiError extends From<ApiError> {
  final int code;

  const ApiError(this.code);

  String get message => _errorCodes[code] ?? "Unknown error";

  static const _errorCodes = {
    400: "Bad Request",
    401: "Unauthorized",
    500: "Internal Server Error"
  };

  @override
  ApiError from(dynamic source) {
    return ApiError(source['code'] ?? 500);
  }
}

enum HttpMethod { get, post, put, delete }

class Client {
  Client._();
  static final _instance = Client._();
  static Client get instance => _instance;

  bool isMockingRequest = false;
  final Map<String, Map<HttpMethod, MockClient>> _mockServers = {};

  /// Registers a mock server with a specified handler
  void registerMock(String url, HttpMethod method,
      Future<http.Response> Function(http.Request) handler) {
    if (!isMockingRequest) return;
    final mockClient = MockClient((request) => handler(request));
    final mock = _mockServers[url] ?? {};
    mock[method] = mockClient;
    _mockServers[url] = mock;
  }

  /// Private helper to retrieve a mock client if available
  http.Client? _getMockClient(Uri url, HttpMethod method) {
    if (!isMockingRequest) return null;
    return _mockServers[url.path]?[method];
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final mockClient = _getMockClient(url, HttpMethod.get);
    if (mockClient != null) {
      return mockClient.get(url, headers: headers);
    }
    return http.get(url, headers: headers);
  }

  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final mockClient = _getMockClient(url, HttpMethod.post);
    if (mockClient != null) {
      return await mockClient.post(
        url,
        headers: headers,
        body: body,
      );
    }
    return http.post(
      url,
      headers: headers,
      body: body,
    );
  }
}
