import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:ruas_connect/notes/notes.dart';

class CourseArena extends StatefulWidget {
  final String courseCode;

  const CourseArena({Key key, this.courseCode}) : super(key: key);

  @override
  _CourseArenaState createState() => _CourseArenaState();
}

class _CourseArenaState extends State<CourseArena> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  int _selectedIndex = 0;

  final bottomNavbarItems = [
    BottomNavyBarItem(
        icon: Icon(Icons.library_books),
        title: Text('Notes'),
        activeColor: Colors.deepOrange),
    BottomNavyBarItem(
        icon: Icon(Icons.inbox),
        title: Text('Questions'),
        activeColor: Colors.limeAccent),
    BottomNavyBarItem(
        icon: Icon(Icons.error_outline),
        title: Text('Assignments'),
        activeColor: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 2.0,
                      color: Colors.white30,
                    ),
                  ),
                ),
                child: Image.asset('assets/cat.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(widget.courseCode),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
//        onPageChanged: onPageChanged,
        children: <Widget>[
          NotesScreen(),
          InnerPage(color: Colors.black26),
          InnerPage(color: Colors.black26),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
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
      child: Center(
        child: Text('UNDER DEVELOPEMENT'),
      ),
    );
  }
}
