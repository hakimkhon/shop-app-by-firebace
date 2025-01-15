import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/auth/auth_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthRepository read) : super(AuthState.initial());

  final AuthRepository _authRepository = AuthRepository();
  
  Future<void> registerUserByEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _authRepository.registerUserByEmail(
      email: email,
      password: password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.authenticated));
    } else {
      setStateToError(networkResponse.errorText);
    }
  }
  
  Future<void> loginUserByEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _authRepository.loginUserByEmail(
      email: email,
      password: password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.authenticated));
    } else {
      setStateToError(networkResponse.errorText);
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
