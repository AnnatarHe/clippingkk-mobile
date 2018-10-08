import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/httpClient.dart';
import '../model/appConfig.dart';

class AuthRepository extends KKHttpClient {
  Future<User> login(String email, String password) async {
    final response = await this.client.post('/auth/login', data: {
      'email': email,
      'pwd': password,
    });

    String token = response.data["token"];
    AppConfig.jwtToken = token;
    this.updateJWTToken(token);

    FlutterSecureStorage().write(key: "jwt", value: token);
    return User.fromJSON(response.data["profile"]);
  }
}
