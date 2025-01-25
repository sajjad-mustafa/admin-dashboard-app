import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseName;
  final String courseDescription;
 // const CourseDetailScreen({super.key, required courseName, required this.courseDescription});

  const CourseDetailScreen({
    Key? key,
    required this.courseName,
    required this.courseDescription,
}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Course Details'),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          courseDescription,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
