class Comment {
  final int id;
  final String title;
  final String description;

  Comment({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['ID'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'title': title,
      'description': description,
    };
  }
}
