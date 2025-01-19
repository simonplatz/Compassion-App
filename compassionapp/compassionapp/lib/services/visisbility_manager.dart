import 'package:compassionapp/features/DesionTree/decisionTreeNode.dart';
import 'package:compassionapp/features/DesionTree/decisiontreeclass.dart';
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

  final DecisionTree decisionTree;

  VisibilityManager()
    : decisionTree = DecisionTree(
        DecisionTreeNode(
          question: questions[0].question, // "Hvad er dit primære formål?"
          options: {
            'Reducere stress': DecisionTreeNode(
              question: questions[1].question, // "Hvad er dit erfaringsniveau?"
              options: {
                'Begynder': DecisionTreeNode(
                  question: questions[2].question, // "Hvad er din foretrukne læringsstil?"
                  options: {
                    'Visuel': DecisionTreeNode(results: ["MindfulnessCourse"]),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: ["CompassionJourney"]),
                  },
                ),
                'Mellem': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: ["CompassionTherapy"]),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: ["CompassionTherapy"]),
                  },
                ),
                'Avanceret': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: []),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: ["MindfulnessCourse"]),
                  },
                ),
              },
            ),
            'Forbedre fokus': DecisionTreeNode(
              question: questions[1].question,
              options: {
                'Begynder': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: ["MindfulnessCourse"]),
                    'Auditiv': DecisionTreeNode(results: []),
                    'Kinæstetisk': DecisionTreeNode(results: ["MindfulnessCourse"]),
                  },
                ),
                'Mellem': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: []),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: ["MindfulnessCourse"]),
                  },
                ),
                'Avanceret': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: ["MindfulnessCourse"]),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: []),
                  },
                ),
              },
            ),
            'Øge medfølelse': DecisionTreeNode(
              question: questions[1].question,
              options: {
                'Begynder': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: []),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: []),
                  },
                ),
                'Mellem': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: ["CompassionTherapy"]),
                    'Auditiv': DecisionTreeNode(results: []),
                    'Kinæstetisk': DecisionTreeNode(results: ["MindfulnessCourse"]),
                  },
                ),
                'Avanceret': DecisionTreeNode(
                  question: questions[2].question,
                  options: {
                    'Visuel': DecisionTreeNode(results: ["CompassionTherapy"]),
                    'Auditiv': DecisionTreeNode(results: ["CompassionJourney"]),
                    'Kinæstetisk': DecisionTreeNode(results: []),
                  },
                ),
              },
            ),
          },
        ),
      );

  void updateVisibilityBasedOnAnswers({
    required String goal,
    required String experience,
    required String preference,
  }) {
    List<String> answers = [goal, experience, preference];
    List<String> results = decisionTree.traverseTree(decisionTree.root, answers);

  // Initialize all course visibility to false
  _courseVisibility[MindfulnessCourse().title] = false;
  _courseVisibility[CompassionTherapy().title] = false;
  _courseVisibility[CompassionJourney().title] = false;

  _locationVisibility.clear();

    for (String result in results) {
      if (result == "MindfulnessCourse") {
        _courseVisibility[MindfulnessCourse().title] = true;
      } else if (result == "CompassionTherapy") {
        _courseVisibility[CompassionTherapy().title] = true;
      } else if (result == "CompassionJourney") {
        _courseVisibility[CompassionJourney().title] = true;
      }
    }

    // Update location visibility based on the results
    _locationVisibility[LocationNames.sduPsykologiskRadgivning] = results.contains("MindfulnessCourse");
    _locationVisibility[LocationNames.ventilenOdense] = results.contains("MindfulnessCourse");
    _locationVisibility[LocationNames.livslinien] = !results.contains("MindfulnessCourse");
    _locationVisibility[LocationNames.psykologteametOdense] = results.contains("MindfulnessCourse");
    _locationVisibility[LocationNames.odenseSocialkompas] = results.contains("MindfulnessCourse");

    notifyListeners();
  }
}