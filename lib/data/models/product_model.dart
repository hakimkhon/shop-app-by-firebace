import 'package:shop/ui/core/constant/fixed_names.dart';

class ProductModel {
  final String imageUrl;
  final String title;
  final String description;
  final String productId;
  final String price;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.productId,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imageUrl: json[FixedNames.imageUrl] as String? ?? "",
      title: json[FixedNames.title] as String? ?? "",
      description: json[FixedNames.description] as String? ?? "",
      productId: json[FixedNames.productId] as String? ?? "",
      price: json[FixedNames.price] as String? ?? "",
    );
  }

  ProductModel copyWith({
    String? imageUrl,
    String? title,
    String? description,
    String? productId,
    String? price,
  }) {
    return ProductModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      productId: productId ?? this.productId,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FixedNames.productId: productId,
      FixedNames.imageUrl: imageUrl,
      FixedNames.title: title,
      FixedNames.description: description,
      FixedNames.price: price,
    };
  }
}
