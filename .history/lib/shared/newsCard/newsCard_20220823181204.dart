import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
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
      onTap: () async => {
        if (await canLaunch(feed.src)) {await launch(feed.src)} else {throw "Could not launch ${feed.src}"}
      },
      borderRadius: BorderRadius.circular(Units().circularRadius),
      child: Ink(
        decoration: CustomDecoration(dataObject.theme).curvedBaseContainerDecoration,
        padding: EdgeInsets.all(5),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    feed.title,
                    style: CustomTextStyles(dataObject.theme, dataObject.context)
                        .feedHeaderStyle
                        .copyWith(fontWeight: FontWeight.w600),
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
              ),
            ),
            feed.imgURL != ''
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Units().circularRadius),
                      child: Image.network(feed.imgURL,
                          errorBuilder: (context, error, stackTrace) => Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: UserThemes(dataObject.theme).textColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                          height: 60, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                          width: 60, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                          fit: BoxFit.contain),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
