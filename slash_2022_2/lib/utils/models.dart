class Product {
  final String title;
  final String category;
  final String nutriscore;
  final String? imageurl;
  final int carbonscore;

  const Product({
    required this.title,
    required this.category,
    required this.nutriscore,
    required this.imageurl,
    required this.carbonscore,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      category: json['category'],
      nutriscore: json['nutri_score'],
      imageurl: json['image_url'],
      carbonscore:json['carbon_score'] as int,

    );
  }
}
