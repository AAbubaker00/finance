import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CommodityCard extends StatelessWidget {
  final DataObject dataObject;
  final Map commodity;

  const CommodityCard({Key key, this.dataObject, this.commodity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: CustomDecoration(dataObject.theme)
          .baseContainerDecoration
          .copyWith(border: Border.all(color: Colors.transparent)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        commodity['name'],
                        style: CustomTextStyles(dataObject.theme, dataObject.context)
                            .portfolioNameStyle
                            .copyWith(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    commodity['name'],
                    style: CustomTextStyles(dataObject.theme, dataObject.context).holdingSubValueStyle,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: iconColour,
          )
        ],
      ),
    );
  }
}
