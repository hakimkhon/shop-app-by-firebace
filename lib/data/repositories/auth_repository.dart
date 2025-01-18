import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/models/user_model.dart';
import 'package:shop/data/utils/extension/extensions.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> loginAdmin({
    required String phoneNumber,
    required String password,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      var result = await _firebaseFirestore
          .collection(FixedNames.admins)
          .where(FixedNames.phoneNumber, isEqualTo: phoneNumber)
          .where(FixedNames.password, isEqualTo: password)
          .get();
      List<UserModel> userModels =
          result.docs.map((value) => UserModel.fromJson(value.data())).toList();

      if (userModels.isNotEmpty) {
        StorageRepository.setString(
            key: FixedNames.adminId, value: userModels.first.docId);
        networkResponse.data = userModels.first;
      } else {
        networkResponse.errorText = "Bunday admin mavjud emas";
        log("Bunday admin mavjud emas");
      }
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Nomalum xatolik catch $e");

      networkResponse.errorText = "Nomalum xatolik catch $e";
    }
    return networkResponse;
  }
}
