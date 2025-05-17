class Quote {
  final String id;
  final String author;
  final String text;
  final String category;
  final DateTime createdAt;

  Quote({
    required this.id,
    required this.author,
    required this.text,
    required this.category,
    required this.createdAt,
  });

  factory Quote.fromMap(String id, Map<String, dynamic> data) {
    return Quote(
      id: id,
      author: data['author'],
      text: data['text'],
      category: data['category'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'text': text,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
