import 'package:flutter/material.dart';

class NewsObject {
  final String date;
  final String title;
  final String src;
  final String description;
  final String imgURL;
  final String provider;

  NewsObject(this.provider, {this.date, this.title, this.src, this.description, this.imgURL});
}

class NewsCard extends StatelessWidget {
  final NewsObject feed;

  const NewsCard({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [],
      ),
    );
  }
}
