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
    Embrace.initialize(); // you still need to put Embrace.getInstance().start(Application) in the Application#onCreate() for Android, for monitoring launching
    _client = Client();

    Future.delayed(Duration.zero, () async {
      try {
        _isStarted = await Embrace.isStarted;
      } catch (err) {
      }
      try {
        final res = await _client.get("https://raw.githubusercontent.com/yongjhih/flutter_embrace/master/android/build.gradle#L1");
        print("url: ${Uris.string(res.request.url)}");
        print("url.hasFragment: ${res.request.url.hasFragment}");
        print("url.fragment: ${res.request.url.fragment}");
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
          body: SingleChildScrollView(child: Center(
            child: Column(
                children: [
                  Text('isStarted: $_isStarted\n'),
                  Text('$_body'),
                ]),
          ))),
    );
  }
}
