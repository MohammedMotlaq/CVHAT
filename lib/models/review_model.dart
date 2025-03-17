import 'package:cvhat/models/comment_model.dart';
import 'package:cvhat/models/cv_model.dart';
import 'package:cvhat/utils/date_fotmating.dart';

class Review {
  final int id;
  final bool isAI;
  final String? title;

  final bool isFavorite;
  final String createdAt;
  final List<Comment>? comments;
  final CV cv;
  final dynamic recruiter;

  Review({
    required this.id,
    required this.isAI,
    this.title,
    required this.isFavorite,
    required this.createdAt,
    this.comments,
    required this.cv,
    this.recruiter,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['ID'],
      isAI: json['isAI'],
      isFavorite: json['isFavorite'],
      title: json['title'],
      createdAt: json['createdAt'],
      comments: json.containsKey('Comments')
          ? (json['Comments'] as List).map((c) => Comment.fromJson(c)).toList()
          : null,
      cv: CV.fromJson(json['CV']),
      recruiter: json.containsKey('Recruiter') ? json['Recruiter'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'isAI': isAI,
      'isFavorite': isFavorite,
      'createdAt': createdAt,
      if (title != null) 'title': title,
      if (comments != null)
        'Comments': comments!.map((c) => c.toJson()).toList(),
      'CV': cv.toJson(),
      if (recruiter != null) 'Recruiter': recruiter,
    };
  }
}
