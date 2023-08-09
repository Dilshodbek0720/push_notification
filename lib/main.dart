import 'package:chat_app/services/local_notification_service.dart';
import 'package:chat_app/ui/news/news_screen.dart';
import 'package:chat_app/ui/news/widgets/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.instance.setupFlutterNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsScreen(),
      theme: ThemeData.dark(),
    );
  }
}