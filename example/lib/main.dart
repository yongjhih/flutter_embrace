import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_embrace/flutter_embrace.dart';
import 'package:http/http.dart';

void main() {
  // you still need to put Embrace.getInstance().start(Application) in the Application#onCreate() for Android, for monitoring launching
  Embrace.initialize();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    Embrace.crashFlutter(details);
    return ErrorWidget(details.exception);
  };
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [EmbraceRouteObserver()],
      routes: <String, WidgetBuilder> {
        '/screen2': (BuildContext context) => Screen2(),
        '/screen3': (BuildContext context) => Screen3(),
        '/crash': (BuildContext context) => CrashScreen(),
      },
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool _isStarted;
  Client _client;
  String _body;

  @override
  void initState() {
    super.initState();
    _client = Client();

    Future.delayed(Duration.zero, () async {
      try {
        _isStarted = await Embrace.isStarted;
      } catch (err) {
      }
      try {
        final res = await _client.get("https://github.com/yongjhih/flutter_embrace/blob/master/lib/flutter_embrace.dart#L1");
        print("url: ${res.request.url}");
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(child: Center(
          child: Column(
              children: [
                FlatButton(child: Text('Screen2'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/screen2');
                  },
                ),
                FlatButton(child: Text('Screen3'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/screen3');
                  },
                ),
                FlatButton(child: Text('Crash'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/crash');
                  },
                ),
                FlatButton(child: Text('Crash in background'),
                  onPressed: () {
                    Embrace.crashError(StateError("error"));
                  },
                ),
                Text('isStarted: $_isStarted\n'),
                Text('$_body'),
              ]),
        )));
  }
}

class CrashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2 createState() => _Screen2();
}

class _Screen2 extends State<Screen2> {
  Client _client;
  String _body;

  @override
  void initState() {
    super.initState();
    _client = Client();

    Future.delayed(Duration.zero, () async {
      try {
        final res = await _client.get("https://github.com/yongjhih/flutter_embrace/blob/master/lib/flutter_embrace.dart#L2");
        print("url: ${res.request.url}");
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
    return Scaffold(
          appBar: AppBar(
            title: const Text('Screen2'),
          ),
          body: SingleChildScrollView(child: Center(
            child: Column(
                children: [
                  FlatButton(child: Text('Screen3'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/screen3');
                    },
                  ),
                  Text('$_body'),
                ]),
          ))
    );
  }
}

class Screen3 extends StatefulWidget {
  @override
  _Screen3 createState() => _Screen3();
}

class _Screen3 extends State<Screen3> {
  Client _client;
  String _body;

  @override
  void initState() {
    super.initState();
    _client = Client();

    Future.delayed(Duration.zero, () async {
      try {
        final res = await _client.get("https://github.com/yongjhih/flutter_embrace/blob/master/lib/flutter_embrace.dart#L3");
        print("url: ${res.request.url}");
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Screen3'),
        ),
        body: SingleChildScrollView(child: Center(
          child: Column(
              children: [
                FlatButton(child: Text('Screen2'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/screen2');
                  },
                ),
                Text('$_body'),
              ]),
        ))
    );
  }
}
