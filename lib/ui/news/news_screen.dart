import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/data/news/model/model.dart';
import 'package:chat_app/services/fcm.dart';
import 'package:chat_app/services/repository.dart';
import 'package:chat_app/ui/news/add_screen.dart';
import 'package:chat_app/ui/news/widgets/news_card.dart';
import 'package:chat_app/ui/news/widgets/news_list_tile.dart';
import 'package:chat_app/ui/news/widgets/news_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with WidgetsBindingObserver {
  bool isSubscribe = true;

  @override
  void initState() {
    initFirebase(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: [
          TextButton(onPressed: () {
            setState(() {
              isSubscribe = isSubscribe ? false : true;
            });
            isSubscribe ? FirebaseMessaging.instance.subscribeToTopic("news") : FirebaseMessaging.instance.subscribeToTopic("flutter");
          }, child: Text(isSubscribe ? "ON": "OFF")),
          TextButton(onPressed: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AddScreen();
            }));
            //FirebaseMessaging.instance.subscribeToTopic("flutter_news");
          }, child: Text("Add")),
        ],
      ),
      body: context.watch<NewsProvider>().news.isEmpty
          ? const Center(child: Text("EMPTY!!!"))
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  itemCount: context.watch<NewsProvider>().news.length,
                  itemBuilder: (context, index, id) =>
                      NewsCard(modelSql: context.watch<NewsProvider>().news[index],),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                  )),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "News",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              //now let's create the cards for the recent news
              Column(
                children: List.generate(context.watch<NewsProvider>().news.length, (index) => NewsListTile(modelSql: context.watch<NewsProvider>().news[index]))
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        context.read<NewsProvider>().readNews();
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
    }
  }
}