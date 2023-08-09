import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyRepository {
  Future<bool> postModel() async {
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
        "to": "f5oS7KZCRhaobiQejYmbD9:APA91bHaTvxZd_IqPb_YdX3PT31F1c0Q7kt2lXOmwVBCljerQgdAcvLqan9quhSOGkJKdAnI1fzySCcB0hLKn26vFcK3iU3W7fqemzG5-vKiisEmyL_cLd9zhjbNZoYcG-q-5Yvj77PW",
        "notification":{
          "title":"Daryo uzz",
          "body":"Yangi xabarlar"
        },
        "data": {
          "author":"Ozod Rustamov",
          "news_image":"https://daryo.uz/static/nigora/hujjat%204.jpg",
          "news_description":"Qonunga ko‘ra, Normativ-huquqiy hujjatlarning va loyihalarning korrupsiyaga qarshi ekspertizasini o‘tkazuvchi subyektlar quyidagilardan iborat:Korrupsiyaga qarshi kurashish agentligi; normativ-huquqiy hujjat;",
          "news_date":"9.08.2023 14:00",
          "news_title":"O‘zbekistonda fuqarolar normativ-huquqiy hujjatlarning korrupsiyaga qarshi ekspertizasini o‘tkazishda ishtirok etishi mumkin bo‘ldi"
        }
      });
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        print(response.data);
        return true;
      }
     return false;
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }
}

class MyCustomFieldsError implements Exception{
  final String errorText;
  MyCustomFieldsError({required this.errorText});
}