import 'package:valuid/models/portfolio/portfolio.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PortfolioCard extends StatelessWidget {
  final DataObject dataObject;
  final PortfolioObject portfolio;

  const PortfolioCard({Key? key, required this.dataObject, required this.portfolio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circularRadius * 2),
          color: portfolio == dataObject.onPortfolio ? blueVarient.withOpacity(.8) : summaryColour),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(portfolio.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles(context).holdingValueStyle.copyWith(
                      color: portfolio == dataObject.onPortfolio ? summaryColour : textColorVarient)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    portfolio.value > 1000000000
                        ? '${dataObject.userCurrencySymbol}${NumberFormat.compact().format(portfolio.value)}'
                        : '${dataObject.userCurrencySymbol}${portfolio.value.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: CustomTextStyles(context).pageHeaderStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: portfolio == dataObject.onPortfolio ? summaryColour : textColorVarient)),
              ),
            ],
          ),
          portfolio == dataObject.onPortfolio
              ? Container(
                  decoration: BoxDecoration(color: summaryColour, borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.done, color: blueVarient))
              : Container(),
        ],
      ),
    );
  }
}
