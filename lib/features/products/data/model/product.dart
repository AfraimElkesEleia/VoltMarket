class Product {
  final int id;
  final int categoryId;
  final String title;
  final String? description;
  final String? brand;
  final double price;
  final double rating;
  final String? imgUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  final bool isInCart;

  Product({
    required this.id,
    required this.categoryId,
    required this.title,
    this.description,
    this.brand,
    required this.price,
    required this.rating,
    this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.isInCart = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      categoryId: json['category_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      imgUrl: json['img_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      // Note: isFavorite won't come from JSON initially
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'brand': brand,
      'price': price,
      'rating': rating,
      'img_url': imgUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      // Optionally include isFavorite if needed
    };
  }

  // Add copyWith method for immutable updates
  Product copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    String? brand,
    double? price,
    double? rating,
    String? imgUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
    bool? isInCart,
  }) {
    return Product(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
      isInCart: isInCart ?? this.isInCart,
    );
  }
}
