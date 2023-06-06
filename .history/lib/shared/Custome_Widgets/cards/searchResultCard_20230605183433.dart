import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  final DataObject dataObject;
  final Map result;

  const SearchResultCard({Key key, required this.dataObject, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration:
          CustomDecoration().baseContainerDecoration,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                        "${result['name'].toString()}",
                        style: CustomTextStyles(dataObject.context, value: 18).portfolioNameStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "${result['symbol']}, ${result['exch']}",
                    style: CustomTextStyles(dataObject.context).holdingSubValueStyle,
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
