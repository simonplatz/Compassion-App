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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/compassion_focused_therapy.webp'),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
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
  }
}