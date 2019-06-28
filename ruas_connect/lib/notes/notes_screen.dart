import 'package:flutter/material.dart';
import 'package:ruas_connect/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/documents_bloc/bloc.dart';
import 'package:ruas_connect/models/models.dart';

class NotesScreen extends StatefulWidget {
  final String courseCode;

  const NotesScreen({Key key, this.courseCode}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _scrollController = ScrollController();
  DocumentsBloc _documentsBloc;

  bool hasMoreDocuments = false;

  @override
  void initState() {
    super.initState();
    _documentsBloc = BlocProvider.of<DocumentsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) =>
          DocumentsBloc(arenaName: 'notes', courseCode: widget.courseCode)
            ..dispatch(LoadDocuments()),
      child: BlocBuilder(
          bloc: _documentsBloc,
          builder: (context, DocumentsState state) {
            if (state is InitialDocumentsState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedDocumentsState) {
              hasMoreDocuments = state.hasMoreDocuments;
              return NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                    itemCount: _calculateListItemCount(state),
                    itemBuilder: (context, index) {
                      return index >= state.docs.length
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : NoteListItem(documentUploaded: DocumentUploaded( document: state.docs[index].data));
                    }),
              );
            }
          }),
    );
  }

  int _calculateListItemCount(LoadedDocumentsState state) {
    if (state.hasMoreDocuments) {
      return state.docs.length + 1;
    } else {
      return state.docs.length;
    }
  }

  bool _handleScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        hasMoreDocuments) {
      _documentsBloc.dispatch(LoadMoreDocuments());
    }

    return false;
  }
}

//class NotesScreen extends StatelessWidget {
//  final String courseCode;
//
//  const NotesScreen({Key key, this.courseCode}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ;
//
////    ListView(
////      padding: const EdgeInsets.all(5.0),
////      children: <Widget>[
////        NoteListItem(
////          uploadedFile: UploadedFile(
////              title: 'Engineering Mathematics Notes',
////              description: 'ma' 'am ke diye hue notes',
////              dateUploaded: DateTime.now(),
////              uploaderUsername: 'shadowleaf.satyajit',
////              filename: 'New Doc Something.pdf',
////              size: '120Kb',
////              uploaderUid: ''),
////        ),
////      ],
////    );
//  }
//}

class NoteListItem extends StatelessWidget {

  final DocumentUploaded documentUploaded;

  const NoteListItem({Key key, this.documentUploaded}) : super(key: key);

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
                    '${documentUploaded.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text(
                    '${documentUploaded.description}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white70,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text(
                      'File : ${documentUploaded.fileName} Size: ${documentUploaded.size}'),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text('Uploaded By : ${documentUploaded.uploaderUsername}'),
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
                          label: Text(documentUploaded.stats['like_count']),
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
                          label: Text(documentUploaded.stats['view_count']),
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
                          label: Text(documentUploaded.stats['download_count']),
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
