import 'package:valuid/shared/GeneralObject/generalObject.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:valuid/extensions/stringExt.dart';

class SectorCard extends StatelessWidget {
  final int diversificationSelectedIndex;
  final List<GeneralObject> diversificationCDT;
  final GeneralObject diverOption;
  final String diversificationOption;
  final DataObject dataObject;

  const SectorCard(
      {Key key,
      required this.diversificationSelectedIndex,
      required this.diversificationCDT,
      required this.diverOption,
      required this.diversificationOption,
      required this.dataObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: diversificationOption == 'Investments'
                  ? BorderRadius.circular(circularRadius)
                  : BorderRadius.only(
                      topLeft: Radius.circular(circularRadius), topRight: Radius.circular(circularRadius)),
              color: diversificationSelectedIndex == diversificationCDT.indexOf(diverOption)
                  ? customColours[diversificationCDT.indexOf(diverOption)].withOpacity(.3)
                  : Colors.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(Icons.circle,
                          size: 12, color: customColours[diversificationCDT.indexOf(diverOption)]),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(diverOption.name.capitalizeFirst(),
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles(dataObject.context)
                                .portfolioNameStyle
                                .copyWith(color: textColor)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${dataObject.userCurrencySymbol}${diverOption.value.toStringAsFixed(2).toString().addCommas()}',
                style: CustomTextStyles(dataObject.context).holdingValueStyle,
              ),
            ],
          ),
        ),
        diversificationOption == 'Investments'
            ? Container()
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: diversificationSelectedIndex == diversificationCDT.indexOf(diverOption)
                            ? seperator
                            : Colors.transparent,
                        width: .5),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(circularRadius),
                        bottomLeft: Radius.circular(circularRadius))),
                padding: EdgeInsets.all(5),
                child: Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: diverOption.assetList
                      .map((holding) => Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: backgroundColour,
                                borderRadius: BorderRadius.circular(circularRadius),
                                border: Border.all(color: seperator, width: .5)),
                            child: Text(
                              holding.name.toString().removeStr(),
                              style: CustomTextStyles(dataObject.context)
                                  .portfolioNameStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                ),
              ),
      ],
    );
  }
}
