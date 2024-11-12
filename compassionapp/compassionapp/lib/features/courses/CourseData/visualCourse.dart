import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';

class VisualCourse extends Course {
  VisualCourse()
      : super(
          id: '4',
          title: 'Visual Course',
          description: 'Explore visual techniques.',
          imageUrl: 'assets/images/hearths.jpg',
        );

  @override
  Widget buildContent() {
    return VisualCourseContent();
  }
}

class VisualCourseContent extends StatefulWidget {
  const VisualCourseContent({super.key});

  @override
  _VisualCourseContentState createState() => _VisualCourseContentState();
}

class _VisualCourseContentState extends State<VisualCourseContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildSection(
                title: 'Introduction to Visual Techniques',
                content: 'Visual techniques can help you understand and process information more effectively...',
              ),
              _buildSection(
                title: 'Benefits of Visual Techniques',
                content: 'Using visual techniques can improve memory retention and enhance learning...',
              ),
              _buildSection(
                title: 'Types of Visual Techniques',
                content: 'There are various types of visual techniques, including mind mapping, flowcharts, and diagrams...',
              ),
              _buildSection(
                title: 'Visual Exercises',
                content: 'Try these exercises to practice visual techniques...',
              ),
              _buildFinalSection(context),
            ],
          ),
          if (_currentPage > 0)
            Positioned(
              left: 16.0,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 32),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          if (_currentPage < 4)
            Positioned(
              right: 16.0,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, size: 32),
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          if (_currentPage == 4)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Navigate to the next course or page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextCoursePage(), // Replace with the actual next course page
                    ),
                  );
                },
                child: const Text(
                  'Go to Next Course',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Congratulations!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'You have completed the Visual Course.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class NextCoursePage extends StatelessWidget {
  const NextCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Course'),
      ),
      body: Center(
        child: const Text('Content for the next course goes here.'),
      ),
    );
  }
}