class MoodManager {
  static final List<Map<String, String>> moods = [
    {'label': 'Very Bad', 'emoji': '😢'},
    {'label': 'Bad', 'emoji': '😟'},
    {'label': 'Neutral', 'emoji': '😐'},
    {'label': 'Good', 'emoji': '😊'},
    {'label': 'Very Good', 'emoji': '😁'},
  ];

  static String getMoodEmoji(String label) {
    return moods.firstWhere((mood) => mood['label'] == label)['emoji']!;
  }
}