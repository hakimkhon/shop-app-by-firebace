import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/network_response.dart';
import 'package:shop/data/utils/extension/extensions.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class CategoryRepository {
  // Firebase Firestore'ning nusxasini olish
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // 1. Kategoriya qo'shish funksiyasi
  Future<NetworkResponse> addCategory({
    required CategoryModel categoryModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse(); // Javob obyekti

    try {
      // Kategoriya ma'lumotlarini Firestore'ga qo'shish
      var result = await _firebaseFirestore
          .collection(FixedNames.categories) // "categories" kolleksiyasiga murojaat
          .add(categoryModel.toJson()); // Ma'lumotlarni JSON formatida qo'shish

      // Yaratilgan kategoriya hujjatiga ID o'rnatish
      await _firebaseFirestore
          .collection(FixedNames.categories)
          .doc(result.id)
          .update({FixedNames.categoryId: result.id}); // IDni yangilash
    } on FirebaseException catch (e) {
      // Firebase bilan bog'liq xatolikni ushlash
      log(e.friendlyMessage); // Xatolik logiga yozish
      networkResponse.errorText = e.friendlyMessage; // Xatolikni javobga qaytarish
    } catch (e) {
      // Har qanday boshqa xatolikni ushlash
      log("Noma'lum xatolik: catch (e) ");
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse; // Javobni qaytarish
  }

  // 2. Kategoriyani yangilash funksiyasi
  Future<NetworkResponse> updateCategory({
    required CategoryModel categoryModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      // Kategoriyani yangilash
      await _firebaseFirestore
          .collection(FixedNames.categories) // "categories" kolleksiyasiga murojaat
          .doc(categoryModel.categoryId) // Tegishli kategoriya hujjatiga murojaat
          .update(categoryModel.toJson()); // Ma'lumotlarni yangilash
    } on FirebaseException catch (e) {
      // Firebase bilan bog'liq xatolikni ushlash
      log(e.friendlyMessage);
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      // Har qanday boshqa xatolikni ushlash
      log("Noma'lum xatolik: catch (e) ");
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse; // Javobni qaytarish
  }

  // 3. Kategoriyani o'chirish funksiyasi
  Future<NetworkResponse> deleteCategory({
    required CategoryModel categoryModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      // Kategoriyani o'chirish
      await _firebaseFirestore
          .collection(FixedNames.categories) // "categories" kolleksiyasiga murojaat
          .doc(categoryModel.categoryId) // Tegishli kategoriya hujjatini aniqlash
          .delete(); // Hujjatni o'chirish
    } on FirebaseException catch (e) {
      // Firebase bilan bog'liq xatolikni ushlash
      log(e.friendlyMessage);
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      // Har qanday boshqa xatolikni ushlash
      log("Noma'lum xatolik: catch (e) ");
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse; // Javobni qaytarish
  }
}
