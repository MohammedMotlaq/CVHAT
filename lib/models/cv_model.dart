class CV {
  final int? id;
  final String? content;
  final String fileName;
  final String? url;
  final String? coverImageUrlHigh;
  final String? coverImageUrlLow;
  final String? createdAt;

  CV({
    this.id,
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
      content: json['content'] ?? '',
      fileName: json['fileName'],
      url: json['url'],
      coverImageUrlHigh: json['coverImageUrlHigh'],
      coverImageUrlLow: json['coverImageUrlLow'],
      createdAt: json.containsKey('createdAt') ? json['createdAt'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'ID': id,
      if (content != null) 'content': content,
      'fileName': fileName,
      if (url != null) 'url': url,
      if (coverImageUrlHigh != null) 'coverImageUrlHigh': coverImageUrlHigh,
      if (coverImageUrlLow != null) 'coverImageUrlLow': coverImageUrlLow,
      if (createdAt != null) 'createdAt': createdAt!,
    };
  }
}
