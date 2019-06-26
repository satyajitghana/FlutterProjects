import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/authentication_bloc/bloc.dart';
import 'package:ruas_connect/home_screen.dart';

import 'courses/courses.dart';
import 'settings/settings.dart';

class PageNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<PageNavigation> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  int _selectedIndex = 0;

  final bottomNavbarItems = [
    BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
      activeColor: Colors.red,
    ),
    BottomNavyBarItem(
        icon: Icon(Icons.library_books),
        title: Text('Courses'),
        activeColor: Colors.purpleAccent),
    BottomNavyBarItem(
        icon: Icon(Icons.message),
        title: Text('Messages'),
        activeColor: Colors.pink),
    BottomNavyBarItem(
        icon: Icon(Icons.info),
        title: Text('Updates'),
        activeColor: Colors.blue),
  ];

  String _title = '';
  Color _appBarBackground = Colors.blueGrey;

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _title = bottomNavbarItems[index].title.data;
      _appBarBackground = bottomNavbarItems[index].activeColor;
    });
  }

  @override
  void initState() {
    super.initState();
    _title = bottomNavbarItems[_selectedIndex].title.data;
    _appBarBackground = bottomNavbarItems[_selectedIndex].activeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarBackground,
        title: Text(_title),
        actions: <Widget>[
        IconButton(
            icon: Icon(Icons.settings),
            onPressed:() => Navigator.push(
                context,
            SlideRightRoute(page: SettingsScreen())))
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          HomeScreen(name: 'Hell'),
          CoursesScreen(),
          InnerPage(color: Colors.pink),
          InnerPage(color: Colors.blue),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            onPageChanged(index);
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
        items: bottomNavbarItems,
      ),
    );
  }
}

class InnerPage extends StatelessWidget {
  final Color color;

  const InnerPage({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        )
  );
}
