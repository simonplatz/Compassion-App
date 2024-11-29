import 'package:compassionapp/features/courses/CourseData/compassionTherapy.dart';
import 'package:compassionapp/features/courses/CourseData/compassion_journey.dart';
import 'package:compassionapp/features/courses/CourseData/mindfulnessCourse.dart';
import 'package:flutter/material.dart';

abstract class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  bool completed;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.completed = false,
  });

  Widget buildContent();

  static List<Course> getCourses() {return courses;}
}

final List<Course> courses = [
  MindfulnessCourse(),
  CompassionTherapy(),
  CompassionJourney(),
];
