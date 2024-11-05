import 'package:flutter/material.dart';

class CourseContent extends StatelessWidget {
  final String courseName;

  const CourseContent({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return _getCourseContent(courseName);
  }

  Widget _getCourseContent(String courseName) {
    switch (courseName) {
      case 'Mindfulness':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/mindfulness.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Mindfulness is the practice of being present in the moment. It helps reduce stress and improve mental clarity.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercises:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Breathing exercises\n2. Body scan meditation\n3. Mindful walking',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Self-Compassion':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/self_compassion.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Self-compassion involves treating yourself with kindness and understanding during difficult times.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercises:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Self-kindness meditation\n2. Loving-kindness meditation\n3. Journaling about self-compassion',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Stress Relief':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/stress_relief.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Stress relief techniques help you manage and reduce stress effectively.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercises:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Progressive muscle relaxation\n2. Deep breathing exercises\n3. Visualization techniques',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Compassion-Focused Therapy':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/compassion_focused_therapy.webp'),
            const SizedBox(height: 20),
            const Text(
              'Hvad er compassion-fokuseret terapi?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Compassion-fokuseret terapi (CFT) er en terapiform, der primært retter sig mod mennesker med lavt selvværd, svære følelser, skam eller vedvarende selvkritik.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Terapien kombinerer teknikker fra kognitiv adfærdsterapi, mindfulness og buddhistisk medfølelsestræning.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'CFT anvendes ofte til personer med symptomer på depression, angst og stress og kan give værktøjer til at bryde den onde cirkel af skam og selvkritik, der ofte forstærker de psykiske problemer.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hvad kan du opnå?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Målet med CFT er at hjælpe mennesker med at udvikle en venligere, mere medfølende indstilling til sig selv og andre.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ved at møde sig selv med mere omsorg, kan man reducere selvkritik og negative selvvurderinger og dermed lindre den psykiske smerte.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hvad kommer du til at arbejde med?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Selvmedfølelse: CFT arbejder med at øge din evne til selvomsorg og selvmedfølelse. Dette involverer at være mere tålmodig, venlig og accepterende over for dig selv, især i vanskelige tider.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Forståelse af følelser: CFT fokuserer på at udvikle en forståelse af de emotionelle systemer, som styrer vores følelser. Ifølge CFT er vores hjerner biologisk indrettet med forskellige systemer til trussel, drivkraft og ro. Mange oplever, at trusselsystemet ofte aktiveres ved selvkritik, mens ro- og medfølelsessystemerne er underudviklede. Terapien arbejder derfor på at styrke ro- og medfølelsessystemerne.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mindfulness og visualisering: Mange CFT-teknikker inkluderer mindfulness og visualisering, hvor du træner evnen til at være til stede i nuet og på at visualisere en medfølende figur (f.eks. en person eller en del af dig selv), som kan give støtte og opmuntring.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Accept af sårbarhed: Et centralt aspekt er at acceptere din menneskelighed og de fejl, man kan begå, som en naturlig del af livet. Det kan hjælpe dig med at udvikle en større tolerance for egne fejl og sårbarheder.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      default:
        return const Text(
          'Course content not available.',
          style: TextStyle(fontSize: 16),
        );
    }
  }
}