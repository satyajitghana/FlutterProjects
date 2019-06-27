import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

class UploadRepository {
  final FirebaseStorage _storageRef;

  UploadRepository(FirebaseStorage storageRef)
      : assert(storageRef != null),
        _storageRef = storageRef;

  Future<void> uploadDocument(String filePath) async {
    final StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('notes/BSC207A/uploaded_files')
        .child('${Random().nextInt(10000).toString()}asdk213hj12sjk1h2w.pdf');
    File toUpload = File(filePath);
    final StorageUploadTask storageUploadTask =
        storageReference.putFile(toUpload);
    final String downloadUrl = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('Download Url : { $downloadUrl }');
  }
}
