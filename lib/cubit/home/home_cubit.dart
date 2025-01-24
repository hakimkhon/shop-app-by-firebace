import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/home/home_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/repositories/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeState.initial());

  final HomeRepository _homeRepository;
  late StreamSubscription<List<ProductModel>> productsListen;

  Future<void> getCategories() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _homeRepository.getCategories();

     if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(categories: networkResponse.data));
      listenProducts();
    } else {
      setStateToError(networkResponse.errorText);
    }
  }

    Future<void> listenProducts([String categoryId = ""]) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    productsListen = _homeRepository.getProduct(categoryId: categoryId).listen(
      (response) {
        if (!isClosed) {
          emit(
            state.copyWith(
              formsStatus: FormsStatus.success,
              products: response,
            ),
          );
        }
      },
      onError: (error) {
        setStateToError(error.toString());
      },
    );
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
