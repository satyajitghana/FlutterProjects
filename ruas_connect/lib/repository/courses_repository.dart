import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruas_connect/models/models.dart';

class CoursesRepository {
  Future<void> getCoursesOf(String branch, String semester) async {
    final courses = await Firestore
        .instance
        .collection('$branch/$semester/courses')
        .getDocuments();
    print(courses);
  }
}