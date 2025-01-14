import 'package:shop/data/enums/forms_status.dart';

class AuthState {
  final String errorText;
  final String statusMessage;
  final FormsStatus formsStatus;

  AuthState({
    required this.errorText,
    required this.statusMessage,
    required this.formsStatus,
  });

  AuthState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formsStatus
  }) {
    return AuthState(
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? "",
      errorText: errorText ?? this.errorText,
    );
  }

  factory AuthState.initial() {
    return AuthState(
      formsStatus: FormsStatus.pure,
      errorText: "",
      statusMessage: "",
    );
  }
}
