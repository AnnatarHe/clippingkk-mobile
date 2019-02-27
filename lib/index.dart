import 'package:ClippingKK/components/appbar-title.dart';
import 'package:ClippingKK/pages/home-book.dart';
import 'package:ClippingKK/repository/misc.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/model/appConfig.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/home.dart';
import 'package:ClippingKK/pages/profile/profile.dart';
import './pages/squre.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() {
    return new IndexPageState();
  }
}

class IndexPageState extends State<IndexPage>
  with TickerProviderStateMixin<IndexPage> {
  int _currentIndex = 0;
  TabController _controller;

  List<Widget> _tabs = [
    HomeBooksPage(),
    SqurePage(),
    ProfilePage(),
  ];

  @override
  initState() {
    super.initState();
    this._controller = new TabController(length: _tabs.length, vsync: this);

    Future.delayed(const Duration(microseconds: 100), () {
      _checkAuth();
    });
    MiscRepository().checkUpdate().then((response) async {
      print(response);
      if (response.length == 0) {
        return;
      }

      final url = response[0].url;
      if (await canLaunch(url)) {
//        await launch(url);
      }
    });
  }

  void _checkAuth() async {
    if (AppConfig.jwtToken == '') {
      await Future.delayed(const Duration(milliseconds: 100));
      await Navigator.pushNamed(context, '/auth');
    }
    return;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _controller.animateTo(index,
        duration: new Duration(milliseconds: 1), curve: Curves.ease);
    });
  }

  Widget _childBuilder(BuildContext context, Widget child,
    GlobalAppConfig model) {
    if (model.jwtToken != "") {
      return TabBarView(
        children: _tabs,
        controller: _controller,
        physics: new NeverScrollableScrollPhysics(),
      );
    }

    return Center(child: Text("Login please"));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalAppConfig>(
      model: GlobalAppConfig(),
      child: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: AppBarTitle(tabIndex: this._currentIndex),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.directions_run),
                onPressed: () {
                  Navigator.pushNamed(context, "/auth");
                },
              )
            ],
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
          body: ScopedModelDescendant<GlobalAppConfig>(
            builder: this._childBuilder))));
  }
}
