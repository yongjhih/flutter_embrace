[![pub package](https://img.shields.io/pub/v/flutter_embrace.svg)](https://pub.dev/packages/flutter_embrace)
[![Build Status](https://api.cirrus-ci.com/github/yongjhih/flutter_embrace.svg)](https://cirrus-ci.com/github/yongjhih/flutter_embrace)
<!--[![Build Status](https://travis-ci.org/yongjhih/flutter_embrace.svg?branch=master)](https://travis-ci.org/yongjhih/flutter_embrace)-->
[![codecov](https://codecov.io/gh/yongjhih/flutter_embrace/branch/master/graph/badge.svg)](https://codecov.io/gh/yongjhih/flutter_embrace)

# flutter_embrace

## Usage

```dart
Embrace.initialize(); // for http logging

MaterialApp(
  navigatorObservers: [EmbraceRouteObserver()], // for view logging
);
```

More APIs for flutter: https://pub.dev/documentation/flutter_embrace/latest/flutter_embrace/Embrace-class.html

EmbraceLogTree for Fimber: https://gist.github.com/yongjhih/9a203147eda126a407e2ed6cb841cae3

## Installation

pubspec.yaml

```yaml
dependencies:
  flutter_embrace:
    git:
      url: https://github.com/yongjhih/flutter_embrace.git
```

App.kt

```kt
class App : io.flutter.app.FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        Embrace.getInstance().start(this)
    }
}
```

AndroidManifest.xml

```xml
<manifest>
    <application
        android:name=".App">
    </application>
</manifest>
```

build.gradle

```gradle
dependencies {
    implementation "embrace-io:embrace-android-sdk:3.4.0"
}
```

## Test / Code Coverage

```sh
./coverage.sh && ./coverage.sh && ./coverage.sh --report
```

