import 'package:chat_app/blocs/news/news_event.dart';
import 'package:chat_app/blocs/news/news_state.dart';
import 'package:chat_app/data/news/model/field_keys.dart';
import 'package:chat_app/data/news/model/model.dart';
import 'package:chat_app/data/news/universal_data.dart';
import 'package:chat_app/services/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/news/local_database/local_database.dart';
import '../../data/news/model/status/from_status.dart';
import '../../utils/constants/constants.dart';

class NewsBloc extends Bloc<NewsEvent, NewsAddState>{
  NewsBloc({required this.newsRepository}):super(
    NewsAddState(
      news: const [],
        newsModelSql: NewsModelSql(
      author: "",
      news_date: "",
      news_description: "",
      news_image: "",
      news_title: "",
    ))
  ) {
    on<AddNews>(addNews);
    on<GetNews>(getNews);
  }

  final NewsRepository newsRepository;

  Future<void> addNews(
      AddNews event,
      Emitter<NewsAddState> emit,
      )async{
    emit(state.copyWith(
        status: FormStatus.loading,
        statusText: ""
    ));
    UniversalData response = await newsRepository.postModel(newsModel: state.newsModelSql!);
    // if(context.mounted) hideLoading(dialogContext: context);

    if(response.error.isEmpty){
      emit(state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.newsAdd,
      ),);
    }else{
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }


  Future<void> getNews(
      GetNews event,
      Emitter<NewsAddState> emit,
      )async{
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    UniversalData response = UniversalData(data: await LocalDatabase.getAllNews());
    if(response.error.isEmpty){
      emit(state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.gotAllNews,
        news: response.data as List<NewsModelSql>,
      ));
    }else{
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  updateNewsField({
    required NewsFieldKeys fieldKey,
    required dynamic value,
  }) {
    NewsModelSql currentNews = state.newsModelSql!;
    currentNews = currentNews.copyWith(news_date: DateTime.now().toString());
    switch (fieldKey) {
      case NewsFieldKeys.news_image:
        {
          currentNews = currentNews.copyWith(news_image: value as String);
          break;
        }
      case NewsFieldKeys.news_title:
        {
          currentNews = currentNews.copyWith(news_title: value as String);
          break;
        }
      case NewsFieldKeys.news_description:
        {
          currentNews = currentNews.copyWith(news_description: value as String);
          break;
        }
      case NewsFieldKeys.author:
        {
          currentNews = currentNews.copyWith(author: value as String);
          break;
        }
      case NewsFieldKeys.news_date:
        {
          currentNews = currentNews.copyWith(news_title: value as String);
          break;
        }
    }
    debugPrint("News: ${currentNews.toString()}");

    emit(state.copyWith(
      newsModelSql: currentNews,
      status: FormStatus.pure,
    ));
  }
}