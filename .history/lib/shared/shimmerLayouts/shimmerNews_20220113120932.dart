import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNews extends StatelessWidget {
  const ShimmerNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return CWScaffold(
        appBarTitle: 'News',
        dataObject: widget.dataObject,
        body: CWListView(
          children: [
            Shimmer.fromColors(
              period: Duration(milliseconds: 1000),
              direction: ShimmerDirection.ltr,
              baseColor: UserThemes(widget.dataObject.themeMode).summaryColour,
              highlightColor: UserThemes(widget.dataObject.themeMode).textColorVarient,
              child: GridView.count(
                crossAxisCount: 1,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                childAspectRatio: (((ratio) <= 1.6)) ? 6.8 : ((width / height) / .2),
                // scrollDirection: Axis.vertical,
                children: List<Map>.generate(10, (index) => {'title': '', 'pubDate': '', 'content': ''})
                    .map((feed) => Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: InkWell(
                            // onTap: () async {
                            //   if (await canLaunch(feed['link']))
                            //     await launch(feed['link']);
                            //   else
                            //     throw "Could not launch ${feed['link']}";
                            // },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Units().circularRadius),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: CustomDecoration(widget.dataObject.themeMode, true)
                                  .baseContainerDecoration
                                  .copyWith(
                                      border: Border.all(
                                          color: Colors
                                              .transparent)), //.copyWith(color: UserThemes(widget.dataObject.themeMode).iconColour),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    feed['title'],
                                    style: CustomTextStyles(widget.dataObject.themeMode).feedHeaderStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    feed['content'],
                                    style: CustomTextStyles(widget.dataObject.themeMode).feedDescriptonStyle,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        feed['pubDate'],
                                        style: CustomTextStyles(widget.dataObject.themeMode).feedDateStyle,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: UserThemes(widget.dataObject.themeMode).iconColour,
                                        size: Units().iconSize,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      );
     }
}