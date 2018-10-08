import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:ClippingKK/model/httpError.dart';
import '../model/appConfig.dart';

class AuthRepository extends KKHttpClient {
  Future<User> login(String email, String password) async {
    HttpResponse response;
    try {
      final _resp = await this.client.post('/auth/login', data: {
        'email': email,
        'pwd': password,
      });

      response = HttpResponse.fromJSON(_resp.data);
    } on DioError catch(e) {
      print(e);
      return null;
    }

    if (response.status != 200) {
      return throw new KKHttpError(
        msg: response.msg
      );
    }
    String token = response.data["token"];
    this.updateJWTToken(token);

    FlutterSecureStorage().write(key: "jwt", value: token);
    return User.fromJSON(response.data["profile"]);
  }
}
