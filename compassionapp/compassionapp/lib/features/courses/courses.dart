class Course {
  final String title;
  final String description;
  final String imageUrl;
   final String id;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}