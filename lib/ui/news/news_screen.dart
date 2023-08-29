import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/blocs/news/news_bloc.dart';
import 'package:chat_app/blocs/news/news_event.dart';
import 'package:chat_app/blocs/news/news_state.dart';
import 'package:chat_app/services/fcm/fcm.dart';
import 'package:chat_app/ui/news/add_screen/add_screen.dart';
import 'package:chat_app/ui/news/widgets/news_card.dart';
import 'package:chat_app/ui/news/widgets/news_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/news/model/status/from_status.dart';
import '../../utils/ui_utils/show_error_message.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    init();
    initFirebase(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  init(){
    BlocProvider.of<NewsBloc>(context).add(GetNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: [
          TextButton(onPressed: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const AddScreen();
            }));
            //FirebaseMessaging.instance.subscribeToTopic("flutter_news");
          }, child: const Text("Add")),
        ],
      ),
      body: BlocConsumer<NewsBloc, NewsAddState>(
        builder: (context, state){
          if(state.news.isNotEmpty) {
            return
            //   ListView(
            //   children: [
            //     ...List.generate(state.news.length, (index) => ListTile(title: Text(state.news[index].news_title),)
            //     )
            //   ],
            // );

              SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                        itemCount: state.news.length,
                        itemBuilder: (context, index, id) =>
                            NewsCard(modelSql: state.news[index],),
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                        )),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text(
                      "News",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    //now let's create the cards for the recent news
                    Column(
                        children: List.generate(state.news.length, (index) =>
                            NewsListTile(modelSql: state.news[index]))
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Center(child: Text("Empty"),);
          }
          },
        listener: (context, state){
          if(state.status == FormStatus.failure){
            showErrorMessage(message: state.statusText, context: context);
          }
        },
      )
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
        context.read<NewsBloc>().add(GetNews());
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }
}