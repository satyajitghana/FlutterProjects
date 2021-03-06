import 'package:flutter/material.dart';
import 'package:ruas_connect/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/documents_bloc/bloc.dart';
import 'package:ruas_connect/models/models.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruas_connect/repository/respository.dart';

class AssignmentsScreen extends StatefulWidget {
  final String courseCode;

  const AssignmentsScreen({Key key, this.courseCode}) : super(key: key);

  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen>
    with AutomaticKeepAliveClientMixin<AssignmentsScreen> {
  final _scrollController = ScrollController();
  DocumentsBloc _documentsBloc;

  bool hasMoreDocuments = false;

  @override
  void initState() {
    super.initState();
    _documentsBloc =
        DocumentsBloc(arenaName: 'assignments', courseCode: widget.courseCode)
          ..dispatch(LoadDocuments());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      builder: (context) =>
          DocumentsBloc(arenaName: 'assignments', courseCode: widget.courseCode)
            ..dispatch(LoadDocuments()),
      child: BlocBuilder(
          bloc: _documentsBloc,
          builder: (context, DocumentsState state) {
            if (state is LoadingDocumentsState) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is EmptyDocumentsState) {
              return Container(
                child: Center(
                  child: Text('Its Lonely Here'),
                ),
              );
            } else if (state is LoadedDocumentsState) {
              hasMoreDocuments = state.hasMoreDocuments;
              return NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                    itemCount: _calculateListItemCount(state),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: index >= state.docs.length
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : NoteListItem(
                                documentUploaded: DocumentUploaded(
                                    document: state.docs[index].data)),
                      );
                    }),
              );
            } else {
              print('state : $state');
              return Center(
                child: Text('What state is this ? : $state'),
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

  @override
  bool get wantKeepAlive => true;
}

//class AssignmentsScreen extends StatelessWidget {
//  final String courseCode;
//
//  const AssignmentsScreen({Key key, this.courseCode}) : super(key: key);
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
                          onPressed: () async {
                            final ref = Firestore.instance
                                .collection(documentUploaded.arenaName)
                                .document(documentUploaded.courseCode)
                                .collection('uploaded_files')
                                .document(documentUploaded.uuid)
                                .collection('liked_by')
                                .document(
                                    (await UserRepository.getCurrentUser).uid);
                            await ref.setData({'liked': true});
                          },
                          color: Colors.transparent,
                          icon: Icon(Icons.thumb_up),
                          label:
                              Text('${documentUploaded.stats['like_count']}'),
                        ),
                        Text('Upvote'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: () async {
                            // fuken works !!!
                            await CloudFunctions.instance
                                .getHttpsCallable(
                                    functionName: 'updateViewCount')
                                .call({
                              'arenaName': documentUploaded.arenaName,
                              'courseCode': documentUploaded.courseCode,
                              'uuid': documentUploaded.uuid
                            });
                          },
                          color: Colors.transparent,
                          icon: Icon(Icons.info_outline),
                          label:
                              Text('${documentUploaded.stats['view_count']}'),
                        ),
                        Text('View'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                          color: Colors.transparent,
                          onPressed: () async {
                            // fuken works !!!
                            await CloudFunctions.instance
                                .getHttpsCallable(
                                    functionName: 'updateDownloadCount')
                                .call({
                              'arenaName': documentUploaded.arenaName,
                              'courseCode': documentUploaded.courseCode,
                              'uuid': documentUploaded.uuid
                            });
                          },
                          icon: Icon(Icons.file_download),
                          label: Text(
                              '${documentUploaded.stats['download_count']}'),
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
