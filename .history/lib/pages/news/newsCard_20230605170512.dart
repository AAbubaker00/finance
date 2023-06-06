import 'package:valuid/pages/news/newsObject.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/Custome_Widgets/divider.dart/divider.dart';

class NewsCard extends StatelessWidget {
  final int index;
  final NewsObject news;

  const NewsCard({required this.index,required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(news.src)))
          await launchUrl(Uri.parse(news.src));
        else
          throw "Could not launch ${news.src}";
      },
      borderRadius: BorderRadius.circular(calenderCircularRadius),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColour,
          borderRadius: BorderRadius.circular(calenderCircularRadius),
        ),
      padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    news.title,
                    style: CustomTextStyles(context).holdingValueStyle.copyWith(color: profColors[index]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      news.description,
                      style: CustomTextStyles(context).feedDateStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CustomDivider(
                color: seperator,
                thickness: .7,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      news.date == ''
                          ? ''
                          : CustomDateFormatter()
                              .getTimeDifferenceToString(DateTime.parse(news.date).toString()),
                      style: CustomTextStyles(context).holdingSubValueStyle),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10,
                    color: iconColour,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

