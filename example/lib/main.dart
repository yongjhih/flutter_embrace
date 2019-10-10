import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_embrace/flutter_embrace.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isStarted;
  Client _client;
  String _body;

  @override
  void initState() {
    super.initState();
    Embrace.initialize();
    _client = Client();

    Future.delayed(Duration.zero, () async {
      try {
        _isStarted = await Embrace.isStarted;
      } catch (err) {
      }
      try {
        final res = await _client.get("https://raw.githubusercontent.com/yongjhih/flutter_embrace/master/android/build.gradle");
        _body = res.body;
      } catch (err) {
        _body = "$err";
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _client?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
        Center(
          child: Text('isStarted: $_isStarted\n'),
        ),
          Center(
            child: Text('$_body'),
          ),
        ]),
      ),
    );
  }
}
