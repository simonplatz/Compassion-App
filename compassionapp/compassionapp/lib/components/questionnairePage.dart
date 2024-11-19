import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:compassionapp/features/courses/courseManager.dart';

// use a scoring-based system

// algorithms directed graph / DAG - 1
// Weighted Decision Tree -2
// Fuzzy Logic System - requires domain knowledge - 4
// Naive Bayes Classifier - probabiliy based -3
// Rule-Based System - if and else statements (not scale able) -


// in the future define them based previouse answers?

// they should be stored in the database

// some of these require alot of data and use machine learning to this task

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  String _goal = '';
  String _experience = '';
  String _preference = '';
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.teal,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            children: [
                              _buildQuestionPage(
                                question: 'What is your primary goal?',
                                options: ['Reduce Stress', 'Improve Focus', 'Enhance Compassion'],
                                groupValue: _goal,
                                onChanged: (value) {
                                  setState(() {
                                    _goal = value!;
                                  });
                                },
                              ),
                              _buildQuestionPage(
                                question: 'What is your experience level?',
                                options: ['Beginner', 'Intermediate', 'Advanced'],
                                groupValue: _experience,
                                onChanged: (value) {
                                  setState(() {
                                    _experience = value!;
                                  });
                                },
                              ),
                              _buildQuestionPage(
                                question: 'What is your preferred learning style?',
                                options: ['Visual', 'Auditory', 'Kinesthetic'],
                                groupValue: _preference,
                                onChanged: (value) {
                                  setState(() {
                                    _preference = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_currentPage > 0)
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        child: ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text('Previous', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    Positioned(
                      bottom: 16.0,
                      right: 16.0,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          if (_currentPage < 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<CourseManager>(context, listen: false).updateCourseVisibilityBasedOnAnswers(
                                goal: _goal,
                                experience: _experience,
                                preference: _preference,
                              );
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(_currentPage < 2 ? 'Next' : 'Submit', style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage({
    required String question,
    required List<String> options,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        })
      ],
    );
  }
}