import 'dart:io';
import 'package:chat_app/data/news/model/model.dart';
import 'package:chat_app/data/news/universal_data.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NewsRepository {
  Future<UniversalData> postModel({required NewsModelSql newsModel}) async {
    var dio = Dio();
    String? token = await FirebaseMessaging.instance.getToken();
    print("Token :: $token");
    try {
      Response response =
      await dio.post("https://fcm.googleapis.com/fcm/send",
          options: Options(headers: {
            "Authorization":"key=AAAAcUePMOE:APA91bHUay7JQxkwELDwJgj2DspDEaPNodoVQLkWo3QnHOYXa6pJQyRetTIFhAjAGHMPnBIHOhfC7DeKe3i9rxSsFCwhgt8IrjeZrfFFjNwvwtY0PJrJ5B2wYEdORh00_G1RZXcKo2J_"
          }),
          data: {
        "to": "$token",
        "notification":{
          "title":"Daryo uzz",
          "body":"Yangi xabarlar"
        },
        "data": newsModel.toJson()
      });
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        print(response.data);
        return UniversalData(data: response.data);
      }
     return UniversalData(error: "Other Error");
    } catch (error) {
      print("Error: $error");
      return UniversalData(error: error.toString());
    }
  }
}

class MyCustomFieldsError implements Exception{
  final String errorText;
  MyCustomFieldsError({required this.errorText});
}