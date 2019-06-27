import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/upload/bloc/bloc.dart';

import 'upload.dart';

class UploadScreen extends StatelessWidget {
  final String filePath;

  const UploadScreen({Key key, this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Files'),
      ),
      body: Center(
        child: BlocProvider<UploadBloc>(
          builder: (context) => UploadBloc(),
          child: UploadForm(
            filePath: filePath,
          ),
        ),
      ),
    );
  }
}
