
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/user/user_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/repositories/user_repository.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(UserState.initial());

  final UserRepository _userRepository;

  Future<void> fetchUser() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _userRepository.getUser();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          userModel: networkResponse.data,
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