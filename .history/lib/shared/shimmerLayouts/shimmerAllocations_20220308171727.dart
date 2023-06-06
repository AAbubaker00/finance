import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAllocations extends StatelessWidget {
  final DataObject dataObject;

  const ShimmerAllocations({Key key, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
        appBarTitle: 'Allocations',
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
                    (((dataObject.ratio) <= 1.6)) ? 6.8 : ((dataObject.width / dataObject.height) / .5),
              ),
              shrinkWrap: true,
              children: List<Map>.generate(
                      10, (index) => {'title': '', 'pubDate': '', 'content': '', 'index': index})
                  .map((feed) => feed['index'] <= 2
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
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
                        )
                      : Container())
                  .toList(),
            ),
          ),
        ));
  }
}
