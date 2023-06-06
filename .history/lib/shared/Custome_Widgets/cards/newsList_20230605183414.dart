import 'package:valuid/pages/news/newsCard.dart';
import 'package:valuid/pages/news/viewNews.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class NewsList extends StatelessWidget {
  final List<Map<dynamic, dynamic>> news;

  const NewsList({required this.news});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: news.map<Widget>((feed) {
            return SliverStickyHeader(
              header: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(circularRadius),
                  onTap: () => feed['type']
                      ? Navigator.push(
                          context,
                          CustomPageRouteSlideTransition(
                              direction: AxisDirection.left,
                              child: ViewNews(
                                news: feed,
                                index: news.indexOf(feed),
                              )))
                      : print(feed['symbol']),
                  child: Container(
                    decoration: BoxDecoration(
                        color: summaryColour,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(circularRadius),
                            bottomRight: Radius.circular(circularRadius))),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(circularRadius),
                          color: profColors[news.indexOf(feed)].withOpacity(.2)),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            feed['symbol'],
                            style: CustomTextStyles(context)
                                .seeAllTextStyle
                                .copyWith(color: profColors[news.indexOf(feed)], fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          feed['type']
                              ? Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: profColors[news.indexOf(feed)],
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: NewsCard(index: news.indexOf(feed), news: feed['news'][index])),
                  childCount: feed['type'] ? 3 : feed['news'].length,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
