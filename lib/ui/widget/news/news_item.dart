import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/news.dart';
import 'package:i_can_quit/ui/widget/shimmer/image_shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsGeneralItem extends StatelessWidget {
  final News news;
  final VoidCallback onTap;

  NewsGeneralItem({
    this.news,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        margin: EdgeInsets.only(bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              fit: BoxFit.cover,
              height: 200.0,
              width: 500.0,
              imageUrl: news.featuredImage ?? 'https://increasify.com.au/wp-content/uploads/2016/08/default-image.png',
              placeholder: (context, str) => ImageShimmer(),
            ),
            Text(
              news.title,
              textAlign: TextAlign.start,
              style: Styles.headerSectionPrimary,
            ),
            Text(
              timeago.format(news.updatedAt),
              style: Styles.descriptionSecondary,
            )
          ],
        ),
      ),
    );
  }
}
