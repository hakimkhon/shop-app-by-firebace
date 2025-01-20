import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/utils/extension/extensions.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> addProduct({
    required ProductModel productModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await _firebaseFirestore
          .collection(FixedNames.products)
          .add(productModel.toJson());

      await _firebaseFirestore
          .collection(FixedNames.products)
          .doc(result.id)
          .update({FixedNames.productId: result.id});
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch $e ");

      networkResponse.errorText = "Noma'lum xatolik: catch $e ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateProduct({
    required ProductModel productModel,
    required String productId,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = _firebaseFirestore
          .collection(FixedNames.products)
          .doc(productId);

      await _firebaseFirestore
          .collection(FixedNames.products)
          .doc(result.id) // Mahsulot IDsi kerak
          .update(productModel.toJson()); // Yangilanish ma'lumotlari
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch $e");

      networkResponse.errorText = "Noma'lum xatolik: catch $e";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateProductFromGit({
    required ProductModel productModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection("product")
          .doc(productModel.productId)
          .update(productModel.toJson());
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch $e ");

      networkResponse.errorText = "Noma'lum xatolik: catch $e ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> deleteProduct({
    required ProductModel productModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection(FixedNames.products)
          .doc(productModel.productId)
          .delete();
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
