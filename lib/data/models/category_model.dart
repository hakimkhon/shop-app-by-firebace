import 'package:shop/ui/core/constant/fixed_names.dart';

class CategoryModel {
  final String imageUrl;
  final String title;
  final String categoryId;

  CategoryModel({
    required this.imageUrl,
    required this.title,
    required this.categoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      imageUrl: json[FixedNames.imageUrl] as String? ?? "",
      title: json[FixedNames.title] as String? ?? "",
      categoryId: json[FixedNames.categoryId] as String? ?? "",
    );
  }

  CategoryModel copyWith({
    String? imageUrl,
    String? title,
    String? categoryId,
  }) {
    return CategoryModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FixedNames.categoryId: categoryId,
      FixedNames.imageUrl: imageUrl,
      FixedNames.title: title,
    };
  }
}
