import 'dart:async';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import './appConfig.dart';
import './httpResponse.dart';

class KKHttpClient extends Dio {
  Dio client;

  KKHttpClient() {
    this.client = Dio(Options(
      baseUrl: AppConfig.httpPrefix,
      connectTimeout: 1000,
      receiveTimeout: 1000,
    ));

    this.updateJWTToken(AppConfig.jwtToken);
  }

  updateJWTToken(String token) {
    this.client.options.headers = {"Authorization": token};
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final bool checked;
  String jwtToken;

  User.fromJSON(dynamic json)
      : id = json["id"],
        name = json["name"],
        email = json['email'],
        avatar = json["avatar"],
        checked = json['checked'];
}
