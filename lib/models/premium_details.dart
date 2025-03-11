class PremiumDetails {
  final String title;
  final String offer;
  final bool isBest;

  PremiumDetails(
      {required this.title, required this.offer, required this.isBest});

  factory PremiumDetails.fromJson(Map<String, dynamic> json) {
    return PremiumDetails(
        title: json['title'], offer: json['offer'], isBest: json['is_best']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'offer': offer, 'is_best': isBest};
  }
}
