import 'package:Onvest/services/database/database.dart';
import 'package:Onvest/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvest/shared/Custome_Widgets/restricted/restricted.dart';
import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/customPageRoute/customePageRoute.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/dateFormat/customeDateFormatter.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  final DataObject dataObject;

  const Transactions({Key key, @required this.dataObject}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    history = widget.dataObject.onHolding['history'];
    history = history.reversed.toList();
  }

  double outstandingShares = 0.0, avgPrice = 0.0, totalReturn;
  double denominator = 0, numerator = 0, oravgP = 0, invested = 0;

  bool isMainLoaded = false, isUpdate = false;

  List changes = [], history = [];

  calculateOutstandingShares() {
    outstandingShares = 0.0;
    numerator = 0.0;

    // avgPrice = oravgP *
    //     Initialise(baseCurrency: widget.dataObject.userCurrency).getRate(widget.dataObject.rates,
    //         widget.dataObject.onHolding['marketData']['quote']['currency'].toString().capitalizeAll());

    invested = 0;
    outstandingShares = 0;
    numerator = 0;

    if (changes.isNotEmpty) {
      changes.forEach((change) => history.add(change));
    }

    changes.clear();

    history.sort((a, b) => a['filledOn'].compareTo(b['filledOn']));
    history = history.reversed.toList();

    for (var event in history) {
      if (event['type'] == 'Market Sell') {
        outstandingShares -= event['filledQuantity'];
        event['outstandingShares'] = outstandingShares;
        event['averagePrice'] = oravgP;

        invested -= (event['filledQuantity'] * event['fillPrice']);
      } else {
        outstandingShares += event['filledQuantity'];

        numerator += event['filledQuantity'] * event['fillPrice'];
        oravgP = numerator / outstandingShares;

        event['outstandingShares'] = outstandingShares;
        event['averagePrice'] = oravgP;

        invested += (event['filledQuantity'] * event['fillPrice']);
      }
    }

    // if (isUpdate == true) {
    for (var portfolio in widget.dataObject.databaseData['portfolios']) {
      if (portfolio['name'] == widget.dataObject.onPortfolio['name']) {
        for (var holdingType in portfolio['assets']) {
          for (var holding in holdingType['items']) {
            if (holding['symbol'] == widget.dataObject.onHolding['symbol']) {
              holding['history'] = history;
              holding['avgPrice'] = oravgP;
              holding['shares'] = outstandingShares;
              holding['Invested'] = invested;
            }
          }
        }
      }
    }

    for (var portfolio in widget.dataObject.portfolios) {
      if (portfolio['name'] == widget.dataObject.onPortfolio['name']) {
        for (var holdingType in portfolio['assets']) {
          for (var holding in holdingType['items']) {
            if (holding['symbol'] == widget.dataObject.onHolding['symbol']) {
              holding['history'] = history;
              holding['avgPrice'] = oravgP;
              holding['shares'] = outstandingShares;
              holding['Invested'] = invested;
            }
          }
        }
      }
    }

    DatabaseService(uid: widget.dataObject.user.uid).updateChange(widget.dataObject);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Orders',
      dataObject: widget.dataObject,
      isCenter: false,
      bottomAppBarBorderColour: false,
      appBarActions: [
        InkWell(
            highlightColor: Colors.transparent,
            child: ClipRRect(
                child: Image.asset('assets/icons/add.png',
                    width: 18, height: 18, color: UserThemes(widget.dataObject.theme).iconColour)),
            onTap: () async {
              var result = await Navigator.push(
                  context,
                  CustomPageRouteSlideTransition(
                    direction: AxisDirection.left,
                    child: OrderInfo(
                      dataObject: widget.dataObject,
                      changes: changes,
                      outstandingShares: outstandingShares,
                    ),
                  ));

              if (result != null) {
                isUpdate = true;
                calculateOutstandingShares();
                setState(() {});
              }
            })
      ],
      body: widget.dataObject.userFire.isAnonymous
          ? Restricted(dataObject: widget.dataObject)
          : CWListView(
              children: history.map((event) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: UserThemes(widget.dataObject.theme).backgroundColour,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '${CustomDateFormatter().weekdaysFull[(DateTime.parse(event['filledOn']).weekday - 1)].toString()} - ${CustomDateFormatter().formatDateStyle(DateTime.parse(event['filledOn']).toString())}',
                              style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle),
                          // InkWell(
                          //     highlightColor: Colors.transparent,
                          //     child: ClipRRect(
                          //         child: Image.asset('assets/icons/edit.png',
                          //             width: 21,
                          //             height: 21,
                          //             color: UserThemes(widget.dataObject.theme).iconColour)))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var result = await Navigator.push(
                            context,
                            CustomPageRouteSlideTransition(
                                direction: AxisDirection.left,
                                child: OrderInfo(
                                  dataObject: widget.dataObject,
                                  changes: changes,
                                  event: event,
                                  outstandingShares: outstandingShares,
                                )));

                        if (result != null) {
                          history.remove(event);

                          calculateOutstandingShares();

                          setState(() {});
                        } else {
                          print('///////////////////////////////////');
                          print(result);
                          print('///////////////////////////////////');
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(Units().circularRadius),
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: UserThemes(widget.dataObject.theme).seperator, width: 1)),
                            color: UserThemes(widget.dataObject.theme).summaryColour),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ORDER',
                                  style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                ),
                                Text(event['type'].toString(),
                                    style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                              child: Divider(
                                color: UserThemes(widget.dataObject.theme).seperator,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'PURCHASE PRICE',
                                  style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                ),
                                Text(event['fillPrice'].toString(),
                                    style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                              child: Divider(
                                color: UserThemes(widget.dataObject.theme).seperator,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'QUANTITY',
                                  style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                ),
                                Text(event['filledQuantity'].toString(),
                                    style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                              child: Divider(
                                color: UserThemes(widget.dataObject.theme).seperator,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'FILLED ON',
                                  style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                ),
                                Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(event['filledOn'].toString())),
                                    style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
