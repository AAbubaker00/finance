import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNews extends StatelessWidget {
  final DataObject dataObject;

  const ShimmerNews({Key key, @required this.dataObject}) : super(key: key);

  getBody() {
    return List<Map>.generate(10, (index) => {'title': '', 'pubDate': '', 'content': ''})
        .map<Widget>((feed) => Padding(
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
                  decoration: CustomDecoration(dataObject.theme, true).baseContainerDecoration.copyWith(
                      border: Border.all(
                          color: Colors
                              .transparent)), //.copyWith(color: UserThemes(dataObject.theme).iconColour),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        feed['title'],
                        style: CustomTextStyles(dataObject.theme).feedHeaderStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        feed['content'],
                        style: CustomTextStyles(dataObject.theme).feedDescriptonStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feed['pubDate'],
                            style: CustomTextStyles(dataObject.theme).feedDateStyle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: UserThemes(dataObject.theme).iconColour,
                            size: Units().iconSize,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'News',
      dataObject: dataObject,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Shimmer.fromColors(
          period: Duration(milliseconds: 1000),
          direction: ShimmerDirection.ttb,
          baseColor: UserThemes(dataObject.theme).summaryColour,
          highlightColor: UserThemes(dataObject.theme).textColorVarient,
          child: GridView.count(
            crossAxisCount: 1,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            childAspectRatio:
                (((dataObject.ratio) <= 1.6)) ? 6.8 : ((dataObject.width / dataObject.height) / .2),
            // scrollDirection: Axis.vertical,
            children:getBody()
          ),
        ),
      ),
    );
  }
}
