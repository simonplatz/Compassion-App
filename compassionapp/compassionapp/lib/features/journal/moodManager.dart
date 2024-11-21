class MoodManager {
  static final List<Map<String, String>> moods = [
    {'label': 'Meget Dårlig', 'emoji': '😢'},
    {'label': 'Dårlig', 'emoji': '😟'},
    {'label': 'Neutral', 'emoji': '😐'},
    {'label': 'God', 'emoji': '😊'},
    {'label': 'Meget God', 'emoji': '😁'},
  ];

  static String getMoodEmoji(String label) {
    return moods.firstWhere((mood) => mood['label'] == label)['emoji']!;
  }
}