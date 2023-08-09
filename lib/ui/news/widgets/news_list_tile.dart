import 'package:chat_app/data/news/model/model.dart';
import 'package:chat_app/ui/news/widgets/detail_screen.dart';
import 'package:flutter/material.dart';

class NewsListTile extends StatefulWidget {
  NewsListTile({Key? key, required this.modelSql}) : super(key: key);
  final NewsModelSql modelSql;
  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return DetailsScreen(modelSql: widget.modelSql);
        }));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Hero(
                tag: "${widget.modelSql.id}",
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.modelSql.news_image!),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      widget.modelSql.news_title!,
                      style: TextStyle(
                        fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(widget.modelSql.news_description!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white54,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}