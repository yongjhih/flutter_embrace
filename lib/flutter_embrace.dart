import 'dart:async';

import 'package:flutter/services.dart';

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
  static Future<void> endSession() async => await _channel.invokeMethod('endSession');
  static Future<void> clearUserIdentifier() async => await _channel.invokeMethod('clearUserIdentifier');
}
