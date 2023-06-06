import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsObject {
  String date;
  String title;
  String src;
  String description;
  String imgURL;
  String provider;

  NewsObject({this.date, this.title, this.src, this.description, this.imgURL, this.provider});

  newsObjectToMap(NewsObject newsObject) => {
        'date': newsObject.date,
        'title': newsObject.title,
        'src': newsObject.src,
        'description': newsObject.description,
        'imgURL': newsObject.imgURL,
        'provider': newsObject.provider
      };

  NewsObject.fromMap(Map newsObjectMap)
      : date = newsObjectMap['date'],
        title = newsObjectMap['title'],
        src = newsObjectMap['src'],
        description = newsObjectMap['description'],
        imgURL = newsObjectMap['imgURL'],
        provider = newsObjectMap['provider'];
}

class NewsCard extends StatelessWidget {
  final NewsObject feed;
  final DataObject dataObject;

  const NewsCard({Key key, this.feed, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => {
        if (await canLaunch(feed.src)) {await launch(feed.src)} else {throw "Could not launch ${feed.src}"}
      },
      borderRadius: BorderRadius.circular(circularRadius),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              feed.title,
              style: CustomTextStyles(dataObject.theme, dataObject.context)
                  .holdingValueStyle
                  .copyWith(color: textColor, fontWeight: FontWeight.w500),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(feed.provider,
                  style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle),
            )
          ],
        ),
      ),
    );
  }
}
