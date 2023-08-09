import 'package:chat_app/data/news/model/model.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/news/local_database/local_database.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModelSql> news = [];

  NewsProvider() {
    readNews();
  }

  readNews() async {
    news = await LocalDatabase.getAllNews();
    debugPrint("NEWS READ: ${news.length}");
    notifyListeners();
  }

}