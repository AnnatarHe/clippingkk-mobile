import 'package:ClippingKK/model/httpResponse.dart';
import 'package:dio/dio.dart';
import './appConfig.dart';

class KKHttpClient extends Dio {
  Dio client;

  KKHttpClient() {
    this.client = Dio(Options(
      baseUrl: AppConfig.httpPrefix,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));

    this.updateJWTToken(AppConfig.jwtToken);

    // this.client.interceptor.request.onSend = (Options options) {
    //   print('${options.baseUrl}${options.path} data: ${options.data}, ${options.headers}, ${options.extra}');
    //   return options;
    // };
  }

  updateJWTToken(String token) {
    this.client.options.headers = {'Authorization': 'Bearer $token'};
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

class UserProfileItem {
  User user;
  int clippingsCount;
  List<ClippingItem> clippings;

  UserProfileItem.fromJSON(dynamic json) {
    user = User.fromJSON(json['user']);
    clippingsCount = json['clippingsCount'];
    final List<dynamic> _clippings = json['clippings'].toList();
    clippings = _clippings.map((x) => ClippingItem.fromJSON(x)).toList();
  }
}
