import 'package:Valuid/pages/home/create.dart';
import 'package:Valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/cards/portfolioCard.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class PortfolioList extends StatelessWidget {
  final DataObject dataObject;

  const PortfolioList({@required this.dataObject});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
          child: Text('Your portfolios', style: CustomTextStyles(context).portfolioNameStyle),
        ),
        Column(
          children: List.generate(
                  dataObject.portfolios.length + 1,
                  (index) =>
                      index == dataObject.portfolios.length ? Container() : dataObject.portfolios[index])
              .map<Widget>((portfolio) => portfolio.runtimeType == Container
                  ? CWApplyButton(
                      isLinearGradient: true,
                      isBgColurOn: false,
                      customColour: blueVarient,
                      customTextColour: summaryColour,
                      customTextStyle: CustomTextStyles(context)
                          .appBarTitleStyle
                          .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
                      function: () async {
                      await  Navigator.push(
                            context,
                            CustomPageRouteSlideTransition(
                              direction: AxisDirection.left,
                              child: CreatePortfolio(
                                dataObject: dataObject,
                              ),
                            )).then((value) => null);
                      },
                      btnText: 'ADD PORTFOLIO',
                      verticalPadding: 20,
                      addBorder: false,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(circularRadius),
                          onTap: () async {
                            dataObject.onPortfolio = portfolio;
                            Navigator.push(
                                context,
                                CustomPageRouteSlideTransition(
                                    direction: AxisDirection.left,
                                    child: ViewPortfolio(dataObject: dataObject)));
                          },
                          child: PortfolioCard(
                            dataObject: dataObject,
                            portfolio: portfolio,
                          )),
                    ))
              .toList(),
        ),
      ],
    );
  }
}
