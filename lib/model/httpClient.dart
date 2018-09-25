import 'dart:async';
import 'package:http/http.dart' as http;
import './config.dart';

class KKHttpClient extends http.BaseClient {
  final http.Client _inner = new http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['jwt-token'] = AppConfig.jwtToken;
    return _inner.send(request);
  }
}
