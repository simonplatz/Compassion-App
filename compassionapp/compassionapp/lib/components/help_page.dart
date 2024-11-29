import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Resources at SDU'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Important Links at SDU'),
          _buildLinkCard('Psychology Pages', Uri.parse('https://example.com/psychology')),
          _buildLinkCard('Contact a Psychology Professional', Uri.parse('https://example.com/contact-psychology')),
          _buildSectionTitle('Faglig Vejledning'),
          _buildLinkCard('Generelle Vejledning på SDU', Uri.parse('https://example.com/general-guidance')),
          _buildLinkCard('TEK - Uddannelseskoordinatorer', Uri.parse('https://example.com/tek-guidance')),
          _buildLinkCard('HUM - Studievejledning', Uri.parse('https://example.com/hum-guidance')),
          _buildLinkCard('NAT - Studievejledning', Uri.parse('https://example.com/nat-guidance')),
          _buildLinkCard('SAMF - Faglige Vejledere', Uri.parse('https://example.com/samf-guidance')),
          _buildLinkCard('SUND - Faglige Vejledere', Uri.parse('https://example.com/sund-guidance')),
          _buildSectionTitle('Additional Resources'),
          _buildLinkCard('SPS-kontoret', Uri.parse('https://example.com/sps')),
          _buildLinkCard('Studievalg Danmark', Uri.parse('https://example.com/studievalg')),
          _buildLinkCard('Studielivet Podcast', Uri.parse('https://example.com/studielivet-podcast')),
          _buildLinkCard('Karriereland Podcast', Uri.parse('https://example.com/karriereland-podcast')),
          _buildLinkCard('Trusler og Vold', Uri.parse('https://example.com/trusler-vold')),
          _buildLinkCard('Psykologisk Rådgivning for Medarbejdere', Uri.parse('https://example.com/psychological-counseling')),
          _buildLinkCard('Ventilen Odense', Uri.parse('https://example.com/ventilen-odense')),
          _buildLinkCard('Livslinien', Uri.parse('https://example.com/livslinien')),
          _buildLinkCard('Ungeilbuds Netværket', Uri.parse('https://example.com/ungeilbuds-netvaerket')),
          _buildLinkCard('Psykologteamet v. Odense Kommune', Uri.parse('https://example.com/psychologist-odense')),
          _buildLinkCard('Odense Socialkompas', Uri.parse('https://example.com/socialkompas')),
          _buildLinkCard('AktivOdense', Uri.parse('https://example.com/aktivodense')),
          _buildLinkCard('Studenterforeninger på SDU Odense', Uri.parse('https://example.com/student-associations')),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLinkCard(String title, Uri url) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () async {
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}