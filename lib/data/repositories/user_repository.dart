import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/models/user_model.dart';
import 'package:shop/data/utils/extension/app_extension.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getUser() async {
    NetworkResponse networkResponse = NetworkResponse();
    String userEmail = StorageRepository.getString(key: FixedNames.userEmail);

    try {
      var result = await _firebaseFirestore
          .collection(FixedNames.users)
          .where(FixedNames.userEmail, isEqualTo: userEmail)
          .get();

      List<UserModel> userModels =
          result.docs.map((value) => UserModel.fromJson(value.data())).toList();

      if (userModels.isNotEmpty) {
        networkResponse.data = userModels.first;
      } else {
        networkResponse.errorText = "not_found";
      }
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}