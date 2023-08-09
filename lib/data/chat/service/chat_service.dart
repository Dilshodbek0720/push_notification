import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat_model.dart';
import '../universal_data.dart';

class ChatService {
  Future<UniversalData> addProduct({required ChatModel chatModel}) async {
    try {
      DocumentReference newProduct = await FirebaseFirestore.instance
          .collection("chats")
          .add(chatModel.toJson());

      await FirebaseFirestore.instance
          .collection("chats")
          .doc(newProduct.id)
          .update({
        "productId": newProduct.id,
      });

      return UniversalData(data: "Chat added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  // Future<UniversalData> updateProduct(
  //     {required ProductModel productModel}) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("products")
  //         .doc(productModel.productId)
  //         .update(productModel.toJson());
  //
  //     return UniversalData(data: "Product updated!");
  //   } on FirebaseException catch (e) {
  //     return UniversalData(error: e.code);
  //   } catch (error) {
  //     return UniversalData(error: error.toString());
  //   }
  // }
  //
  // Future<UniversalData> deleteProduct({required String productId}) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("products")
  //         .doc(productId)
  //         .delete();
  //
  //     return UniversalData(data: "Product deleted!");
  //   } on FirebaseException catch (e) {
  //     return UniversalData(error: e.code);
  //   } catch (error) {
  //     return UniversalData(error: error.toString());
  //   }
  // }
}