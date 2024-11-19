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
}