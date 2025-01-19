import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/product_model.dart';

class HomeState {
  final String errorText;
  final String statusMessage;
  final FormsStatus formsStatus;
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  HomeState({
    required this.errorText,
    required this.statusMessage,
    required this.formsStatus,
    required this.categories,
    required this.products,
  });

  HomeState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formsStatus,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
  }) {
    return HomeState(
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? "",
      errorText: errorText ?? this.errorText,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  factory HomeState.initial() {
    return HomeState(
      formsStatus: FormsStatus.pure,
      statusMessage: "",
      errorText: "",
      categories: [],
      products: [],
    );
  }
}
