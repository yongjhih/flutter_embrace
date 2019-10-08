import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_embrace/flutter_embrace.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_embrace');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return false;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('isStarted', () async {
    expect(await Embrace.isStarted, false);
  });
}
