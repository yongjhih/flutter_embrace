import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_embrace/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_embrace/flutter_embrace.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_embrace');
  final List<MethodCall> calls = <MethodCall>[];

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      calls.add(methodCall);
      switch (methodCall.method) {
        case 'isStarted':
          return false;
        case 'start:':
          return null;
        case 'setUserIdentifier':
          return null;
        case 'setUsername':
          return null;
        case 'setUserEmail':
          return null;
        case 'logInfo':
          return null;
        case 'logWarning':
          return null;
        case 'logError':
          return null;
        case 'logBreadcrumb':
          return null;
        case 'setUserAsPayer':
          return null;
        case 'clearUserAsPayer':
          return null;
        case 'clearAllUserPersonas':
          return null;
        case 'setUserPersona':
          return null;
        case 'clearUserPersona':
          return null;
        case 'endAppStartup':
          return null;
        case 'startAppStartup':
          return null;
        case 'endSession':
          return null;
        case 'clearUserIdentifier':
          return null;
        case 'logNetworkCall':
          return null;
        case 'logNetworkError':
          return null;
        case 'logView':
          return null;
        case 'logWebView':
          return null;
        case 'forceLogView':
          return null;
        case 'stop':
          return null;
        case 'crash':
          return null;
        default:
          return null;
      }
    });

  });

  tearDown(() {
    calls.clear();
    channel.setMockMethodCallHandler(null);
  });

  test('channel', () async {
    expect(Embrace.channel.name, 'flutter_embrace');
  });

  test('isStarted', () async {
    expect(await Embrace.isStarted, false);
    expect(
      calls,
      <Matcher>[isMethodCall('isStarted', arguments: null)],
    );
  });

  test('start', () async {
    await Embrace.start();
    expect(
      calls,
      <Matcher>[isMethodCall('start', arguments: null)],
    );
  });

  test('setUserIdentifier', () async {
    await Embrace.setUserIdentifier("");
    expect(
      calls,
      <Matcher>[isMethodCall('setUserIdentifier', arguments: "")],
    );
  });
  test('setUsername', () async {
    await Embrace.setUsername("");
    expect(
      calls,
      <Matcher>[isMethodCall('setUsername', arguments: "")],
    );
  });
  test('setUserEmail', () async {
    await Embrace.setUserEmail("");
    expect(
      calls,
      <Matcher>[isMethodCall('setUserEmail', arguments: "")],
    );
  });
  test('logInfo', () async {
    await Embrace.logInfo("");
    expect(
      calls,
      <Matcher>[isMethodCall('logInfo', arguments: "")],
    );
  });
  test('logWarning', () async {
    await Embrace.logWarning("");
    expect(
      calls,
      <Matcher>[isMethodCall('logWarning', arguments: "")],
    );
  });
  test('logError', () async {
    await Embrace.logError("");
    expect(
      calls,
      <Matcher>[isMethodCall('logError', arguments: "")],
    );
  });
  test('logBreadcrumb', () async {
    await Embrace.logBreadcrumb("");
    expect(
      calls,
      <Matcher>[isMethodCall('logBreadcrumb', arguments: "")],
    );
  });
  test('setUserAsPayer', () async {
    await Embrace.setUserAsPayer();
    expect(
      calls,
      <Matcher>[isMethodCall('setUserAsPayer', arguments: null)],
    );
  });
  test('clearUserAsPayer', () async {
    await Embrace.clearUserAsPayer();
    expect(
      calls,
      <Matcher>[isMethodCall('clearUserAsPayer', arguments: null)],
    );
  });
  test('clearAllUserPersonas', () async {
    await Embrace.clearAllUserPersonas();
    expect(
      calls,
      <Matcher>[isMethodCall('clearAllUserPersonas', arguments: null)],
    );
  });
  test('setUserPersona', () async {
    await Embrace.setUserPersona("");
    expect(
      calls,
      <Matcher>[isMethodCall('setUserPersona', arguments: "")],
    );
  });
  test('clearUserPersona', () async {
    await Embrace.clearUserPersona("");
    expect(
      calls,
      <Matcher>[isMethodCall('clearUserPersona', arguments: "")],
    );
  });
  test('endAppStartup', () async {
    await Embrace.endAppStartup();
    expect(
      calls,
      <Matcher>[isMethodCall('endAppStartup', arguments: null)],
    );
  });
  test('startAppStartup', () async {
    await Embrace.startAppStartup();
    expect(
      calls,
      <Matcher>[isMethodCall('startAppStartup', arguments: null)],
    );
  });
  test('endSession', () async {
    await Embrace.endSession();
    expect(
      calls,
      <Matcher>[isMethodCall('endSession', arguments: null)],
    );
  });
  test('clearUserIdentifier', () async {
    await Embrace.clearUserIdentifier();
    expect(
      calls,
      <Matcher>[isMethodCall('clearUserIdentifier', arguments: null)],
    );
  });

  test('logNetworkIoRequest', () async {
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    final mockRequest = MockHttpClientRequest();
    final mockResponse = MockHttpClientResponse();
    when<dynamic>(mockRequest.done)
        .thenAnswer((_) async => mockResponse);
    when<Uri>(mockRequest.uri)
        .thenAnswer((_) => Uri.parse("https://example.com/"));
    when<String>(mockRequest.method)
        .thenAnswer((_) => "GET");
    when<int>(mockRequest.contentLength)
        .thenAnswer((_) => 0);
    when<int>(mockResponse.statusCode)
        .thenAnswer((_) => 200);
    when<int>(mockResponse.contentLength)
        .thenAnswer((_) => 0);
    await Embrace.logNetworkIoRequest(
      mockRequest,
      startTime: startTime,
      endTime: endTime,
    );
    expect(
      calls,
      <Matcher>[isMethodCall('logNetworkCall', arguments: {
        "url": "https://example.com/",
        "method": "GET",
        "statusCode": 200,
        "startTime": startTime.millisecondsSinceEpoch,
        "endTime": endTime.millisecondsSinceEpoch,
        "bytesSent": 0,
        "bytesReceived": 0,
      })],
    );
    mockRequest.close();
  });
  test('logNetworkIoRequestResponse', () async {
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    final mockRequest = MockHttpClientRequest();
    final mockResponse = MockHttpClientResponse();
    when<dynamic>(mockRequest.done)
        .thenAnswer((_) async => mockResponse);
    when<Uri>(mockRequest.uri)
        .thenAnswer((_) => Uri.parse("https://example.com/"));
    when<String>(mockRequest.method)
        .thenAnswer((_) => "GET");
    when<int>(mockRequest.contentLength)
        .thenAnswer((_) => 0);
    when<int>(mockResponse.statusCode)
        .thenAnswer((_) => 200);
    when<int>(mockResponse.contentLength)
        .thenAnswer((_) => 0);
    await Embrace.logNetworkIoRequestResponse(
      mockRequest,
      mockResponse,
      startTime: startTime,
      endTime: endTime,
    );
    expect(
      calls,
      <Matcher>[isMethodCall('logNetworkCall', arguments: {
        "url": "https://example.com/",
        "method": "GET",
        "statusCode": 200,
        "startTime": startTime.millisecondsSinceEpoch,
        "endTime": endTime.millisecondsSinceEpoch,
        "bytesSent": 0,
        "bytesReceived": 0,
      })],
    );
    mockRequest.close();
  });
  test('logNetworkResponse', () async {
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    final mockRequest = MockBaseRequest();
    final mockResponse = MockBaseResponse();
    when<dynamic>(mockResponse.request)
        .thenAnswer((_) => mockRequest);
    when<Uri>(mockRequest.url)
        .thenAnswer((_) => Uri.parse("https://example.com/"));
    when<String>(mockRequest.method)
        .thenAnswer((_) => "GET");
    when<int>(mockRequest.contentLength)
        .thenAnswer((_) => 0);
    when<int>(mockResponse.statusCode)
        .thenAnswer((_) => 200);
    when<int>(mockResponse.contentLength)
        .thenAnswer((_) => 0);
    await Embrace.logNetworkResponse(
      mockResponse,
      startTime: startTime,
      endTime: endTime,
    );
    expect(
      calls,
      <Matcher>[isMethodCall('logNetworkCall', arguments: {
        "url": "https://example.com/",
        "method": "GET",
        "statusCode": 200,
        "startTime": startTime.millisecondsSinceEpoch,
        "endTime": endTime.millisecondsSinceEpoch,
        "bytesSent": 0,
        "bytesReceived": 0,
      })],
    );
  });
  test('logNetworkCall', () async {
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    await Embrace.logNetworkCall(
      url: "",
      method: "",
      statusCode: 200,
      startTime: startTime,
      endTime: endTime,
    );
    expect(
      calls,
      <Matcher>[isMethodCall('logNetworkCall', arguments: {
        "url": "",
        "method": "",
        "statusCode": 200,
        "startTime": startTime.millisecondsSinceEpoch,
        "endTime": endTime.millisecondsSinceEpoch,
        "bytesSent": 0,
        "bytesReceived": 0,
      })],
    );
  });
  test('logNetworkError', () async {
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    await Embrace.logNetworkError(
      url: "",
      method: "",
      startTime: startTime,
      endTime: endTime,
    );
    expect(
      calls,
      <Matcher>[isMethodCall('logNetworkError', arguments: {
        "url": "",
        "method": "",
        "startTime": startTime.millisecondsSinceEpoch,
        "endTime": endTime.millisecondsSinceEpoch,
        "errorType": "",
        "errorMessage": "",
      })],
    );
  });

  test('logView', () async {
    await Embrace.logView("");
    expect(
      calls,
      <Matcher>[isMethodCall('logView', arguments: "")],
    );
  });

  test('logWebView', () async {
    await Embrace.logWebView("");
    expect(
      calls,
      <Matcher>[isMethodCall('logWebView', arguments: "")],
    );
  });
  test('forceLogView', () async {
    await Embrace.forceLogView("");
    expect(
      calls,
      <Matcher>[isMethodCall('forceLogView', arguments: "")],
    );
  });
  test('stop', () async {
    await Embrace.stop();
    expect(
      calls,
      <Matcher>[isMethodCall('stop', arguments: null)],
    );
  });

  test('crash', () async {
    final mockStackTrace = MockStackTrace();
    await Embrace.crash("", mockStackTrace, context: "");
    expect(
      calls,
      <Matcher>[isMethodCall('crash', arguments: {
        'exception': '',
        'context': '',
        'information': '',
        'stackTraceElements': const [],
      })],
    );
  });

  test('initialize', () async {
    Embrace.initialize();
    expect(HttpOverrides.current.runtimeType, EmbraceHttpOverrides);
  });

  test('SimpleRouteObserver', () async {
    var onPageCalled = 0;
    final routeObs = SimpleRouteObserver(onPage: (page) {
      onPageCalled += 1;
    });
    final mockRoute = MockRoute();
    final mockPageRoute = MockPageRoute();
    routeObs.didPop(mockRoute, mockRoute);
    expect(onPageCalled, 0);
    routeObs.didPop(mockPageRoute, mockPageRoute);
    expect(onPageCalled, 1);
    routeObs.didPush(mockRoute, mockRoute);
    expect(onPageCalled, 1);
    routeObs.didPush(mockPageRoute, mockPageRoute);
    expect(onPageCalled, 2);
    routeObs.didReplace();
    expect(onPageCalled, 2);
    routeObs.didReplace(newRoute: mockRoute);
    expect(onPageCalled, 2);
    routeObs.didReplace(newRoute: mockPageRoute);
    expect(onPageCalled, 3);
  });

  test('EmbraceHttpClient.get()', () async {
    final mockClient = MockClient((req) async {
      return Response(json.encode({}), 200);
    });
    final client = EmbraceHttpClient(client: mockClient);
    await client.get("https://example.com/#EmbraceHttpClient.get()");
    await client.put("https://example.com/#EmbraceHttpClient.put()");
    await client.post("https://example.com/#EmbraceHttpClient.post()");
    await client.patch("https://example.com/#EmbraceHttpClient.patch()");
    await client.delete("https://example.com/#EmbraceHttpClient.delete()");
    await client.head("https://example.com/#EmbraceHttpClient.head()");
    await client.send(Request("GET", Uri.parse("https://example.com/#EmbraceHttpClient.get()")));
    await client.read("https://example.com/#EmbraceHttpClient.read()");
    await client.readBytes("https://example.com/#EmbraceHttpClient.readBytes()");
    final call = calls
        .where((it) => it.method == "logNetworkCall")
        .firstWhere((it) {
          final args = as<Map<dynamic, dynamic>>(it.arguments);
          return args['url'] == "https://example.com/#EmbraceHttpClient.get()";
        });
    final args = as<Map<dynamic, dynamic>>(call.arguments);
    expect(args['method'], "GET");
    expect(args['statusCode'], 200);
    client.close();
  });

  test('EmbraceIoHttpClient.get()', () async {
    final mockClient = MockHttpClient();
    final mockRequest = MockHttpClientRequest();
    final mockResponse = MockHttpClientResponse();
    when<dynamic>(mockRequest.done)
        .thenAnswer((_) async => mockResponse);
    when<Uri>(mockRequest.uri)
        .thenAnswer((_) => Uri.parse("https://example.com/#EmbraceIoHttpClient.get()"));
    when<String>(mockRequest.method)
        .thenAnswer((_) => "GET");
    when<int>(mockRequest.contentLength)
        .thenAnswer((_) => 0);
    when<int>(mockResponse.statusCode)
        .thenAnswer((_) => 200);
    when<int>(mockResponse.contentLength)
        .thenAnswer((_) => 0);
    HttpOverrides.global = SimpleHttpOverrides(mockClient);
    when<dynamic>(mockClient.get("example.com", 443, "/#EmbraceIoHttpClient.get()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.getUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.getUrl()")))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.put("example.com", 443, "/#EmbraceIoHttpClient.put()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.putUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.putUrl()")))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.delete("example.com", 443, "/#EmbraceIoHttpClient.delete()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.deleteUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.deleteUrl()")))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.patch("example.com", 443, "/#EmbraceIoHttpClient.patch()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.patchUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.patchUrl()")))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.post("example.com", 443, "/#EmbraceIoHttpClient.post()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.postUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.postUrl()")))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.head("example.com", 443, "/#EmbraceIoHttpClient.head()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.headUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.headUrl()")))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.open("GET", "example.com", 443, "/#EmbraceIoHttpClient.open()"))
        .thenAnswer((_) async => mockRequest);
    when<dynamic>(mockClient.openUrl("GET", Uri.parse("https://example.com/#EmbraceIoHttpClient.openUrl()")))
        .thenAnswer((_) async => mockRequest);

    final client = EmbraceIoHttpClient();
    await client.get("example.com", 443, "/#EmbraceIoHttpClient.get()");
    await client.getUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.getUrl()"));
    await client.put("example.com", 443, "/#EmbraceIoHttpClient.put()");
    await client.putUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.putUrl()"));
    await client.delete("example.com", 443, "/#EmbraceIoHttpClient.delete()");
    await client.deleteUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.deleteUrl()"));
    await client.patch("example.com", 443, "/#EmbraceIoHttpClient.patch()");
    await client.patchUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.patchUrl()"));
    await client.post("example.com", 443, "/#EmbraceIoHttpClient.post()");
    await client.postUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.postUrl()"));
    await client.head("example.com", 443, "/#EmbraceIoHttpClient.head()");
    await client.headUrl(Uri.parse("https://example.com/#EmbraceIoHttpClient.headUrl()"));
    await client.open("GET", "example.com", 443, "/#EmbraceIoHttpClient.open()");
    await client.openUrl("GET", Uri.parse("https://example.com/#EmbraceIoHttpClient.openUrl()"));
    final call = calls
        .where((it) => it.method == "logNetworkCall")
        .firstWhere((it) {
      final args = as<Map<dynamic, dynamic>>(it.arguments);
      return args['url'] == "https://example.com/#EmbraceIoHttpClient.get()";
    });

    client.autoUncompress = client.autoUncompress;
    client.connectionTimeout = client.connectionTimeout;
    client.idleTimeout = client.idleTimeout;
    client.maxConnectionsPerHost = client.maxConnectionsPerHost;
    client.userAgent = client.userAgent;
    client.autoUncompress = client.autoUncompress;
    client.connectionTimeout = client.connectionTimeout;
    client.idleTimeout = client.idleTimeout;
    client.maxConnectionsPerHost = client.maxConnectionsPerHost;
    client.findProxy = (_) => null;
    final args = as<Map<dynamic, dynamic>>(call.arguments);
    expect(args['method'], "GET");
    expect(args['statusCode'], 200);

    mockRequest.close();
    client.close();
  });
  test('EmbraceHttpOverrides', () async {
    final httpOverrides = EmbraceHttpOverrides();
    expect(httpOverrides.createHttpClient(SecurityContext()).runtimeType, EmbraceIoHttpClient);
    final httpOverrides2 = EmbraceHttpOverrides(createHttpClientFn: (context) => HttpClient(), findProxyFromEnvironmentFn: (uri, env) => "");
    expect(httpOverrides2.createHttpClient(SecurityContext()).runtimeType, EmbraceIoHttpClient);
    expect(httpOverrides2.findProxyFromEnvironment(null, null), "");
  });

  test('EmbraceRouteObserver', () async {
    final embraceRouteObserver = EmbraceRouteObserver();
    final mockPageRoute = MockPageRoute();

    when<dynamic>(mockPageRoute.settings)
        .thenAnswer((_) => RouteSettings(name: "/"));
    embraceRouteObserver.didPush(mockPageRoute, mockPageRoute);
    expect(
      calls,
      <Matcher>[isMethodCall('logView', arguments: "/")],
    );
  });
}

class MockSimpleRouteObserver extends Mock implements SimpleRouteObserver {}
class MockRoute extends Mock implements Route<dynamic> {}
class MockPageRoute extends Mock implements PageRoute<dynamic> {}
class MockHttpClientRequest extends Mock implements HttpClientRequest {}
class MockHttpClientResponse extends Mock implements HttpClientResponse {}
class MockBaseResponse extends Mock implements BaseResponse {}
class MockBaseRequest extends Mock implements BaseRequest {}
class MockStackTrace extends Mock implements StackTrace {}
class MockHttpClient extends Mock implements HttpClient {}

T as<T>(dynamic it) => it is T ? it : null;

class SimpleHttpOverrides extends HttpOverrides {
  SimpleHttpOverrides(this.client);
  final HttpClient client;

  @override
  HttpClient createHttpClient(SecurityContext context) => client;
}