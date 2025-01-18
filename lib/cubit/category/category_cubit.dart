
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/category/category_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/repositories/category_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._categoryRepository) : super(CategoryState.initial());

  final CategoryRepository _categoryRepository;

  Future<void> addCategory({required CategoryModel categoryModel}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
        await _categoryRepository.addCategory(categoryModel: categoryModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.success));
    } else {
      setStateError(networkResponse.errorText);
    }
  }

  Future<void> updateCategory({required CategoryModel categoryModel}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
        await _categoryRepository.updateCategory(categoryModel: categoryModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.success));
    } else {
      setStateError(networkResponse.errorText);
    }
  }

  void setStateError(String error) {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.error,
        errorText: error,
      ),
    );
  }
}
