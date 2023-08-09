import 'package:chat_app/data/chat/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../service/chat_service.dart';
import '../universal_data.dart';

class ChatProvider with ChangeNotifier {
  ChatProvider({required this.chatService});

  final ChatService chatService;

  final TextEditingController massage = TextEditingController();


  Future<void> addProduct({
    required BuildContext context,
    required ChatModel chatModel,
  }) async {

    UniversalData universalData =
    await chatService.addProduct(chatModel: chatModel);
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        debugPrint("Xabar yuborildi");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
    massage.clear();
  }

  // Future<void> updateProduct({
  //   required BuildContext context,
  //   required ProductModel productModel,
  // }) async {
  //   showLoading(context: context);
  //   UniversalData universalData =
  //   await productService.updateProduct(productModel: productModel);
  //   if (context.mounted) {
  //     hideLoading(dialogContext: context);
  //   }
  //   if (universalData.error.isEmpty) {
  //     if (context.mounted) {
  //       showMessage(context, universalData.data as String);
  //     }
  //   } else {
  //     if (context.mounted) {
  //       showMessage(context, universalData.error);
  //     }
  //   }
  //
  //   productName.clear();
  //   description.clear();
  //   count.clear();
  //   price.clear();
  //   currency.clear();
  //
  // }
  //
  // Future<void> deleteProduct({
  //   required BuildContext context,
  //   required String productId,
  // }) async {
  //
  //   showLoading(context: context);
  //
  //   UniversalData universalData =
  //   await productService.deleteProduct(productId: productId);
  //   if (context.mounted) {
  //     hideLoading(dialogContext: context);
  //   }
  //   if (universalData.error.isEmpty) {
  //     if (context.mounted) {
  //       showMessage(context, universalData.data as String);
  //     }
  //   } else {
  //     if (context.mounted) {
  //       showMessage(context, universalData.error);
  //     }
  //   }
  // }
  //
  Stream<List<ChatModel>> getProducts() =>
      FirebaseFirestore.instance.collection("chats").orderBy("createdAt", descending: false).snapshots().map(
            (event1) => event1.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList(),
      );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}