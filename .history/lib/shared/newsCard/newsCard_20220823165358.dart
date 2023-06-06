import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class NewsObject {
  final String date;
  final String title;
  final String src;
  final String description;
  final String imgURL;
  final String provider;

  NewsObject({this.date, this.title, this.src, this.description, this.imgURL, this.provider});
}

class NewsCard extends StatelessWidget {
  final NewsObject feed;
  final D

  const NewsCard({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                feed.title,
                style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).feedHeaderStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  feed.description,
                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                      .feedDateStyle
                      .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient.withOpacity(.7)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
