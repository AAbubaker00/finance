import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/pages/calender/viewDividend.dart';
import 'package:valuid/shared/Custome_Widgets/cards/eventContainer%20.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/extensions/stringExt.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

class Dividends {
  String exDate;
  String date;
  String announced;
  String yield;
  String record;
  String amount;

  String dividendType = 'div';

  String symbol;
  String exchange;
  String currency;
  String name;

  num shares;

  Dividends();

  Dividends.fromElement(dom.Element element, QuoteObject holding)
      : exDate = element.children[4].text,
        date = element.children[6].text,
        announced = element.children[0].text,
        yield = element.children[3].text,
        record = element.children[5].text,
        amount = element.children[2].text.toString(),
        shares = holding.quantity,
        symbol = holding.symbol,
        currency = holding.currency,
        exchange = holding.exchange,
        name = holding.name;

  Dividends.fromMap(Map dividend)
      : exDate = dividend['exDate'],
        date = dividend['date'],
        record = dividend['record'],
        announced = dividend['announced'],
        yield = dividend['yield'],
        currency = dividend['currency'],
        amount = dividend['amount'],
        shares = dividend['shares'],
        symbol = dividend['symbol'],
        exchange = dividend['exchange'],
        name = dividend['name'];

  Map dividendsToMap(Dividends dividends) => {
        'exDate': dividends.exDate,
        'date': dividends.date,
        'announced': dividends.announced,
        'yield': dividends.yield,
        'amount': dividends.amount,
        'record': dividends.record,
        'dividendType': dividends.dividendType,
        'currency': dividends.currency,
        'symbol': dividends.symbol,
        'exchange': dividends.exchange,
        'name': dividends.name,
        'shares': dividends.shares,
      };

  List<Dividends> getMapToDividendList(List data) =>
      List.generate(data.length, (index) => Dividends.fromMap(data[index]));
}

class DividendsWidget extends StatelessWidget {
  const DividendsWidget({Key? key, this.dividend}) : super(key: key);

  final dividend;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(circularRadius),
      onTap: () async => await Navigator.push(
          context,
          CustomPageRouteSlideTransition(
              direction: AxisDirection.left,
              child: ViewDividend(
                dividends: dividend,
              ), settings: null)),
      child: IntrinsicHeight(
        child: EventContainer(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: dividend.dividendType == 'ex'
                      ? redVarient_2.withOpacity(.9)
                      : greenVarient_2.withOpacity(.9),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dividend.dividendType == 'div' ? 'Dividend' : 'Ex-Dividend',
                          style: CustomTextStyles(context, value: 18).portfolioNameStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: dividend.dividendType == 'ex'
                                  ? redVarient_2.withOpacity(.8)
                                  : greenVarient_2.withOpacity(.8))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(dividend.name.toString().removeStr(),
                            style: CustomTextStyles(context, value: 18).portfolioNameStyle),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Dividend Per Share',
                                style: CustomTextStyles(context, value: 18)
                                    .portfolioNameStyle
                                    .copyWith(color: textColor.withOpacity(.6))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    dividend.dividendType == 'ex'
                                        ? '${dividend.amount}'
                                        : '+${dividend.amount.replaceAll(RegExp("[0-9]"), "").replaceAll(".", '')}${(double.parse((dividend.amount.replaceAll(RegExp("[^\\d.]"), "").toString()))).toStringAsFixed(2)}',
                                    style: CustomTextStyles(context).holdingValueStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: dividend.dividendType == 'ex'
                                            ? redVarient_2.withOpacity(.8)
                                            : greenVarient_2.withOpacity(.8))),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15,
                                      color: dividend.dividendType == 'ex'
                                          ? redVarient_2.withOpacity(1)
                                          : greenVarient_2.withOpacity(1),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
