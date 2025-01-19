import 'package:shop/ui/core/constant/fixed_names.dart';

class ProductModel {
  final String productId;
  final String imageUrl;
  final String title;
  final String description;
  final String categoryId;
  final String price;
  final String adminId;

  ProductModel({
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.adminId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json[FixedNames.productId] as String? ?? "",
      imageUrl: json[FixedNames.imageUrl] as String? ?? "",
      title: json[FixedNames.title] as String? ?? "",
      description: json[FixedNames.description] as String? ?? "",
      categoryId: json[FixedNames.categoryId] as String? ?? "",
      price: json[FixedNames.price] as String? ?? "",
      adminId: json[FixedNames.adminId] as String? ?? "",
    );
  }

  ProductModel copyWith({
    String? productId,
    String? imageUrl,
    String? title,
    String? description,
    String? categoryId,
    String? price,
    String? adminId,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      adminId: adminId ?? this.adminId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FixedNames.productId: productId,
      FixedNames.categoryId: categoryId,
      FixedNames.imageUrl: imageUrl,
      FixedNames.title: title,
      FixedNames.description: description,
      FixedNames.price: price,
      FixedNames.adminId: adminId,
    };
  }
}
