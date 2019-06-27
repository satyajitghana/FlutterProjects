import 'package:flutter/material.dart';

import 'upload.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Files'),
      ),
      body: UploadForm(),
    );
  }
}
