import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ruas_connect/models/models.dart';
import 'respository.dart';
import 'package:uuid/uuid.dart';

class CoursesRepository {
  Future<Map<String, String>> getCoursesOf(
      String branch, String semester) async {
    final coursesRef = Firestore.instance
        .collection('branch/$branch/$semester')
        .document('courses');
    final courses = await coursesRef.get();
    print(courses.data['course_list']);
    return Map<String, String>.from(courses.data['course_list']);
  }

  static Future<void> writeArenaFile(
      {UploadedFile uploadedFile,
      String courseCode,
      String arena,
      String filePath}) async {
    final user = await UserRepository.getCurrentUser;

    uploadedFile.uploaderUid = user.uid;
    uploadedFile.uploaderUsername = user.displayName;

    /// Replaced this with cloud function, that does it automatically
    /// Write to Global Reference
//    final globFileRef =
//        Firestore.instance.collection('$arena/$courseCode/uploaded_files');
//    final docId = (await globFileRef.add(uploadedFile.toJSON())).documentID;

    /// Write to User Reference
//    final userFileRef = Firestore.instance
//        .collection('users/${user.uid}/uploaded_files')
//        .document(docId);
//    await userFileRef.setData(uploadedFile.toJSON());

    /// Generate a Unique Time Based UUID, maybe to get the files based on
    /// time at a later stage ?
    String uuid = Uuid().v1();

    print('''writeArenaFile {
    uploadedFile : $uploadedFile,
    courseCode : $courseCode,
    arena : $arena
    filePath : $filePath }''');

    /// Upload the File
    UploadRepository uploadRepository =
        UploadRepository(FirebaseStorage.instance);
    final Map<String, String> metadata = {
      'uploaderUid': user.uid,
      'uploaderUsername': user.displayName,
      'title': uploadedFile.title,
      'description': uploadedFile.description,
      'courseCode' : courseCode,
      'arenaName' : arena,
      'uuid' : uuid,
      'fileName' : uploadedFile.filename,
    };
    await uploadRepository.uploadDocument(
        filename: '$uuid.pdf',
        filePath: filePath,
        metadata: metadata,
        uploadLocationWithFileName:
            'notes/$courseCode/uploaded_files/$uuid.pdf');
  }
}
