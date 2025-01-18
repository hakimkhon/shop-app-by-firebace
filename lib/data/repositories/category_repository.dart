import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/utils/extension/extensions.dart';

class CategoryRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> addCategory({
    required CategoryModel categoryModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await _firebaseFirestore
          .collection("categories")
          .add(categoryModel.toJson());

      await _firebaseFirestore
          .collection("categories")
          .doc(result.id)
          .update({"category_id": result.id});
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateCategory({
    required CategoryModel categoryModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryModel.categoryId)
          .update(categoryModel.toJson());
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}
