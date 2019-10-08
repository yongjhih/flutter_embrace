import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_embrace/flutter_embrace.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_embrace');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterEmbrace.platformVersion, '42');
  });
}
