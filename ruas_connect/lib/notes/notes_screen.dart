import 'package:flutter/material.dart';
import 'package:ruas_connect/models/models.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(5.0),
      children: <Widget>[
        NoteListItem(
          uploadedFile: UploadedFile(
              title: 'Engineering Mathematics Notes',
              description: 'ma' 'am ke diye hue notes',
              dateUploaded: DateTime.now(),
              uploaderUsername : 'shadowleaf.satyajit',
              filename : 'New Doc Something.pdf',
              size : '120Kb',
              uploaderUid : ''),
        ),
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
      color: Colors.blueGrey,
      elevation: 15.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.white30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${uploadedFile.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
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
                  Text(
                      'File : ${uploadedFile.filename} Size: ${uploadedFile.size}'),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text('Uploaded By : ${uploadedFile.uploaderUsername}'),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: () {},
                          color: Colors.transparent,
                          icon: Icon(Icons.thumb_up),
                          label: Text('2'),
                        ),
                        Text('Upvote'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: () {},
                          color: Colors.transparent,
                          icon: Icon(Icons.info_outline),
                          label: Text('2'),
                        ),
                        Text('View'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                          color: Colors.transparent,
                          onPressed: () {},
                          icon: Icon(Icons.file_download),
                          label: Text('10'),
                        ),
                        Text('Download'),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
