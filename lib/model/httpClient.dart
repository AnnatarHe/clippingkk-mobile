import 'dart:async';
import 'package:http/http.dart' as http;
import './appConfig.dart';

class KKHttpClient extends http.BaseClient {
  final http.Client _inner = new http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = AppConfig.jwtToken;
    return _inner.send(request);
  }
}
