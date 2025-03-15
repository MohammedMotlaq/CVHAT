import 'package:intl/intl.dart';

class Review {
  final int id;
  final bool isAI;
  final DateTime createdAt;
  final CV cv;

  Review({
    required this.id,
    required this.isAI,
    required this.createdAt,
    required this.cv,
  });

  // Factory constructor to create a Review instance from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['ID'],
      isAI: json['isAI'],
      createdAt: DateTime.parse(json['createdAt']),
      cv: CV.fromJson(json['CV']),
    );
  }

  // Converts Review object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'isAI': isAI,
      'createdAt': createdAt.toIso8601String(),
      'CV': cv.toJson(),
    };
  }

  String get formattedDate {
    return DateFormat("dd MMM yyyy").format(createdAt);
  }
}

class CV {
  final String title;
  final String coverImageUrlLow;
  final String fileName;

  CV({
    required this.title,
    required this.coverImageUrlLow,
    required this.fileName,
  });

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      title: json['title'],
      coverImageUrlLow: json['coverImageUrlLow'],
      fileName: json['fileName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'coverImageUrlLow': coverImageUrlLow,
      'fileName': fileName,
    };
  }
}
