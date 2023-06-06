import 'package:valuid/pages/home/create.dart';
import 'package:valuid/shared/Custome_Widgets/cards/portfolioCard.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class MainCustomBottomSheet extends StatelessWidget {
  final DataObject dataObject;
  final BuildContext ctxt;
  final Widget widget;
  final bool showCreateBtn;
  final bool customHeight;

  const MainCustomBottomSheet(
      {Key? key,
      required this.ctxt,
      required this.widget,
      this.showCreateBtn = false,
      this.customHeight = false,
      required this.dataObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0, right: 10, left: 10),
          child: Container(
              width: 70,
              padding: EdgeInsets.all(3.5),
              decoration:
                  CustomDecoration().curvedContainerDecoration.copyWith(color: backgroundColourVarient),
              child: Row(children: [])),
        ),
        Ink(
          decoration: BoxDecoration(
              color: summaryColour,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(circularRadius * 2),
                  topRight: Radius.circular(circularRadius * 2))),
          padding: const EdgeInsets.only(top: 15.0, bottom: 20, left: 10, right: 10),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                RawScrollbar(
                    thickness: 3,
                    thumbColor: textColorVarient,
                    radius: Radius.circular(circularRadius * 2),
                    child: widget),
                if (showCreateBtn) InkWell(
                        onTap: () async{
                          Navigator.pop(ctxt);

                           Navigator.push(
                              context,
                              CustomPageRouteSlideTransition(
                                direction: AxisDirection.left,
                                child: CreatePortfolio(
                                  dataObject: dataObject,
                                ),
                              ));
                        },
                        customBorder:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(circularRadius * 1.5),
                              color: backgroundColour),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_rounded,
                                size: iconSize,
                                color: textColor.withOpacity(.7),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Add portfolio',
                                    style: CustomTextStyles(context)
                                        .pageHeaderStyle
                                        .copyWith(color: textColor.withOpacity(.7))),
                              ),
                            ],
                          ),
                        )) else Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void viewPortfoliosBottomSheet({required Function setState, required DataObject dataObject}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: dataObject.context,
    builder: (ctxt) => StatefulBuilder(builder: (contextState, bottomSheetSetState) {
      return MainCustomBottomSheet(
        customHeight: true,
        dataObject: dataObject,
        showCreateBtn: true,
        widget: Container(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: dataObject.portfolios.map<Widget>((p) {
              return Column(
                children: [
                  InkWell(
                      borderRadius: BorderRadius.circular(circularRadius),
                      onTap: () {
                        dataObject.onPortfolio = p;
                        dataObject.displayHolding = dataObject.onPortfolio!.holdings;

                        

                        bottomSheetSetState(() {});
                        setState(() {});
                      },
                      child: PortfolioCard(
                        dataObject: dataObject,
                        portfolio: p,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: CustomDivider(),
                  )
                ],
              );
            }).toList(),
          ),
        ),
        ctxt: ctxt,
      );
    }),
  );
}

void viewSortOptions({@required setState, required DataObject dataObject, required List sortOptions}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: dataObject.context,
    builder: (ctxt) => StatefulBuilder(builder: (contextState, bottomSheetSetState) {
      return MainCustomBottomSheet(
        customHeight: true,
        dataObject: dataObject,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sortOptions
              .map((sort) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          dataObject.sort = sort;

                          bottomSheetSetState(() {});
                          setSort(dataObject: dataObject);

                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: CustomDecoration().curvedContainerDecoration.copyWith(
                              color: dataObject.sort == sort ? blueVarient.withOpacity(.8) : summaryColour),
                          child: Center(
                            child: Text(sort,
                                style: CustomTextStyles(dataObject.context).seeAllTextStyle.copyWith(
                                    color: dataObject.sort == sort ? summaryColour : textColorVarient)),
                          ),
                        ),
                      ),
                      sortOptions.last == sort ? Container() : CustomDivider()
                    ],
                  ))
              .toList(),
        ),
        ctxt: ctxt,
      );
    }),
  );
}

setSort({required DataObject dataObject}) {
  if (dataObject.onPortfolio!.holdings.length > 2) {
    if (dataObject.sort == 'Investment') {
      dataObject.onPortfolio!.holdings.sort((a, b) {
        return a.invested.compareTo(b.invested);
      });
    } else if (dataObject.sort == 'Return') {
      dataObject.onPortfolio!.holdings.sort((a, b) {
        return a.change.compareTo(b.change);
      });

      dataObject.onPortfolio!.holdings = dataObject.onPortfolio!.holdings.reversed.toList();
    } else if (dataObject.sort == 'Shares') {
      dataObject.onPortfolio!.holdings.sort((a, b) {
        return a.quantity.compareTo(b.quantity);
      });

      dataObject.onPortfolio!.holdings = dataObject.onPortfolio!.holdings.reversed.toList();
    } else if (dataObject.sort == 'A-Z') {
      dataObject.onPortfolio!.holdings.sort((a, b) {
        return a.name[0].compareTo(b.name[0]);
      });
    }
  }

  dataObject.displayHolding = dataObject.onPortfolio!.holdings;
}
