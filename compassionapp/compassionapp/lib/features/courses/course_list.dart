import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';
import 'course_card.dart';

class CourseList extends StatelessWidget {
  final List<Course> courses;
  final PageController pageController;
  final Function(int) onRemoveCourse;

  const CourseList({
    super.key,
    required this.courses,
    required this.pageController,
    required this.onRemoveCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 380, // Set a fixed height for the PageView
          child: PageView.builder(
            padEnds: false,
            allowImplicitScrolling: true,
            controller: pageController,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: CourseCard(course: courses[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
