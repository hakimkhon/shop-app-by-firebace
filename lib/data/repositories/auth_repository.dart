import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/utils/extension/app_extension.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<NetworkResponse> registerUserByEmail({
    required String email,
    required String password,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {}
    } on FirebaseAuthException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Nomalum xatolik";
    }
    return networkResponse;
  }

  //  Future<NetworkResponse> saveUser(String email) async {
  //   NetworkResponse networkResponse = NetworkResponse();
  //   UserModel userModel = UserModel.initial();

  //   try {
  //     var result = await _firebaseFirestore
  //         .collection("users")
  //         .add(userModel.copyWith(email: email).toJson());

  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(result.id)
  //         .update({"doc_id": result.id});
  //   } on FirebaseException catch (e) {
  //     networkResponse.errorText = e.friendlyMessage;
  //   } catch (e) {
  //     networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
  //   }

  //   return networkResponse;
  // }
}
