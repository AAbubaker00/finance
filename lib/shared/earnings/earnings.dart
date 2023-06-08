// ignore_for_file: unnecessary_null_comparison

import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/shared/Custome_Widgets/cards/eventContainer%20.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Earnings {
  late String date;
  late String symbol;
  late String name;

  late double estimate;

  Earnings();

  Earnings.fromMarketMap(Map data, String symbol, String name)
      : date = data['earningsDate'][0]['fmt'],
        estimate = data['earningsAverage']['raw'],
        name = name,
        symbol = symbol;

  Earnings earningsfromDocument({required date, required s, required n}) {
    var inputFormat = DateFormat('MM/dd/yyyy');
    var outputFormat = DateFormat('yyyy-MM-dd');

    Earnings e = new Earnings();
    e.date = outputFormat.format(inputFormat.parse(date));
    e.symbol = s;

    return e;
  }

  // Earnings.fromJson(Map jsonEarnings): symbol = json

  Earnings.fromMap(Map earning)
      : date = earning['date'],
        symbol = earning['symbol'],
        name = earning['name'],
        estimate = earning['estimate'];

  earningsToMap(Earnings earnings) => {
        'date': earnings.date,
        'symbol': earnings.symbol,
        'name': earnings.name,
        'estimate': earnings.estimate
      };

  List<Earnings> getMapToEarningsList(List earnigns) =>
      List.generate(earnigns.length, (index) => Earnings.fromMap(earnigns[index]));
}

class EarningsWidget extends StatelessWidget {
  const EarningsWidget({Key? key, required this.earnigns}) : super(key: key);

  final Earnings earnigns;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: EventContainer(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: purpleVarient.withOpacity(.9),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Earnings',
                        style: CustomTextStyles(context, value: 18)
                            .portfolioNameStyle
                            .copyWith(fontWeight: FontWeight.w700, color: purpleVarient.withOpacity(.8))),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(earnigns.name.toString().removeStr(),
                          style: CustomTextStyles(context, value: 18).portfolioNameStyle),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Earnings Per Share',
                            style: CustomTextStyles(context, value: 18)
                                .portfolioNameStyle
                                .copyWith(color: textColor.withOpacity(.6))),
                        Text(earnigns.estimate == null ? '...' : '~${earnigns.estimate}',
                            style: CustomTextStyles(context)
                                .holdingValueStyle
                                .copyWith(color: purpleVarient.withOpacity(.7), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
