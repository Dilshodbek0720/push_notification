
class NewsModelFields {
  static const String id = "_id";
  static const String author = "author";
  static const String news_image = "news_image";
  static const String news_description = "news_description";
  static const String news_date = "news_date";
  static const String news_title = "news_title";
  static const String table_name = "xabarlar";
}

class NewsModelSql {
  int? id;
  final String author;
  final String news_image;
  final String news_description;
  final String news_date;
  final String news_title;

  NewsModelSql({
    this.id,
    required this.author,
    required this.news_image,
    required this.news_description,
    required this.news_date,
    required this.news_title
  });

  NewsModelSql copyWith({
    String? author,
    String? news_image,
    String? news_description,
    String? news_date,
    String? news_title,
    int? id,
  }) {
    return NewsModelSql(
      author: author ?? this.author,
      news_image: news_image ?? this.news_image,
      news_description: news_description ?? this.news_description,
      news_date: news_date ?? this.news_date,
      news_title: news_title ?? this.news_title,
      id: id ?? this.id,
    );
  }

  factory NewsModelSql.fromJson(Map<String, dynamic> json) {
    return NewsModelSql(
      author: json[NewsModelFields.author] ?? "",
      news_image: json[NewsModelFields.news_image] ?? "",
      news_description: json[NewsModelFields.news_description] ?? "",
      news_date: json[NewsModelFields.news_date] ?? "",
      news_title: json[NewsModelFields.news_title] ?? "",
      id: json[NewsModelFields.id] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NewsModelFields.author: author,
      NewsModelFields.news_image: news_image,
      NewsModelFields.news_description: news_description,
      NewsModelFields.news_date: news_date,
      NewsModelFields.news_title: news_title,
    };
  }

  @override
  String toString() {
    return '''
      author: $author
      news_image: $news_image
      news_description: $news_description
      news_date: $news_date
      news_title: $news_title
      id: $id, 
    ''';
  }
}