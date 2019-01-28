import 'package:logging/logging.dart';

class KKLogger {
  Logger _internalLogger;

  static final KKLogger _logger = new KKLogger._internal();

  factory KKLogger() {
    return _logger;
  }

  KKLogger._internal() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
    _internalLogger = new Logger('ClippingKK');
  }

  Logger getLogger() {
    return _internalLogger;
  }
}
