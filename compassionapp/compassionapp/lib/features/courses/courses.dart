import 'package:flutter/material.dart';

abstract class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  Widget buildContent();
}