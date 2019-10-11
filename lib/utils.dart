import 'package:flutter/material.dart';

typedef OnPage<T> = void Function(PageRoute<T> value);

class SimpleRouteObserver<T> extends RouteObserver<PageRoute<T>> {
  final OnPage<T> onPage;
  SimpleRouteObserver({OnPage<T> onPage}) : onPage = onPage ?? emptyOnPage;

  static void emptyOnPage<T>(PageRoute<T> page) {
    print("emptyOnPage: ${page.settings.name}");
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      onPage(route);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      onPage(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      onPage(previousRoute);
    }
  }
}

class StackTraces {
  @visibleForTesting
  // FIXME
  static List<Map<String, String>> stackTraceElements(StackTrace stack) {
    return stackTraceElementsByLines(stack.toString().trimRight().split('\n'));
  }

  @visibleForTesting
  static List<Map<String, String>> stackTraceElementsByLines(List<String> lines) {
    final List<Map<String, String>> elements = <Map<String, String>>[];
    for (String line in lines) {
      final List<String> lineParts = line.split(RegExp('\\s+'));
      try {
        final String fileName = lineParts[0];
        final String lineNumber = lineParts[1].contains(":")
            ? lineParts[1].substring(0, lineParts[1].indexOf(":")).trim()
            : lineParts[1];

        final Map<String, String> element = <String, String>{
          'file': fileName,
          'line': lineNumber,
        };

        // The next section would throw an exception in some cases if there was no stop here.
        if (lineParts.length < 3) {
          elements.add(element);
          continue;
        }

        if (lineParts[2].contains(".")) {
          final String className =
          lineParts[2].substring(0, lineParts[2].indexOf(".")).trim();
          final String methodName =
          lineParts[2].substring(lineParts[2].indexOf(".") + 1).trim();

          element['class'] = className;
          element['method'] = methodName;
        } else {
          element['method'] = lineParts[2];
        }

        elements.add(element);
      } catch (e) {
        print(e.toString());
      }
    }
    return elements;
  }
}
