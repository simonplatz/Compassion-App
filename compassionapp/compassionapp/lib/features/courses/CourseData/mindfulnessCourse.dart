import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MindfulnessCourse extends Course {
  MindfulnessCourse()
      : super(
          id: '1',
          title: 'Mindfulness',
          description: 'Lær omkring mindfulness.',
          imageUrl: 'assets/images/meditation.webp',
        );

  @override
  Widget buildContent() {
    return MindfulnessCourseContent();
  }
}

class MindfulnessCourseContent extends StatefulWidget {
  const MindfulnessCourseContent({super.key});

  @override
  _MindfulnessCourseContentState createState() => _MindfulnessCourseContentState();
}

class _MindfulnessCourseContentState extends State<MindfulnessCourseContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600, // Set a fixed height for the PageView
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: 4, // Updated to 4 pages
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return _buildPage1();
                case 1:
                  return _buildPage2();
                case 2:
                  return _buildPage3();
                case 3:
                  return _buildWrappingUpPage(); 
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
            effect: ExpandingDotsEffect(
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
            'Swipe left to see more (${4 - _currentPage - 1} pages left)',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPage1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/meditation.webp'),
            const SizedBox(height: 20),
            Text(
              'Lær omkring mindfulness.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hvad er mindfulness?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mindfulness er en praksis, hvor man er opmærksom på nuet uden at dømme. Det hjælper med at reducere stress og forbedre mental klarhed.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Mindfulness teknikker inkluderer:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Åndedrætsøvelser: Fokus på vejrtrækningen for at bringe opmærksomheden til nuet.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '2. Kropsscanning: En teknik, hvor man systematisk fokuserer på forskellige dele af kroppen for at blive opmærksom på spændinger og afslapning.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '3. Mindful gåtur: At gå langsomt og bevidst, mens man er opmærksom på hvert skridt og omgivelserne.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage3() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Fordele ved mindfulness:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mindfulness kan hjælpe med at reducere stress, forbedre koncentration og øge følelsesmæssig regulering.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ved at praktisere mindfulness regelmæssigt kan man opleve en større følelse af ro og velvære.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWrappingUpPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Afslutning',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tak fordi du deltog i mindfulness kurset. Vi håber, at du har lært noget værdifuldt og kan anvende teknikkerne i din dagligdag.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: const Text('Tilbage til kurssiden'),
            ),
          ],
        ),
      ),
    );
  }
}