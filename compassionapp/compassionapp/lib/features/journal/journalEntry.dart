class JournalEntry {
  final int? id;
  final String content;
  final DateTime date;
  final String mood;

  JournalEntry({
    this.id,
    required this.content,
    required this.date,
    required this.mood,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'date': date.toIso8601String(),
      'mood': mood,
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      mood: map['mood'],
    );
  }
}