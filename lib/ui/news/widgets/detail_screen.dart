import 'package:chat_app/data/news/model/model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.modelSql}) : super(key: key);
  final NewsModelSql modelSql;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.modelSql.news_title!,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.modelSql.author!,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: "${widget.modelSql.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(widget.modelSql.news_image!),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(widget.modelSql.news_description!)
          ],
        ),
      ),
    );
  }
}