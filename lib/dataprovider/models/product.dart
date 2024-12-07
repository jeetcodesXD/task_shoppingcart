class Product {
  final int id;
  final String? title;
  final String? brand;
  final double price;
  final double discountPercentage;
  final String? thumbnail;
  final int? quantity;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    this.quantity = 0,
  });
  Product copyWith({
    int? quantity,
  }) {
    return Product(
      id: id,
      title: title,
      brand: brand,
      discountPercentage: discountPercentage,
      price: price,
      thumbnail: thumbnail,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'thumbnail': thumbnail,
      'price': price,
      'discountedPrice': discountedPrice,
      'quantity': quantity,
      'discountPercentage': discountPercentage,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      quantity: json['quantity'],
      thumbnail: json['thumbnail'],
    );
  }
  double get discountedPrice {
    return price * (1 - discountPercentage / 100);
  }
}
