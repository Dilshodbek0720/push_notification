import 'package:chat_app/blocs/news/news_bloc.dart';
import 'package:chat_app/blocs/news/news_event.dart';
import 'package:chat_app/services/notification/local_notification_service.dart';
import 'package:chat_app/services/repository/repository.dart';
import 'package:chat_app/ui/news/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.instance.setupFlutterNotifications();

  runApp(
    const App()
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NewsRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NewsBloc(newsRepository: context.read<NewsRepository>()))
        ],
        child: const MyApp(),
      ),
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(GetNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NewsScreen(),
      theme: ThemeData.dark(),
    );
  }
}