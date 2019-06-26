import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(5.0),
      children: <Widget>[
        NoteListItem(
          uploadedFile: UploadedFile(
              'DAA Notes',
              'ma' 'am ke diye hue notes',
              DateTime.now(),
              'shadowleaf.satyajit',
              'New Doc Something.pdf',
              '120Kb',
              'https://somebigassurl'),
        )
      ],
    );
  }
}

class NoteListItem extends StatelessWidget {
  final UploadedFile uploadedFile;

  const NoteListItem({Key key, this.uploadedFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white30,
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${uploadedFile.title}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Text(
              '${uploadedFile.description}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white70,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Text('File : ${uploadedFile.filename} Size: ${uploadedFile.size}'),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Text('Uploaded By : ${uploadedFile.uploaderUsername}'),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Row(
              children: <Widget>[
                Icon(Icons.file_download),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UploadedFile {
  final String title;
  final String description;
  final DateTime dateUploaded;
  final String uploaderUsername;
  final String filename;
  final String size;
  final String downloadUrl;

  UploadedFile(this.title, this.description, this.dateUploaded,
      this.uploaderUsername, this.filename, this.size, this.downloadUrl);
}
