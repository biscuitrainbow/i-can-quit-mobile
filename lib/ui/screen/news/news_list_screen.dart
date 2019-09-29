import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/news/news_event.dart';
import 'package:i_can_quit/bloc/news/news_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/ui/screen/news/news_screen.dart';
import 'package:i_can_quit/ui/widget/news/news_item.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ข่าวสาร', style: TextStyle(color: ColorPalette.primary)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) {
          print(state);
          if (state is NewsLoaded) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () {
                final _refreshCompleter = Completer<void>();
                newsBloc.dispatch(RefreshNews(refreshComplete: _refreshCompleter));

                return _refreshCompleter.future;
              },
              child: ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final news = state.news[index];

                  return NewsGeneralItem(
                    news: news,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewsScreen(news: news))),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
