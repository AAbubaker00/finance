import 'package:Onvesting/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/TextStyle/customTextStyles.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
import 'package:Onvesting/shared/dateFormat/customeDateFormatter.dart';
import 'package:Onvesting/shared/decoration/customDecoration.dart';
import 'package:flutter/material.dart';

class ViewDividend extends StatelessWidget {
  final Map instrument;

  final DataObject dataObject;

  const ViewDividend({Key key, this.instrument, this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: dataObject,
      appBarTitle: '${instrument['symbol']} Dividend',
      body: CWListView(
        children: [
          Container(
              decoration: CustomDecoration(dataObject.theme, ).baseContainerDecoration,
              padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 10, left: 5),
                    child: Text(
                      '${dataObject.userCurrencySymbol}${instrument['totalPayment']} Per Share',
                      style: CustomTextStyles(dataObject.theme).sectionHeader,
                    ),
                  ),
                  Container(
                    decoration: CustomDecoration(dataObject.theme, ).baseContainerDecoration,
                    padding: EdgeInsets.all(10), //(top: 15, left: 10, right: 10, bottom: 15),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(instrument['name'], style: CustomTextStyles(dataObject.theme).sectionHeader),
                        Text(
                            '+${dataObject.userCurrencySymbol}${(instrument['totalPayment'] * instrument['shares']).toStringAsFixed(2)}',
                            style: CustomTextStyles(dataObject.theme).sectionHeader)
                      ],
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: CustomDecoration(dataObject.theme, ).baseContainerDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(CustomDateFormatter().formatDateStyle(instrument['paymentDate']),
                  //     style: CustomTextStyles(dataObject.theme).feedDateStyle),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   'In',
                      //   style: CustomTextStyles(dataObject.theme).sectionHeader,
                      // ),
                      Text(
                        'In ${CustomDateFormatter().dateDifference(instrument['paymentDate'])} Days',
                        style: CustomTextStyles(dataObject.theme).sectionHeader,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
