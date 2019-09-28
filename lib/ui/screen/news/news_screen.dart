import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:i_can_quit/data/model/news.dart';

class NewsScreen extends StatefulWidget {
  final News news;

  const NewsScreen({Key key, this.news}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Html(
        data: widget.news.content,
      ),
    );
  }
}
