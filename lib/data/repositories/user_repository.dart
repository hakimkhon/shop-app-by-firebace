import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/models/user_model.dart';
import 'package:shop/data/utils/extension/extensions.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';
import 'dart:developer';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getUser() async {
    NetworkResponse networkResponse = NetworkResponse();
    String adminId = StorageRepository.getString(key: FixedNames.adminId);

    try {
      var result = await _firebaseFirestore
          .collection(FixedNames.admins)
          .doc(adminId)
          .get();

      if (result.data() != null) {
        networkResponse.data = UserModel.fromJson(result.data()!);
      } else {
        networkResponse.errorText = FixedNames.notFound;
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
