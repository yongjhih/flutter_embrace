# flutter_embrace

## Usage

```dart
Embrace.initialize(); // for http logging

MaterialApp(
  navigatorObservers: [EmbraceRouteObserver()], // for view logging
);
```

More APIs for flutter: https://github.com/yongjhih/flutter_embrace/blob/master/lib/flutter_embrace.dart

## Installation

pubspec.yaml

```yaml
dependencies:
  flutter_embrace:
    git:
      url: https://github.com/yongjhih/flutter_embrace.git
```
