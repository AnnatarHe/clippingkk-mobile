import 'package:ClippingKK/components/appbar-title.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/model/appConfig.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/home.dart';
import './pages/profile.dart';
import './pages/squre.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() {
    return new IndexPageState();
  }
}

class IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  List<Widget> _tabs = [];

  @override
  initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 1000), () { _checkAuth(); });
  }

  void _checkAuth() async {
    if (AppConfig.jwtToken == '') {
      await Navigator.pushNamed(context, '/auth');
      this._checkAuth();
    }
    return;
  }

  Widget _getBody() {
    if (_tabs.length == 0) {
      _tabs.addAll([
        HomePage(),
        SqurePage(),
        ProfilePage(),
      ]);
    }

    return _tabs[_currentIndex];
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _childBuilder(BuildContext context, Widget child, GlobalAppConfig model) {
    if (model.jwtToken != "") {
      return this._getBody();
    }

    this._checkAuth();
    return Text("placeholder");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalAppConfig>(
      model: GlobalAppConfig(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitle(tabIndex: this._currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              title: Text('Square'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              title: Text('Profile'),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: _changeTab,
        ),
        body: ScopedModelDescendant<GlobalAppConfig>(builder: this._childBuilder)
      )
    );
  }
}