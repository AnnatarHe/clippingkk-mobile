import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/profile.dart';
import './pages/squre.dart';
import './pages/auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClippingKK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _IndexPage(),
        '/auth': (context) => AuthPage()
      },
    );
  }
}

class _IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.crop_square)),
            Tab(icon: Icon(Icons.usb))
          ]
        ),
        title: Text('home'),
      ),
      body: TabBarView(
        children: [
          HomePage(),
          SqurePage(),
          ProfilePage()
        ]
      ),)
    );
  }
}

