import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/utils/extension/app_extension.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      if (userCredential.user != null) {
        StorageRepository.setString(
          key: FixedNames.userEmail,
          value: email,
        );
        return await saveUser(email);
      }
    } on FirebaseAuthException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Nomalum xatolik catch $e";
    }
    return networkResponse;
  }

  Future<NetworkResponse> loginUserByEmail({
    required String email,
    required String password,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        StorageRepository.setString(
          key: FixedNames.userEmail,
          value: email,
        );
      }
    } on FirebaseAuthException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Nomalum xatolik";
    }
    return networkResponse;
  }

  Future<NetworkResponse> saveUser(String email) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await _firebaseFirestore
          .collection(FixedNames.users)
          .add({FixedNames.userEmail: email});

      await _firebaseFirestore
          .collection(FixedNames.users)
          .doc(result.id)
          .update({FixedNames.docID: result.id});
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}
