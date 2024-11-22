import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:compassionapp/features/courses/courses.dart';

class CompassionJourney extends Course {
  CompassionJourney()
      : super(
          id: '5',
          title: 'Medfølelsesrejse',
          description:
              'Tag på en rejse for at udforske og forbedre din medfølelse.',
          imageUrl: 'assets/images/hearths.jpg',
        );

  @override
  Widget buildContent() {
    return CompassionJourneyContent();
  }
}

class CompassionJourneyContent extends StatefulWidget {
  const CompassionJourneyContent({super.key});

  @override
  _CompassionJourneyContentState createState() =>
      _CompassionJourneyContentState();
}

class _CompassionJourneyContentState extends State<CompassionJourneyContent>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late YoutubePlayerController _youtubeController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    const String videoUrl = 'https://www.youtube.com/watch?v=B12354ThY2Q&t=4s';
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _youtubeController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(Source url) async {
    await _audioPlayer.play(url);
  }

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
              _buildMeditationPage(),
              _buildVideoPage(),
              _buildReflectionPage(),
              _buildAdditionalResourcesPage(),
              _buildConclusionPage(),
            ],
          ),
          if (_currentPage > 0)
            Positioned(
              left: 16.0,
              bottom: 16.0,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, size: 32, color: Colors.black),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          if (_currentPage < 5)
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward,
                    size: 32, color: Colors.black),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Velkommen til Medfølelsesrejse',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I dette kursus vil du tage på en rejse for at udforske og forbedre din medfølelse gennem forskellige interaktive elementer.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Dette kursus er designet til at hjælpe dig med at udvikle en dybere forståelse af medfølelse og hvordan du kan anvende det i dit daglige liv.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeditationPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Øv Meditation og Compassion Pause',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tag et øjeblik til at øve meditation og compassion pause. Lyt til de følgende lydklip for at guide dig gennem øvelserne.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  _buildAudioPlayer(
                    title: 'Meditation Lydklip 1',
                    onPressed: () {
                      _playAudio(AssetSource(
                          'assets/soundClips/Meditation_1_5_min_meditation.m4a'));
                    },
                  ),
                  SizedBox(height: 16),
                  _buildAudioPlayer(
                    title: 'Compassion Pause Lydklip 2',
                    onPressed: () {
                      _playAudio(AssetSource(
                          'assets/soundClips/Oevelse_1_Angst_og_svaere_feolelser.m4a'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioPlayer(
      {required String title, required VoidCallback onPressed}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Icon(Icons.play_circle_fill, color: Colors.teal, size: 40),
        title: Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text('Afspil'),
        ),
      ),
    );
  }

  Widget _buildVideoPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Se denne video om håndtere stress og mental sundhed',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.teal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildInteractiveExercisePage() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Text(
  //           'Interaktive Øvelser',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Expanded(
  //         child: Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Prøv disse øvelser for at forbedre din medfølelse.',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 SizedBox(height: 16),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     // Add interactive exercise logic here
  //                   },
  //                   child: Text('Start Øvelse'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildReflectionPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Refleksion',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tag et øjeblik til at reflektere over, hvad du har lært i dette kursus. Skriv dine tanker og følelser ned.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dine tanker',
                    ),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalResourcesPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Yderligere Ressourcer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Her er nogle yderligere ressourcer, der kan hjælpe dig med at fortsætte din rejse med medfølelse.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.teal),
                    title:
                        Text('Bog: "The Compassionate Mind" af Paul Gilbert'),
                  ),
                  ListTile(
                    leading: Icon(Icons.web, color: Colors.teal),
                    title: Text('Webside: www.compassionatemind.co.uk'),
                  ),
                  ListTile(
                    leading: Icon(Icons.video_library, color: Colors.teal),
                    title: Text('Video: "The Power of Compassion" på YouTube'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConclusionPage() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Tillykke!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Du har gennemført Medfølelsesrejsen. Vi håber, at du fandt det værdifuldt og berigende.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.teal,
            tooltip: 'Tilbage',
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
