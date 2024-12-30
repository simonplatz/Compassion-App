import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompassionTherapy extends Course {
  CompassionTherapy()
      : super(
          id: '2',
          title: 'Lær om Selv-Compassion',
          description: 'Oplev mulighed for bedre selvværd.',
          imageUrl: 'assets/images/compassion_focused_therapy.webp',
        );

  @override
  Widget buildContent() {
    return const CompassionTherapyContent();
  }
}

class CompassionTherapyContent extends StatefulWidget {
  const CompassionTherapyContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CompassionTherapyContentState createState() =>
      _CompassionTherapyContentState();
}

class _CompassionTherapyContentState extends State<CompassionTherapyContent> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onScroll(); // Initialize scroll progress
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    setState(() {
      _scrollProgress = (currentScroll / maxScrollExtent) * 100;
    });

    if (_scrollProgress == 100 && mounted) {
      final courseManager = Provider.of<CourseManager>(context, listen: false);
      courseManager.markCourseAsCompleted(CompassionTherapy().title);
    }
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
                    backgroundColor: _selectedOption == option
                        ? Colors.teal.shade700
                        : Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedOption = option;
                      _showReflectionDialog();
                    });
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
  void _showReflectionDialog() {
    // ignore: unused_local_variable
    String reflectionText = '';
    if (_selectedOption == null) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Reflekter over hvad du har lært',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Du valgte: $_selectedOption',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  reflectionText = value;
                },
                decoration: InputDecoration(
                  hintText: 'Skriv dine tanker her...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Annuller',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Gem'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSection(String title, String content, {Color? backgroundColor}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColor != null
              ? [backgroundColor.withOpacity(0.8), backgroundColor]
              : [Colors.teal.shade100, Colors.teal.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 10.0),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberedSection(String title, List<String> points,
      {Color? backgroundColor}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColor != null
              ? [backgroundColor.withOpacity(0.8), backgroundColor]
              : [Colors.teal.shade100, Colors.teal.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8.0),
            ...points.asMap().entries.map((entry) {
              int idx = entry.key + 1;
              String point = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '$idx. $point',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade100, Colors.teal.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                          'assets/images/compassion_focused_therapy.webp'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                _buildSection(
                  'Hvad er compassion-fokuseret terapi?',
                  'Compassion-fokuseret terapi (CFT) er en terapiform, der primært retter sig mod mennesker med lavt selvværd, svære følelser, skam eller vedvarende selvkritik.',
                  backgroundColor: Colors.teal.shade200,
                ),
                _buildSection(
                  '',
                  'Terapien kombinerer teknikker fra kognitiv adfærdsterapi, mindfulness og buddhistisk medfølelsestræning. \n \n CFT anvendes ofte til personer med symptomer på depression, angst og stress og kan give værktøjer til at bryde den onde cirkel af skam og selvkritik, der ofte forstærker de psykiske problemer.',
                  backgroundColor: Colors.teal.shade100,
                ),
                _buildSection(
                  'Hvad kan du opnå?',
                  'Målet med CFT er at hjælpe mennesker med at udvikle en venligere, mere medfølende indstilling til sig selv og andre.',
                  backgroundColor: Colors.teal.shade200,
                ),
                _buildSection(
                  '',
                  'Ved at møde sig selv med mere omsorg, kan man reducere selvkritik og negative selvvurderinger og dermed lindre den psykiske smerte.',
                  backgroundColor: Colors.teal.shade200,
                ),
                _buildSection(
                  '',
                  '',
                  backgroundColor: Colors.teal.shade100,
                ),
                _buildNumberedSection(
                  'Hvad kommer du til at arbejde med?',
                  [
                    'Selvmedfølelse: CFT arbejder med at øge din evne til selvomsorg og selvmedfølelse. Dette involverer at være mere tålmodig, venlig og accepterende over for dig selv, især i vanskelige tider.',
                    'Forståelse af følelser: CFT fokuserer på at udvikle en forståelse af de emotionelle systemer, som styrer vores følelser. Ifølge CFT er vores hjerner biologisk indrettet med forskellige systemer til trussel, drivkraft og ro. Mange oplever, at trusselsystemet ofte aktiveres ved selvkritik, mens ro- og medfølelsessystemerne er underudviklede. Terapien arbejder derfor på at styrke ro- og medfølelsessystemerne.',
                    'Mindfulness og visualisering: Mange CFT-teknikker inkluderer mindfulness og visualisering, hvor du træner evnen til at være til stede i nuet og på at visualisere en medfølende figur (f.eks. en person eller en del af dig selv), som kan give støtte og opmuntring.',
                    'Accept af sårbarhed: Et centralt aspekt er at acceptere din menneskelighed og de fejl, man kan begå, som en naturlig del af livet. Det kan hjælpe dig med at udvikle en større tolerance for egne fejl og sårbarheder.',
                  ],
                  backgroundColor: Colors.teal.shade200,
                ),
                const SizedBox(height: 10),
                _buildInteractiveElement(
                  'Hvordan føler du dig efter at have læst dette afsnit?',
                  ['Glad', 'Neutral', 'Trist', 'Forvirret'],
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
