import 'package:compassionapp/features/questions/questions_data.dart';
import 'package:compassionapp/services/visisbility_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.teal,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spørgeskema'),
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
                            children: questions.map((questionData) {
                              return _buildQuestionPage(
                                question: questionData.question,
                                options:
                                    List<String>.from(questionData.options),
                                groupValue:
                                    _getGroupValue(questionData.groupValue),
                                onChanged: (value) {
                                  setState(() {
                                    _setGroupValue(
                                        questionData.groupValue, value!);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                       child: _buildNavigationButton(questionLength: questions.length),
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

  String _getGroupValue(String groupValue) {
    switch (groupValue) {
      case 'goal':
        return _goal;
      case 'experience':
        return _experience;
      case 'preference':
        return _preference;
      default:
        return '';
    }
  }

  void _setGroupValue(String groupValue, String value) {
    switch (groupValue) {
      case 'goal':
        _goal = value;
        break;
      case 'experience':
        _experience = value;
        break;
      case 'preference':
        _preference = value;
        break;
    }
  }

  Widget _buildNavigationButton({required int questionLength}) {
    if (_currentPage > 0 && _currentPage < questionLength - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Forrige', style: TextStyle(fontSize: 16)),
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Næste', style: TextStyle(fontSize: 16)),
          ),
        ],
      );
    } else if (_currentPage == 0) {
      return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: const Text('Næste', style: TextStyle(fontSize: 16)),
      );
    } else {
      return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Provider.of<VisibilityManager>(context, listen: false)
                .updateVisibilityBasedOnAnswers(
              goal: _goal,
              experience: _experience,
              preference: _preference,
            );
            Navigator.pop(context);
          }
        },
        child: const Text('Indsend', style: TextStyle(fontSize: 16)),
      );
    }
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
