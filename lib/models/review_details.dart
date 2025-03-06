class Comment {
  final String title;
  final String comment;

  Comment({required this.title, required this.comment});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      title: json['title'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'comment': comment,
    };
  }
}

class ReviewDetails {
  final String id;
  final String title;
  final String fileName;
  final String uploadDate;
  final String type;
  final List<Comment> comments;

  ReviewDetails({
    required this.id,
    required this.title,
    required this.fileName,
    required this.uploadDate,
    required this.type,
    required this.comments,
  });

  factory ReviewDetails.fromJson(Map<String, dynamic> json) {
    return ReviewDetails(
      id: json['id'],
      title: json['title'],
      fileName: json['fileName'],
      uploadDate: json['uploadDate'],
      type: json['type'],
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fileName': fileName,
      'uploadDate': uploadDate,
      'type': type,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}
