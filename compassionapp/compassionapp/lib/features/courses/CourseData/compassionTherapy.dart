import 'package:compassionapp/features/courses/CourseData/visualCourse.dart';
import 'package:flutter/material.dart';
import 'package:compassionapp/features/courses/courses.dart';

class CompassionTherapy extends Course {
  CompassionTherapy()
      : super(
          id: '3',
          title: 'Compassion-Fokuseret Terapi',
          description: 'Oplev mulighed for bedre selvværd.',
          imageUrl: 'assets/images/contact-self-compassion-background.webp',
        );

  @override
  Widget buildContent() {
    return CompassionTherapyContent();
  }
}

class CompassionTherapyContent extends StatefulWidget {
  const CompassionTherapyContent({super.key});

  @override
  _CompassionTherapyContentState createState() => _CompassionTherapyContentState();
}

class _CompassionTherapyContentState extends State<CompassionTherapyContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String? _selectedOption;

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
              _buildIntroductionPage(),
              _buildUnderstandingSelfCompassionPage(),
              _buildDailyLifeCompassionPage(),
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
          if (_currentPage < 2)
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
        ],
      ),
    );
  }

  Widget _buildIntroductionPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/compassion_focused_therapy.webp'),
            const SizedBox(height: 20),
            const Text(
              'Hvad kan du opnå?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Mindfulness og visualisering: Mange CFT-teknikker inkluderer mindfulness og visualisering, hvor du træner evnen til at være til stede i nuet og på at visualisere en medfølende figur (f.eks. en person eller en del af dig selv), som kan give støtte og opmuntring.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Accept af sårbarhed: Et centralt aspekt er at acceptere din menneskelighed og de fejl, man kan begå, som en naturlig del af livet. Det kan hjælpe dig med at udvikle en større tolerance for egne fejl og sårbarheder.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            _buildInteractiveElement(
              'Hvordan føler du dig efter at have læst dette afsnit?',
              ['Glad', 'Neutral', 'Trist', 'Forvirret'],
            ),
            const SizedBox(height: 20),
            _buildQuiz(
              question: 'Hvad er en vigtig komponent i CFT?',
              options: ['Mindfulness', 'Selvkritik', 'Ignorering af følelser', 'Perfektionisme'],
              correctAnswer: 'Mindfulness',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnderstandingSelfCompassionPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forståelse af Selvmedfølelse',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Selvmedfølelse handler om at være venlig og forstående over for sig selv, især i tider med fejl og svigt. Det indebærer at anerkende, at lidelse og personlige mangler er en del af den fælles menneskelige oplevelse.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Komponenter af selvmedfølelse inkluderer selvvenlighed, fælles menneskelighed og mindfulness. Ved at praktisere disse komponenter kan du udvikle en sundere og mere støttende indre dialog.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            _buildInteractiveElement(
              'Hvordan føler du dig efter at have læst dette afsnit?',
              ['Glad', 'Neutral', 'Trist', 'Forvirret'],
            ),
            const SizedBox(height: 20),
            _buildExercise(
              title: 'Selvmedfølelse Øvelse',
              description: 'Skriv en venlig og støttende besked til dig selv, som du ville skrive til en god ven.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyLifeCompassionPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daglig Livsmedfølelse',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'At integrere medfølelse i dagligdagen kan forbedre din livskvalitet betydeligt. Det handler om at være opmærksom på dine egne behov og følelser og at handle på en måde, der støtter dit velbefindende.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Praktiske tips inkluderer at tage pauser, når du føler dig overvældet, at tale venligt til dig selv, og at engagere dig i aktiviteter, der bringer dig glæde og afslapning.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ved at praktisere daglig livsmedfølelse kan du opbygge en stærkere og mere støttende relation til dig selv, hvilket kan føre til større tilfredshed og lykke.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            _buildInteractiveElement(
              'Hvordan føler du dig efter at have læst dette afsnit?',
              ['Glad', 'Neutral', 'Trist', 'Forvirret'],
            ),
            const SizedBox(height: 20),
            _buildExercise(
              title: 'Daglig Medfølelse Øvelse',
              description: 'Planlæg en daglig rutine, der inkluderer tid til selvomsorg og medfølelse.',
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextCoursePage(), // Navigate to the next course
                    ),
                  );
                },
                child: const Text('Go to Next Course'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveElement(String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuiz({required String question, required List<String> options, required String correctAnswer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return ListTile(
              title: Text(option),
              leading: Radio<String>(
                value: option,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              final isCorrect = _selectedOption == correctAnswer;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(isCorrect ? 'Correct!' : 'Incorrect'),
                    content: Text(isCorrect
                        ? 'Great job! Mindfulness is indeed a key component of CFT.'
                        : 'Try again. Remember, mindfulness is a key component of CFT.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Submit Answer'),
          ),
        ),
      ],
    );
  }

  Widget _buildExercise({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            // Handle exercise completion
          },
          child: const Text(
            'Complete Exercise',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}