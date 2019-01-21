import 'package:ClippingKK/model/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ClippingKK/utils/reporter.dart';
import './index.dart';
import './pages/auth.dart';

class _OnInit {
  static final _OnInit _handler = new _OnInit._internal();

  factory _OnInit() => _handler;

  _OnInit._internal();

  Future<void> execute() {
    this.initSentry();
    return this.preLoadUserInfo();
  }

  Future<void> preLoadUserInfo() async {
    final jwt = await FlutterSecureStorage().read(key: 'jwt');
    final uid = await FlutterSecureStorage().read(key: 'uid');
    AppConfig.jwtToken = jwt == null ? "" : jwt;
    AppConfig.uid = uid != null ? int.parse(uid) : -1;
  }

  void initSentry() {
    Reporter();
  }
}


void main() async {
  await _OnInit().execute();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClippingKK',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/auth': (context) => AuthPage()
      },
    );
  }
}

