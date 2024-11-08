import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';

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
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

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
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: _scrollProgress / 100,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
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
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // TODO: Handle button press
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Image.asset('assets/images/compassion_focused_therapy.webp'),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Oplev mulighed for bedre selvværd.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Hvad er compassion-fokuseret terapi?',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Compassion-fokuseret terapi (CFT) er en terapiform, der primært retter sig mod mennesker med lavt selvværd, svære følelser, skam eller vedvarende selvkritik.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Terapien kombinerer teknikker fra kognitiv adfærdsterapi, mindfulness og buddhistisk medfølelsestræning.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'CFT anvendes ofte til personer med symptomer på depression, angst og stress og kan give værktøjer til at bryde den onde cirkel af skam og selvkritik, der ofte forstærker de psykiske problemer.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Hvad kan du opnå?',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
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
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}