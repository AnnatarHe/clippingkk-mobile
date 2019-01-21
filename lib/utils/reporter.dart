import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart';
import 'package:ClippingKK/model/appConfig.dart';

class Reporter {
  SentryClient _sentryClient;
  static final Reporter _reporter = new Reporter._internal();

  factory Reporter() {
    return _reporter;
  }

  Reporter._internal() {
    _sentryClient = new SentryClient(
        dsn: "https://76acd61ea02341739aa86941f5a931be@sentry.io/1251804");
    FlutterError.onError = (FlutterErrorDetails details) {
      if (AppConfig.debugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        this.capture(details.exception, details.stack);
      }
    };
  }

  void capture(Error err, StackTrace stackTrace) async {
    if (AppConfig.debugMode) {
      print(err);
      return;
    }

    await _sentryClient.captureException(
        exception: err, stackTrace: stackTrace);
  }
}
