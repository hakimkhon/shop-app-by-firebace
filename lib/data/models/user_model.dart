import 'package:shop/ui/core/constant/fixed_names.dart';

class UserModel {
  final String docId;
  final String phoneNumber;
  final String password;

  UserModel({
    required this.docId,
    required this.password,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json[FixedNames.password] as String? ?? "",
      docId: json[FixedNames.docID] as String? ?? "",
      phoneNumber: json[FixedNames.phoneNumber] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FixedNames.password: password,
      FixedNames.docID: docId,
      FixedNames.phoneNumber: phoneNumber,
    };
  }

  factory UserModel.initial() {
    return UserModel(
      password: "",
      docId: "",
      phoneNumber: "",
    );
  }

  UserModel copyWith({
    String? docId,
    String? phoneNumber,
    String? password,
  }) {
    return UserModel(
      password: password ?? this.password,
      docId: docId ?? this.docId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
