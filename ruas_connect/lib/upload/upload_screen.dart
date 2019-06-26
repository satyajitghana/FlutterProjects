import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Files'),
      ),
      body: Container(
        color: Colors.pink,
        child: Center(
          child: Text('Upload Screen', style: TextStyle(fontSize: 40.0),),
        ),
      ),
    );
  }
}
