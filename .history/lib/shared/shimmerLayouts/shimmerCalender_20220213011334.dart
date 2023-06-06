import 'package:Onvest/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/dateFormat/customeDateFormatter.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCalender extends StatelessWidget {
  final DataObject dataObject;

  const ShimmerCalender({Key key, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
        appBarTitleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              customBorder:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
              child: Icon(
                Icons.chevron_left,
                size: Units().calenderIconSize,
                color: UserThemes(dataObject.theme).iconColour,
              ),
            ),
            InkWell(
              customBorder:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${CustomDateFormatter().months[DateTime.now().month - 1]} ${DateTime.now().year}',
                  style: CustomTextStyles(dataObject.theme).calenderTitleTextStyle,
                ),
              ),
            ),
            InkWell(
              customBorder:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
              child: Icon(
                Icons.chevron_right,
                size: Units().calenderIconSize,
                color: UserThemes(dataObject.theme).iconColour,
              ),
            ),
          ],
        ),
        dataObject: dataObject,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Shimmer.fromColors(
            period: Duration(milliseconds: 1000),
            direction: ShimmerDirection.ttb,
            baseColor: UserThemes(dataObject.theme).summaryColour,
            highlightColor: UserThemes(dataObject.theme).textColorVarient,
            child: CWListView(
              children: List<Map>.generate(
                      10, (index) => {'title': '', 'pubDate': '', 'content': '', 'index': index})
                  .map((feed) => feed['index'] <= 2
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                      CustomDecoration(dataObject.theme, true).baseContainerDecoration,
                                  // .copyWith(
                                  //     color:
                                  //         UserThemes(dataObject.theme).goldVarient.withOpacity(.1),
                                  //     border: Border.all(
                                  //         color: UserThemes(dataObject.theme)
                                  //             .goldVarient
                                  //             .withOpacity(.2))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${CustomDateFormatter().weekdaysFull[(DateTime.parse(dividend.date).weekday - 1)].toString()} - ${CustomDateFormatter().formatDateStyle(DateTime.parse(dividend.date).toString())}',
                                          style: CustomTextStyles(dataObject.theme).holdingSubValueStyle),
                                      CircleAvatar(
                                        backgroundColor: UserThemes(dataObject.theme).purpleVarient.withOpacity(.8)
                                        radius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Units().circularRadius),
                                ),
                                // onTap: () => Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => ViewDividend(
                                //         dataObject: dataObject,
                                //         instrument: event,
                                //       ),
                                //     )),
                                child: Ink(
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                      CustomDecoration(dataObject.theme, false).baseContainerDecoration,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('',
                                              style: CustomTextStyles(dataObject.theme).tableHeaderStyle),
                                          Text('',
                                              style: CustomTextStyles(dataObject.theme)
                                                  .tableHeaderStyle
                                                  .copyWith(color: UserThemes(dataObject.theme).textColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('',
                                              style: CustomTextStyles(dataObject.theme).subSectionTextStyle),
                                          Text('',
                                              style: CustomTextStyles(dataObject.theme)
                                                  .subSectionTextStyle) //.copyWith(color: UserThemes(dataObject.theme).goldVarient))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container())
                  .toList(),
            ),
          ),
        ));
  }
}
