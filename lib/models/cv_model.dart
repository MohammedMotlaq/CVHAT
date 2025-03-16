class CV {
  final int? id;
  final String title;
  final String? content;
  final String fileName;
  final String? url;
  final String? coverImageUrlHigh;
  final String? coverImageUrlLow;
  final DateTime? createdAt;

  CV({
    this.id,
    required this.title,
    this.content,
    required this.fileName,
    this.url,
    this.coverImageUrlHigh,
    this.coverImageUrlLow,
    this.createdAt,
  });

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      id: json.containsKey('ID') ? json['ID'] : null,
      title: json['title'],
      content: json['content'] ?? '',
      fileName: json['fileName'],
      url: json['url'],
      coverImageUrlHigh: json['coverImageUrlHigh'],
      coverImageUrlLow: json['coverImageUrlLow'],
      createdAt: json.containsKey('createdAt')
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'ID': id,
      'title': title,
      if (content != null) 'content': content,
      'fileName': fileName,
      if (url != null) 'url': url,
      if (coverImageUrlHigh != null) 'coverImageUrlHigh': coverImageUrlHigh,
      if (coverImageUrlLow != null) 'coverImageUrlLow': coverImageUrlLow,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }
}
