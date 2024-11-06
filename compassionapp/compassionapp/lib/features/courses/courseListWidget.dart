import 'package:flutter/material.dart';
import 'package:compassionapp/features/courses/courses.dart';
import 'package:compassionapp/components/therapy_page.dart';

class CourseListWidget extends StatelessWidget {
  final List<Course> courses;

  const CourseListWidget({
    super.key,
    required this.courses,

  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TherapyPage(courseName: courses[index].title),
                  ),
                ),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8.0)),
                        child: Image.asset(
                          courses[index].imageUrl,
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courses[index].title,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                courses[index].description,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
