class Product {
  final int id;
  final String title;
  final String brand;
  final double price;
  final double discountPercentage;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}
