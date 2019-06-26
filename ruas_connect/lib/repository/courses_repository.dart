import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruas_connect/models/models.dart';

class CoursesRepository {
  Future<Map<String, String>> getCoursesOf(String branch, String semester) async {
    final coursesRef = Firestore
        .instance
        .collection('branch/$branch/$semester')
        .document('courses');
    final courses = await coursesRef.get();
    print(courses.data['course_list']);
    return Map<String, String>.from(courses.data['course_list']);
  }
}