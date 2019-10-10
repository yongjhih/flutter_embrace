import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'uris.dart';

class Embrace {
  static const MethodChannel _channel =
      const MethodChannel('flutter_embrace');

  static Future<bool> get isStarted async => await _channel.invokeMethod('isStarted');
  static Future<void> start({bool enableIntegrationTesting}) async => await _channel.invokeMethod('start', enableIntegrationTesting);
  static Future<void> setUserIdentifier(String id) async => await _channel.invokeMethod('setUserIdentifier', id);
  static Future<void> setUsername(String name) async => await _channel.invokeMethod('setUsername', name);
  static Future<void> setUserEmail(String email) async => await _channel.invokeMethod('setUserEmail', email);
  static Future<void> logInfo(String message) async => await _channel.invokeMethod('logInfo', message);
  static Future<void> logWarning(String message) async => await _channel.invokeMethod('logWarning', message);
  static Future<void> logError(String message) async => await _channel.invokeMethod('logError', message);
  static Future<void> logBreadcrumb(String message) async => await _channel.invokeMethod('logBreadcrumb', message);
  static Future<void> setUserAsPayer() async => await _channel.invokeMethod('setUserAsPayer');
  static Future<void> clearUserAsPayer() async => await _channel.invokeMethod('clearUserAsPayer');
  static Future<void> clearAllUserPersonas() async => await _channel.invokeMethod('clearAllUserPersonas');
  static Future<void> setUserPersona(String value) async => await _channel.invokeMethod('setUserPersona', value);
  static Future<void> clearUserPersona(String value) async => await _channel.invokeMethod('clearUserPersona', value);
  static Future<void> endAppStartup() async => await _channel.invokeMethod('endAppStartup');
  static Future<void> startAppStartup() async => await _channel.invokeMethod('startAppStartup');
  static Future<void> endSession() async => await _channel.invokeMethod('endSession');
  static Future<void> clearUserIdentifier() async => await _channel.invokeMethod('clearUserIdentifier');
  static Future<void> logNetworkIoRequest(HttpClientRequest request, {
    DateTime startTime,
    DateTime endTime,
  }) async {
    startTime ??= DateTime.now();
    final response = await request.done;
    return await logNetworkIoRequestResponse(request, response, startTime: startTime, endTime: endTime);
  }

  static Future<void> logNetworkIoRequestResponse(HttpClientRequest request, HttpClientResponse response, {
    DateTime startTime,
    DateTime endTime,
  }) async => await logNetworkCall(
    url: Uris.string(request.uri),
    method: request.method,
    statusCode: response.statusCode,
    startTime: startTime,
    endTime: endTime,
    bytesSent: request.contentLength,
    bytesReceived: response.contentLength,
  );

  static Future<void> logNetworkResponse(BaseResponse res, {
    DateTime startTime,
    DateTime endTime,
  }) async => await logNetworkCall(
      url: Uris.string(res.request.url),
      method: res.request.method,
      statusCode: res.statusCode,
      startTime: startTime,
      endTime: endTime,
      bytesSent: res.request.contentLength,
      bytesReceived: res.contentLength,
    );

  static Future<void> logNetworkCall({
    @required
    String url,
    @required
    String method,
    @required
    int statusCode,
    DateTime startTime,
    DateTime endTime,
    int bytesSent = 0,
    int bytesReceived = 0,
  }) async => await _channel.invokeMethod('logNetworkCall', {
      "url": url,
      "method": method,
      "statusCode": statusCode,
      "startTime": (startTime ?? DateTime.now()).millisecondsSinceEpoch,
      "endTime": (endTime ?? DateTime.now()).millisecondsSinceEpoch,
      "bytesSent": bytesSent,
      "bytesReceived": bytesReceived,
    });

  static Future<void> logNetworkError({
    @required
    String url,
    @required
    String method,
    DateTime startTime,
    DateTime endTime,
    String errorType = "",
    String errorMessage = "",
  }) async => await _channel.invokeMethod('logNetworkError', {
      "url": url,
      "method": method,
      "startTime": (startTime ?? DateTime.now()).millisecondsSinceEpoch,
      "endTime": (endTime ?? DateTime.now()).millisecondsSinceEpoch,
      "errorType": errorType,
      "errorMessage": errorMessage,
    });

  static void initialize() {
    if (Platform.isAndroid) {
      HttpOverrides.global = EmbraceHttpOverrides(current: HttpOverrides.current);
    }
  }

  static Future<void> logView(String name) async => await _channel.invokeMethod('logView', name);
  static Future<void> logWebView(String name) async => await _channel.invokeMethod('logWebView', name);
  static Future<void> forceLogView(String name) async => await _channel.invokeMethod('forceLogView', name);
  static Future<void> stop() async => await _channel.invokeMethod('stop');
}

/// Should not use this after Embrace.initialize() because it has been overridden the global io.HttpClient already
class EmbraceHttpClient implements Client {

  final Client client;

  EmbraceHttpClient({Client client}) : client = client ?? Client();

  @override
  Future<Response> delete(dynamic url, {Map<String, String> headers}) {
    final startTime = DateTime.now();
    return client.delete(url, headers: headers).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  Future<Response> get(dynamic url, {Map<String, String> headers}) {
    final startTime = DateTime.now();
    return client.get(url, headers: headers).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  Future<Response> head(dynamic url, {Map<String, String> headers}) {
    final startTime = DateTime.now();
    return client.head(url, headers: headers).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  Future<Response> patch(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding}) {
    final startTime = DateTime.now();
    return client.patch(url, headers: headers, encoding: encoding).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  Future<Response> post(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding}) {
    final startTime = DateTime.now();
    return client.post(url, headers: headers, encoding: encoding).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  Future<Response> put(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding}) {
    final startTime = DateTime.now();
    return client.put(url, headers: headers, encoding: encoding).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  Future<String> read(dynamic url, {Map<String, String> headers}) {
    return client.read(url, headers: headers).then((res) {
      return res;
    });
  }

  @override
  Future<Uint8List> readBytes(dynamic url, {Map<String, String> headers}) {
    return client.readBytes(url, headers: headers).then((res) {
      return res;
    });
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    final startTime = DateTime.now();
    return client.send(request).then((response) {
      Embrace.logNetworkResponse(response, startTime: startTime);
      return response;
    });
  }

  @override
  void close() {
    client.close();
  }
}

/// Used to use with EmbraceHttpOverrides
class EmbraceIoHttpClient implements HttpClient {

  final HttpClient client;

  EmbraceIoHttpClient({HttpClient client}) : client = client ?? HttpClient();

  @override
  set autoUncompress(bool au) => client.autoUncompress = au;

  @override
  set connectionTimeout(Duration ct) => client.connectionTimeout = ct;

  @override
  set idleTimeout(Duration it) => client.idleTimeout = it;

  @override
  set maxConnectionsPerHost(int mcph) => client.maxConnectionsPerHost = mcph;

  @override
  set userAgent (String ua) => client.userAgent = ua;

  @override
  bool get autoUncompress => client.autoUncompress;

  @override
  Duration get connectionTimeout => client.connectionTimeout;

  @override
  Duration get idleTimeout => client.idleTimeout;

  @override
  int get maxConnectionsPerHost => client.maxConnectionsPerHost;

  @override
  String get userAgent => client.userAgent;

  @override
  void addCredentials(
      Uri url, String realm, HttpClientCredentials credentials) {
    client.addCredentials(url, realm, credentials);
  }

  @override
  void addProxyCredentials(
      String host, int port, String realm, HttpClientCredentials credentials) {
    client.addProxyCredentials(host, port, realm, credentials);
  }

  @override
  set authenticate(
      Future<bool> Function(Uri url, String scheme, String realm) f) {
    client.authenticate = f;
  }

  @override
  set authenticateProxy(
      Future<bool> Function(String host, int port, String scheme, String realm)
      f) {
    client.authenticateProxy = f;
  }

  @override
  set badCertificateCallback(
      bool Function(X509Certificate cert, String host, int port) callback) {
    client.badCertificateCallback = callback;
  }

  @override
  void close({bool force = false}) {
    client.close(force: force);
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) {
    return client.delete(host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) {
    return client.deleteUrl(url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  set findProxy(String Function(Uri url) f) {
    client.findProxy = f;
  }

  @override
  Future<HttpClientRequest> get(String host, int port, String path) {
    return client.get(host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) {
    return client.getUrl(url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> head(String host, int port, String path) {
    return client.head(host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> headUrl(Uri url) {
    return client.headUrl(url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> open(
      String method, String host, int port, String path) {
    return client.open(method, host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    return client.openUrl(method, url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) {
    return client.patch(host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> patchUrl(Uri url) {
    return client.patchUrl(url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> post(String host, int port, String path) {
    return client.post(host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> postUrl(Uri url) {
    return client.postUrl(url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> put(String host, int port, String path) {
    return client.put(host, port, path).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }

  @override
  Future<HttpClientRequest> putUrl(Uri url) {
    return client.putUrl(url).then((HttpClientRequest request) async {
      Embrace.logNetworkIoRequest(request);
      return request;
    });
  }
}

class EmbraceHttpOverrides extends HttpOverrides {
  final String Function(Uri url, Map<String, String> environment)
  findProxyFromEnvironmentFn;
  final HttpClient Function(SecurityContext context) createHttpClientFn;
  final HttpOverrides current;

  EmbraceHttpOverrides({
    this.current,
    this.findProxyFromEnvironmentFn,
    this.createHttpClientFn,
  });

  @override
  HttpClient createHttpClient(SecurityContext context) {
    final client = createHttpClientFn != null
        ? createHttpClientFn(context)
        : current?.createHttpClient(context) ?? super.createHttpClient(context);

    return Platform.isAndroid ? EmbraceIoHttpClient(client: client): client;
  }

  @override
  String findProxyFromEnvironment(Uri url, Map<String, String> environment) {
    return findProxyFromEnvironmentFn != null
        ? findProxyFromEnvironmentFn(url, environment)
        : super.findProxyFromEnvironment(url, environment);
  }
}
