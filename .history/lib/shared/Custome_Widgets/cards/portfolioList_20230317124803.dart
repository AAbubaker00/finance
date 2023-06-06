import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class PortfolioList extends StatelessWidget {
  const PortfolioList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
              widget.dataObject.portfolios.length + 1,
              (index) => index == widget.dataObject.portfolios.length
                  ? Container()
                  : widget.dataObject.portfolios[index])
          .map<Widget>((portfolio) => portfolio.runtimeType == Container
              ? CWApplyButton(
                  isLinearGradient: true,
                  isBgColurOn: false,
                  customColour: blueVarient,
                  customTextColour: summaryColour,
                  customTextStyle: CustomTextStyles(widget.dataObject.context)
                      .appBarTitleStyle
                      .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
                  function: () => Navigator.push(
                      context,
                      CustomPageRouteSlideTransition(
                        direction: AxisDirection.left,
                        child: CreatePortfolio(
                          dataObject: widget.dataObject,
                        ),
                      )),
                  btnText: 'ADD PORTFOLIO',
                  verticalPadding: 20,
                  addBorder: false,
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(circularRadius),
                      onTap: () async {
                        widget.dataObject.onPortfolio = portfolio;
                        Navigator.push(
                            context,
                            CustomPageRouteSlideTransition(
                                direction: AxisDirection.left,
                                child: ViewPortfolio(dataObject: widget.dataObject)));
                      },
                      child: PortfolioCard(
                        index: widget.dataObject.portfolios.indexOf(portfolio),
                        dataObject: widget.dataObject,
                        portfolio: portfolio,
                      )),
                ))
          .toList(),
    );
  }
}
