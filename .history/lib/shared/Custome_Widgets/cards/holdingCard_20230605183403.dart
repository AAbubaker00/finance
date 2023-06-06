import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/shared/Custome_Widgets/cards/eventContainer%20.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/extensions/stringExt.dart' as str;
import 'package:valuid/shared/units/units.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HoldingCard extends StatelessWidget {
  final QuoteObject holding;
  final DataObject dataObject;
  final int index;

  const HoldingCard({
    Key? key,
    required this.holding,
    required this.dataObject,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    holding.name,
                    style: CustomTextStyles(dataObject.context).portfolioNameStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                holding.value > 1000000000
                    ? '${dataObject.userCurrencySymbol}${NumberFormat.compact().format(holding.value)}'
                    : '${dataObject.userCurrencySymbol}${holding.value.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: CustomTextStyles(dataObject.context)
                    .holdingValueStyle
                    .copyWith(fontWeight: FontWeight.w600),
                softWrap: true,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    (holding.quantity > 10000000
                        ? '${NumberFormat.compact().format(holding.quantity)} SHARES'
                        : '${holding.quantity.toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SHARES'),
                    style: CustomTextStyles(dataObject.context)
                        .deleteTextStyle
                        .copyWith(fontWeight: FontWeight.w400, color: textColor.withOpacity(.6))),
                Text(
                    '${holding.change < 0 ? '-' : '+'}${dataObject.userCurrencySymbol}' +
                        (holding.change > 100000
                            ? '${NumberFormat.compact().format(holding.change)}'
                            : '${(holding.change * (holding.change < 0 ? -1 : 1)).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}') +
                        ' (${(holding.changePercent * (holding.change < 0 ? -1 : 1)).toStringAsFixed(2).addCommas()}%)',
                    style: CustomTextStyles(dataObject.context)
                        .holdingSubValueStyle
                        .copyWith(color: holding.change > 0 ? greenVarient : redVarient)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
