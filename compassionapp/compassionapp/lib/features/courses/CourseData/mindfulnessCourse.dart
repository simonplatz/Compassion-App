import 'package:compassionapp/features/courses/CourseData/MindfulnesQuiz.dart';
import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MindfulnessCourse extends Course {
  MindfulnessCourse()
      : super(
          id: '1',
          title: 'Mindfulness',
          description:
              'Lær at praktisere mindfulness og opnå mental klarhed og ro.',
          imageUrl: 'assets/images/meditation.webp',
        );
  @override
  Widget buildContent() {
    return const MindfulnessCourseContent();
  }
}

class MindfulnessCourseContent extends StatefulWidget {
  const MindfulnessCourseContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MindfulnessCourseContentState createState() =>
      _MindfulnessCourseContentState();
}

class _MindfulnessCourseContentState extends State<MindfulnessCourseContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  // ignore: unused_field
  bool _isCourseCompleted = false;

  static const double arrowIconSize = 24.0;
  static const double arrowPositionOffset = 40.0;
  static const double arrowEdgePosition = -15.0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      if (_currentPage == 3) {
        // Assuming the last page index is 3
        _isCourseCompleted = true;
        final courseManager =
            Provider.of<CourseManager>(context, listen: false);
        courseManager.markCourseAsCompleted(MindfulnessCourse().title);
      }
    });
  }

  Widget _buildPage(
      {required String title,
      required String content,
      String? additionalContent}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/meditation.webp'),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
            if (additionalContent != null) ...[
              const SizedBox(height: 20),
              Text(
                additionalContent,
                style: const TextStyle(fontSize: 16),
              ),
            ],
            if (_currentPage == 3) ...[
              const SizedBox(height: 100),
              const Text(
                'Tag Mindfulness Quiz for at teste din viden:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MindfulnessQuiz()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                  ),
                ),
                child: const Text('Tag Mindfulness Quiz'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return _buildPage(
                          title: 'Hvad er mindfulness?',
                          content:
                              'Mindfulness er en praksis, hvor man er opmærksom på nuet uden at dømme. Det hjælper med at reducere stress og forbedre mental klarhed.',
                        );
                      case 1:
                        return _buildPage(
                          title: 'Mindfulness teknikker inkluderer:',
                          content:
                              '1. Åndedrætsøvelser: Fokus på vejrtrækningen for at bringe opmærksomheden til nuet.\n2. Kropsscanning: En teknik, hvor man systematisk fokuserer på forskellige dele af kroppen for at blive opmærksom på spændinger og afslapning.\n3. Mindful gåtur: At gå langsomt og bevidst, mens man er opmærksom på hvert skridt og omgivelserne.',
                        );
                      case 2:
                        return _buildPage(
                          title: 'Fordele ved mindfulness:',
                          content:
                              'Mindfulness kan hjælpe med at reducere stress, forbedre koncentration og øge følelsesmæssig regulering. Ved at praktisere mindfulness regelmæssigt kan man opleve en større følelse af ro og velvære.',
                        );
                      case 3:
                        return _buildPage(
                          title: 'Afslutning',
                          content:
                              'Tak fordi du deltog i mindfulness kurset. Vi håber, at du har lært noget værdifuldt og kan anvende teknikkerne i din dagligdag.',
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.teal,
                    dotColor: Colors.black,
                    dotHeight: 12.0,
                    dotWidth: 10.0,
                    expansionFactor: 4,
                    spacing: 4.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Swipe til venstre for at se mere (${4 - _currentPage - 1} sider tilbage)',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          if (_currentPage > 0)
            Positioned(
              left: arrowEdgePosition,
              top: MediaQuery.of(context).size.height / 2 - arrowPositionOffset,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: arrowIconSize),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          if (_currentPage < 3)
            Positioned(
              right: arrowEdgePosition,
              top: MediaQuery.of(context).size.height / 2 - arrowPositionOffset,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, size: arrowIconSize),
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
