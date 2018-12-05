import 'package:ClippingKK/model/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './index.dart';
import './pages/auth.dart';

void main() async {
  final jwt = await FlutterSecureStorage().read(key: 'jwt');
  final uid = await FlutterSecureStorage().read(key: 'uid');
  AppConfig.jwtToken = jwt;
  AppConfig.uid = uid != null ? int.parse(uid) : -1;
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

