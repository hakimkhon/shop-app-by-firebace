import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/home/home_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/repositories/home_repository.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeState.initial());

  final HomeRepository _homeRepository;

  Future<void> setCategoty({required String categoryId}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
        await _homeRepository.getProductsForCategoryId(productId: categoryId);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(categories: networkResponse.data));
      getProducts();
    } else {
      if (networkResponse.errorText == FixedNames.notFound) {
        emit(state.copyWith(formsStatus: FormsStatus.unAuthenticated));
      } else {
        setStateToError(networkResponse.errorText);
      }
    }
  }

  Future<void> getCategories() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _homeRepository.getCategories();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(categories: networkResponse.data));
      getProducts();
    } else {
      if (networkResponse.errorText == FixedNames.notFound) {
        emit(state.copyWith(formsStatus: FormsStatus.unAuthenticated));
      } else {
        setStateToError(networkResponse.errorText);
      }
    }
  }

  Future<void> getProducts() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _homeRepository.getProducts();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          products: networkResponse.data,
        ),
      );
    } else {
      if (networkResponse.errorText == FixedNames.notFound) {
        emit(state.copyWith(formsStatus: FormsStatus.unAuthenticated));
      } else {
        setStateToError(networkResponse.errorText);
      }
    }
  }

  void setStateToError(String errorText) {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.error,
        errorText: errorText,
      ),
    );
  }
}
