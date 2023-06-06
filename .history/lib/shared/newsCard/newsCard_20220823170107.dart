import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


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
  final DataObject dataObject;

  const NewsCard({Key key, this.feed, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async=> {
         if (await canLaunch(
                                                                                  feed.src))
                                                                                await launch(feed.src);
                                                                              else
                                                                                throw "Could not launch ${result['link']}";
      },
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  feed.title,
                  style: CustomTextStyles(dataObject.theme, dataObject.context).feedHeaderStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    feed.description,
                    style: CustomTextStyles(dataObject.theme, dataObject.context)
                        .feedDateStyle
                        .copyWith(color: UserThemes(dataObject.theme).textColorVarient.withOpacity(.7)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
