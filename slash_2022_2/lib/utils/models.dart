class Product {
  final String? title;
  final String? category;
  final String? nutri_score;
  final int carbon_score;

  const Product({
    required this.title,
    required this.category,
    required this.nutri_score,
    required this.carbon_score,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      category: json['category'],
      nutri_score: json['nutri_score'],
      carbon_score:json['carbon_score'] as int,
    );
  }
}

