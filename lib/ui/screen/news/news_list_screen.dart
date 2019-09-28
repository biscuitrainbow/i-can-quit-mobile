import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/news/news_state.dart';
import 'package:i_can_quit/ui/screen/news/news_screen.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) {
          if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final news = state.news[index];

                return ListTile(
                  title: Text(news.title),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewsScreen(news: news)));
                  },
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
