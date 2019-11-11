import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/news/news_event.dart';
import 'package:i_can_quit/bloc/news/news_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/ui/screen/news/news_screen.dart';
import 'package:i_can_quit/ui/util/ui_util.dart';
import 'package:i_can_quit/ui/widget/news/news_item.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  final List<Tab> tabs = <Tab>[
    new Tab(text: "ข่าวสารบุหรี่"),
    new Tab(text: "ข่าวสารพระพุทธศาสนา"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: ColorPalette.primary,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) {
          if (state is NewsLoaded) {
            final smokingNews = state.news.where((news) => news.category == 'ข่าวสารเกี่ยวกับบุหรี่').toList();
            final religionNews = state.news.where((news) => news.category == 'ข่าวสารเกี่ยวกับพุทธศาสนา').toList();

            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                final _refreshCompleter = Completer<void>();
                newsBloc.add(RefreshNews(refreshComplete: _refreshCompleter));

                _refreshCompleter.future.then((_) => UiUtil.showMessage('แสดงข่าวสารล่าสุดแล้ว'));

                return _refreshCompleter.future;
              },
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListView.builder(
                    itemCount: smokingNews.length,
                    itemBuilder: (context, index) {
                      final news = smokingNews[index];

                      return NewsGeneralItem(
                        news: news,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewsScreen(news: news))),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: religionNews.length,
                    itemBuilder: (context, index) {
                      final news = religionNews[index];

                      return NewsGeneralItem(
                        news: news,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewsScreen(news: news))),
                      );
                    },
                  )
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
