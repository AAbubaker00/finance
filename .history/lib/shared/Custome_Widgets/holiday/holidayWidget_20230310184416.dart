import 'package:Valuid/services/robomarkets/roboMarkets.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class HolidayWidget extends StatelessWidget {
  final DataObject dataObject;
  final RoboMarketsHolidayObject holiday;

  const HolidayWidget({Key key, this.dataObject, this.holiday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          border: Border(
              // right: BorderSide(
              //     // width: 3,
              //     color: blueVarient_2.withOpacity(.03)),
              // bottom: BorderSide(
              //     // width: 3,
              //     color: blueVarient_2.withOpacity(.03)),
              // top: BorderSide(
              //     // width: 3,
              //     color: blueVarient_2.withOpacity(.03)),
              left: BorderSide(width: 3, color: blueVarient_2.withOpacity(.4))),
          color: blueVarient_2.withOpacity(.02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Text(holiday.country,
                style: CustomTextStyles(dataObject.theme, dataObject.context)
                    .tableHeaderStyle
                    .copyWith(color: blueVarient_2.withOpacity(.7))),
          ),
          Text(holiday.holiday,
              style: CustomTextStyles(dataObject.theme, dataObject.context).holdingValueStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: blueVarient_2.withOpacity(.7))),
          Padding(
            padding:  EdgeInsets.only(top: 12.0),
            child: Container(
              decoration: CustomDecoration(dataObject.theme).curvedContainerDecoration.copyWith(
                  color: redVarient.withOpacity(.07),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    width: .7,
                    color: redVarient.withOpacity(.1),
                  )),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text('Market Closed',
                  style: CustomTextStyles(dataObject.theme, dataObject.context)
                      .holdingValueStyle
                      .copyWith(color: redVarient)),
            ),
          ),
        ],
      ),
    );
  }
}
