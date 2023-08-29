import 'package:chat_app/data/news/model/model.dart';
import 'package:equatable/equatable.dart';
import '../../data/news/model/status/from_status.dart';

class NewsAddState extends Equatable{
  final String statusText;
  final NewsModelSql newsModelSql;
  final FormStatus status;
  final List<NewsModelSql> news;

  const NewsAddState({
    required this.newsModelSql,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.news,
  });

  NewsAddState copyWith({
    List<NewsModelSql>? news,
    String? statusText,
    NewsModelSql? newsModelSql,
    FormStatus? status,
  }) => NewsAddState(
    news: news ?? this.news,
    newsModelSql: newsModelSql ?? this.newsModelSql,
    statusText: statusText ?? this.statusText,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    newsModelSql,
    statusText,
    status,
  ];

  bool canAddWebsite() {
    if (newsModelSql!.author.isEmpty) return false;
    if (newsModelSql!.news_description.isEmpty) return false;
    if (newsModelSql!.news_title.isEmpty) return false;
    if (newsModelSql!.news_image.isEmpty) return false;
    return true;
  }
}
