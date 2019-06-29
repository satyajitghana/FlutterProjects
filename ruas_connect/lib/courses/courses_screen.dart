import 'package:flutter/material.dart';
import 'package:ruas_connect/repository/respository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/courses/bloc/bloc.dart';
import 'courses.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> with AutomaticKeepAliveClientMixin<CoursesScreen> {
  final CoursesRepository coursesRepository = CoursesRepository();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        builder: (context) => CoursesBloc(coursesRepository: coursesRepository),
        child: CoursesCards());
  }

  @override
  bool get wantKeepAlive => true;
}

class CoursesCards extends StatelessWidget {
  const CoursesCards({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CoursesBloc _coursesBloc = BlocProvider.of<CoursesBloc>(context);

    return BlocBuilder(
      bloc: _coursesBloc,
      builder: (context, CoursesState state) {
        if (state is Uninitialized) {
          _coursesBloc.dispatch(LoadCourses('CSE', 'SEMESTER_02'));
          return Text('Loading');
        }

        if (state is CoursesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CoursesLoaded) {
          // return Text((state.coursesList).toString());
          List<Widget> courses = [];
          state.coursesList.forEach((key, val) {
            courses.add(CourseCard(
              courseCode: key,
              courseName: val,
            ));
          });

          return Container(
            padding: EdgeInsets.all(5.0),
            color: Colors.black12,
            child: Column(
              children: courses,
            ),
          );
        }

        if (state is CoursesLoadError) {
          return Center(
            child: Text('Loading Error'),
          );
        }
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final String courseCode, courseName;

  const CourseCard({Key key, this.courseCode, this.courseName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseArena(courseCode: courseCode),
            ),
          );
        },
        child: Container(
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 2.0,
                    color: Colors.white30,
                  ),
                ),
              ),
              child: Image.asset('assets/cat.png'),
            ),
            title: Text(courseName),
            subtitle: Text(courseCode),
          ),
        ),
      ),
      elevation: 8.0,
      margin: EdgeInsets.all(8.0),
    );
  }
}
