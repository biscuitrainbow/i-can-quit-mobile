import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/news/news_event.dart';
import 'package:i_can_quit/bloc/news/news_state.dart';
import 'package:i_can_quit/data/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository);

  @override
  NewsState get initialState => InitialNewsState();

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is FetchNews) {
      try {
        final news = await newsRepository.fetchNews();

        yield NewsLoaded(news: news);
      } catch (error) {
        print(error);
      }
    }

    if (event is RefreshNews) {
      try { 
        final news = await newsRepository.fetchNews();

        print(news);
        yield NewsLoaded(news: news);
        event.refreshComplete.complete();
      } catch (error) {
        print(error);
        event.refreshComplete.completeError(null);
      }
    }
  }
}
