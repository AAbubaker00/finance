import 'package:valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:valuid/shared/Custome_Widgets/cards/portfolioCard.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class PortfolioList extends StatelessWidget {
  final DataObject dataObject;

  const PortfolioList({@required this.dataObject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        children: dataObject.portfolios
            .map<Widget>((portfolio) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(circularRadius*2),
                      onTap: () async {
                        dataObject.onPortfolio = portfolio;
                        Navigator.push(
                            context,
                            CustomPageRouteSlideTransition(
                                direction: AxisDirection.left, child: ViewPortfolio(dataObject: dataObject)));
                      },
                      child: PortfolioCard(
                        dataObject: dataObject,
                        portfolio: portfolio,
                      )),
                ))
            .toList(),
      ),
    );
  }
}
