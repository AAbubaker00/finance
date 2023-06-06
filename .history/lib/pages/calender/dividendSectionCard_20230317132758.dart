import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/dateFormat/customeDateFormatter.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class DividendSection extends StatelessWidget {
  final Map sectionData;

  DividendSection({Key key, this.sectionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          decoration: CustomDecoration().curvedContainerDecoration.copyWith(
            color: Colors.transparent,
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionData['Id'],
                style: CustomTextStyles(context)
                    .seeAllTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '${CustomDateFormatter().formatDateStyle(DateTime.parse(sectionData['date']).toString())}',
                style: CustomTextStyles(context)
                    .holdingSubValueStyle
                    .copyWith(color: textColorVarient),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 5,
          ),
          child: CustomDivider(dataObject: dataObject,),
        ),
        Column(
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: sectionData['text'],
                    style: CustomTextStyles( dataObject.context).feedDateStyle,
                  ),
                  sectionData['extraText'] != ''
                      ? TextSpan(
                          text: sectionData['extraText'],
                          style: CustomTextStyles( dataObject.context)
                              .feedDateStyle
                              .copyWith(color: blueVarient),
                        )
                      : TextSpan(text: ''),
                  sectionData['extraText'] != ''
                      ? TextSpan(
                          text: ' at a ',
                          style: CustomTextStyles( dataObject.context).feedDateStyle,
                        )
                      : TextSpan(text: ''),
                  sectionData['extraText'] != ''
                      ? TextSpan(
                          text: sectionData['extraText2'],
                          style: CustomTextStyles( dataObject.context)
                              .feedDateStyle
                              .copyWith(color: blueVarient),
                        )
                      : TextSpan(text: ''),
                ])),
            sectionData['portfolios'] != ''
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sectionData['portfolios']
                          .map<Widget>((portfolio) => Padding(
                                padding: EdgeInsets.only(
                                    right: sectionData['portfolios'].last != portfolio ? 15.0 : 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(portfolio['name'],
                                        style: CustomTextStyles( dataObject.context)
                                            .holdingValueStyle),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('+' + portfolio['total'],
                                        style: CustomTextStyles( dataObject.context)
                                            .holdingValueStyle
                                            .copyWith(color: greenVarient)),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Container()
          ],
        )
      ],
    );
  }
}
