import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              onTap: () {},
              child: Container(
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 2.0,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                    child: FlutterLogo(
                      size: 40.0,
                    ),
                  ),
                  title: Text('Engineering Mathematics'),
                  subtitle: Text('BSC208A'),
                ),
              ),
            ),
            elevation: 8.0,
            margin: EdgeInsets.all(8.0),
          )
        ],
      ),
    );
  }
}
