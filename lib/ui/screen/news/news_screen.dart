import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:i_can_quit/data/model/news.dart';
import 'package:i_can_quit/ui/widget/shimmer/image_shimmer.dart';

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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              title: Text(this.widget.news.title),
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: this.widget.news.featuredImage ?? 'https://increasify.com.au/wp-content/uploads/2016/08/default-image.png',
                    placeholder: (context, str) {
                      return ImageShimmer();
                    }),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Html(
            padding: EdgeInsets.symmetric(horizontal: 4),
            data: this.widget.news.content,
          ),
        ),
      ),
    );
  }
}
