import 'package:compassionapp/styling_component/styling_comp.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Vigtige Links hos SDU'),
          _buildSDUHelpDropdown(),
          _buildSectionTitle('Ressourcer på SDU'),
          _buildSDUResourcesDropdown(),
          _buildSectionTitle('Psykologisk Hjælp i Odense'),
          _buildPsychologicalHelpDropdown(),
          _buildSectionTitle('Podcasts'),
          _buildPodcastsDropdown(),
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
      color: Colors.teal[100],
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

  Widget _buildSDUHelpDropdown() {
    return Card(
      color: Colors.teal[50],
      child: ExpansionTile(
        title: const Text('SDU Hjælpelinks'),
        children: [
          _buildLinkCard('Generelle Vejledning på SDU', Uri.parse('https://mitsdu.dk/da/mit_studie/bachelor/pdi_productdevelopmentinno_bachelor/vejledning-og-support/vejledning?')),
          _buildLinkCard('TEK - Uddannelseskoordinatorer', Uri.parse('https://sdunet.dk/da/enheder/tek/uddannelseskoordinatorer')),
          _buildLinkCard('HUM - Studievejledning', Uri.parse('https://mitsdu.dk/da/mit_studie/bachelor/hum/studievejledning')),
          _buildLinkCard('NAT - Studievejledning', Uri.parse('https://mitsdu.dk/da/mit_studie/bachelor/nat/studievejledning')),
          _buildLinkCard('SAMF - Faglige Vejledere', Uri.parse('https://mitsdu.dk/da/mit_studie/bachelor/samf/faglige_vejledere')),
          _buildLinkCard('SUND - Faglige Vejledere', Uri.parse('https://mitsdu.dk/da/mit_studie/bachelor/sund/faglige_vejledere')),
        ],
      ),
    );
  }

  Widget _buildSDUResourcesDropdown() {
    return Card(
      color: Colors.teal[50],
      child: ExpansionTile(
        title: const Text('SDU Ressourcer'),
        children: [
          _buildLinkCard('Psykologisk Rådgivning for Medarbejdere', Uri.parse('https://sdunet.dk/da/servicesider/hr/arbejdsmiljoe/hvordan_kan_vi_arbejde_med_arbejdsmiljoe/psykisk-arbejdsmiljoe/psykologisk-raadgivning?')),
          _buildLinkCard('Studievalg Danmark', Uri.parse('https://studievalg.dk/?')),
          _buildLinkCard('Trusler og Vold', Uri.parse('https://sdunet.dk/da/servicesider/beredskab-paa-sdu/trusler-vold?')),
          _buildLinkCard('Studenterforeninger på SDU Odense', Uri.parse('https://mitsdu.dk/da/mit_studie/kandidat/kultur_og_formidling/studieliv/odense/studenterforeninger?')),
        ],
      ),
    );
  }

  Widget _buildPsychologicalHelpDropdown() {
    return Card(
      color: Colors.teal[50],
      child: ExpansionTile(
        title: const Text('Psykologisk Hjælp'),
        children: [
          _buildLinkCard('Ventilen Odense', Uri.parse('https://example.com/ventilen-odense')),
          _buildLinkCard('Livslinien', Uri.parse('https://www.livslinien.dk/')),
          _buildLinkCard('Unge tilbuds Netværket', Uri.parse('https://www.odense.dk/pio/find-tilbud/ungetilbuds-netvaerket?')),
          _buildLinkCard('Psykologteamet v. Odense Kommune', Uri.parse('https://www.odense.dk/borger/familie-boern-og-unge/boern-og-unge-med-saerlige-behov/psykologtilbud-til-unge?')),
          _buildLinkCard('Odense Socialkompas', Uri.parse('https://odense.socialkompas.dk/?')),
          _buildLinkCard('AktivOdense', Uri.parse('https://aktivodense.dk/alle-foreninger?acnid=&afgid=&afid=&cid=1b441b9a-0e0f-424a-9fc2-3a46177cad0e&pcn=')),
        ],
      ),
    );
  }

  Widget _buildPodcastsDropdown() {
    return Card(
      color: Colors.teal[50],
      child: ExpansionTile(
        title: const Text('Podcasts'),
        children: [
          _buildLinkCard('Studielivet Podcast', Uri.parse('https://open.spotify.com/show/5xJrH0O5u4nBqn0xWIUVKY?')),
          _buildLinkCard('Karriereland Podcast', Uri.parse('https://mitsdu.dk/da/karriereland?')),
        ],
      ),
    );
  }
}