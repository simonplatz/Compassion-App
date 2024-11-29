// lib/services/visisbility_manager.dart
import 'package:compassionapp/features/courses/CourseData/compassionTherapy.dart';
import 'package:compassionapp/features/courses/CourseData/mindfulnessCourse.dart';
import 'package:compassionapp/features/locations/location_data.dart';
import 'package:compassionapp/features/questions/questions_data.dart';
import 'package:flutter/material.dart';
import 'package:compassionapp/features/courses/CourseData/compassion_journey.dart';

class VisibilityManager extends ChangeNotifier {
  final Map<String, bool> _courseVisibility = {};
  final Map<String, bool> _locationVisibility = {};

  Map<String, bool> get courseVisibility => _courseVisibility;
  Map<String, bool> get locationVisibility => _locationVisibility;

  void updateVisibilityBasedOnAnswers({
    required String goal,
    required String experience,
    required String preference,
  }) {
    // Example algorithm to determine course visibility based on answers
    if (goal == QuestionOptions.goals[0] &&
        experience == QuestionOptions.experienceLevels[0] &&
        preference == QuestionOptions.learningStyles[0]) {
      _courseVisibility[MindfulnessCourse().title] = true;
      _courseVisibility[CompassionTherapy().title] = false;
      _courseVisibility[CompassionJourney().title] = true;

      _locationVisibility[LocationNames.sduPsykologiskRadgivning] = true;
      _locationVisibility[LocationNames.ventilenOdense] = true;
      _locationVisibility[LocationNames.livslinien] = false;
      _locationVisibility[LocationNames.psykologteametOdense] = true;
      _locationVisibility[LocationNames.odenseSocialkompas] = true;
    } else if (goal == QuestionOptions.goals[1] &&
        experience == QuestionOptions.experienceLevels[1] &&
        preference == QuestionOptions.learningStyles[1]) {
      _courseVisibility[MindfulnessCourse().title] = true;
      _courseVisibility[CompassionTherapy().title] = false;
      _courseVisibility[CompassionJourney().title] = false;

      _locationVisibility[LocationNames.sduPsykologiskRadgivning] = true;
      _locationVisibility[LocationNames.ventilenOdense] = false;
      _locationVisibility[LocationNames.livslinien] = true;
      _locationVisibility[LocationNames.psykologteametOdense] = false;
      _locationVisibility[LocationNames.odenseSocialkompas] = true;
    } else if (goal == QuestionOptions.goals[2] &&
        experience == QuestionOptions.experienceLevels[2] &&
        preference == QuestionOptions.learningStyles[2]) {
      _courseVisibility[MindfulnessCourse().title] = false;
      _courseVisibility[CompassionTherapy().title] = true;
      _courseVisibility[CompassionJourney().title] = false;

      _locationVisibility[LocationNames.sduPsykologiskRadgivning] = false;
      _locationVisibility[LocationNames.ventilenOdense] = true;
      _locationVisibility[LocationNames.livslinien] = true;
      _locationVisibility[LocationNames.psykologteametOdense] = true;
      _locationVisibility[LocationNames.odenseSocialkompas] = false;
    } else {
      _courseVisibility[MindfulnessCourse().title] = true;
      _courseVisibility[CompassionTherapy().title] = true;
      _courseVisibility[CompassionJourney().title] = true;

      _locationVisibility[LocationNames.sduPsykologiskRadgivning] = true;
      _locationVisibility[LocationNames.ventilenOdense] = true;
      _locationVisibility[LocationNames.livslinien] = true;
      _locationVisibility[LocationNames.psykologteametOdense] = true;
      _locationVisibility[LocationNames.odenseSocialkompas] = true;
    }
    notifyListeners();
  }
}