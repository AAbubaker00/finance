import 'package:Strice/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Strice/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/dataObject/data_object.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerInstrument extends StatelessWidget {
  final DataObject dataObject;

  const ShimmerInstrument({Key key, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
        appBarTitle: '',
        dataObject: dataObject,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Shimmer.fromColors(
            period: Duration(milliseconds: 1000),
            direction: ShimmerDirection.ttb,
            baseColor: UserThemes(dataObject.theme).summaryColour,
            highlightColor: UserThemes(dataObject.theme).textColorVarient,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio:
                    (((dataObject.ratio) <= 1.6)) ? 6.8 : ((dataObject.width / dataObject.height) / .2),
              ),
              shrinkWrap: true,
              children: List<Map>.generate(
                      10, (index) => {'title': '', 'pubDate': '', 'content': '', 'index': index})
                  .map((feed) => feed['index'] <= 2
                      ? Padding(
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
                              padding: EdgeInsets.all(feed['index'] ==2? 5000: 10),
                              decoration: CustomDecoration(dataObject.theme, true)
                                  .baseContainerDecoration
                                  .copyWith(
                                      border: Border.all(
                                          color: Colors
                                              .transparent)), //.copyWith(color: UserThemes(dataObject.theme).iconColour),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                 
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container())
                  .toList(),
            ),
          ),
        ));
  }
}
