import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:scoped_model/scoped_model.dart';

class AppConfig {
  static String jwtToken = "";
  static int uid = -1;
  // static bool isDev = bool.fromEnvironment("dart.vm.product");
  static bool isDev = false;
  static final String httpPrefix = "https://api.clippingkk.annatarhe.com/api";

  // static final String httpPrefix = isDev
  //     ? "http://localhost:9876/api"
  //     : "https://api.clippingkk.annatarhe.com/api";
}

class GlobalAppConfig extends Model {
  String _jwtToken = '';
  int _uid = -1;

  GlobalAppConfig() {
    this.update(AppConfig.jwtToken, AppConfig.uid);
  }

  String get jwtToken => _jwtToken;
  int get uid => _uid;

  void update(String token, int uid) {
    _jwtToken = token;
    _uid = uid;
    notifyListeners();
  }

  static GlobalAppConfig of(BuildContext ctx) {
    return ScopedModel.of<GlobalAppConfig>(ctx);
  }
}