import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/utils/extension/extensions.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';
import 'dart:developer';

class HomeRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getCategories() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result =
          await _firebaseFirestore.collection(FixedNames.categories).get();

      networkResponse.data = result.docs
          .map((value) => CategoryModel.fromJson(value.data()))
          .toList();
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Nomalum xatolik catch $e");

      networkResponse.errorText = "Nomalum xatolik catch $e";
    }

    return networkResponse;
  }

  Future<NetworkResponse> getProducts() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result =
          await _firebaseFirestore.collection(FixedNames.products).get();

      networkResponse.data = result.docs
          .map((value) => ProductModel.fromJson(value.data()))
          .toList();
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Nomalum xatolik catch $e");

      networkResponse.errorText = "Nomalum xatolik catch $e";
    }

    return networkResponse;
  }

  Future<NetworkResponse> getProductsForCategoryId(
      {required String productId}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await _firebaseFirestore
          .collection(FixedNames.products)
          .where(FixedNames.productId, isEqualTo: productId)
          .get();

      networkResponse.data = result.docs
          .map((value) => ProductModel.fromJson(value.data()))
          .toList();
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
