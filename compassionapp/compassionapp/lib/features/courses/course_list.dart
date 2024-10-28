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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(courses[index].title),
                  subtitle: Text(courses[index].description),
                  leading: Image.asset(
                    courses[index].imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemoveCourse(index),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}