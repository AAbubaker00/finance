import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/files/fileHandler.dart';
import 'package:valuid/shared/pageLoaders/additionConfirm.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:valuid/shared/themes/themes.dart';

class ViewResult extends StatefulWidget {
  final DataObject dataObject;
  final result;

  const ViewResult({Key key, this.dataObject, this.result}) : super(key: key);
  @override
  _ViewResult createState() => _ViewResult();
}

class _ViewResult extends State<ViewResult> {
  double purchasePrice = 0, quantity = 0;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String hintText_0 = '0', hintText_1 = '0', pName = '';

  QuoteObject quoteResult;

  Future<bool> getQuote() async {
    quoteResult = await Marke()
        .getYahooQuote(exchange: widget.result['exchange'], symbol: widget.result['symbol']);

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    print(widget.result);

    // pName = widget.dataObject.onPortfolio.name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: quoteResult == null ? getQuote() : Future.value(true),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          print((widget.dataObject.onPortfolio == null).toString());
          return CWScaffold(
            isCenter: false,
            scaffoldBgColour: BgTheme.LIGHT,
            appbarColourOption: 2,
            preferredSizeValue: 2.4,
            appBarBottomWidget: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 3.0,
                            ),
                            child: Text(
                              '${quoteResult.currency}',
                              style: CustomTextStyles(widget.dataObject.context).overallCurrencyStyle,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${quoteResult.regularMarketPrice.toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: CustomTextStyles(widget.dataObject.context).overallValueStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0, left: 1),
                                child: Text(
                                  '${(quoteResult.regularMarketPrice - quoteResult.regularMarketPrice.toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                                  style: CustomTextStyles(widget.dataObject.context).overallCurrencyStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            ((quoteResult.regularMarketPrice >= 0)
                                    ? '+${quoteResult.currency}${quoteResult.regularMarketPrice.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                    : '-${quoteResult.currency}${(quoteResult.regularMarketPrice * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}') +
                                '(${(quoteResult.regularMarketChange).toStringAsFixed(2)}%)',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: (quoteResult.regularMarketPrice > 0) ? greenVarient : redVarient)),
                        Text(' DAILY', style: CustomTextStyles(widget.dataObject.context).tableHeaderStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            appBarTitleWidget: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(quoteResult.name,
                        style: CustomTextStyles(widget.dataObject.context).appBarTitleStyle),
                  ),
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: CWListView(
                padding: const EdgeInsets.only(bottom: 20, top: 30),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Purchase/Average price',
                            style: CustomTextStyles(widget.dataObject.context)
                                .holdingValueStyle
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            focusNode: focusNode_0,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            validator: (txt) {
                              if (txt.isEmpty || double.parse(txt) <= 0) {
                                return 'Purchase price cannot be empty or lower than 0.';
                              } else {
                                return null;
                              }
                            },
                            style: CustomTextStyles(widget.dataObject.context)
                                .overallCurrencyStyle
                                .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: CustomTextStyles(widget.dataObject.context)
                                  .overallCurrencyStyle
                                  .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                              hintText: hintText_0,
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onChanged: (txt) {
                              setState(() {
                                purchasePrice = double.parse(txt.isEmpty ? '0.0' : txt);
                              });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomDivider(
                          color: seperator.withOpacity(.4),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Units Aquired',
                            style: CustomTextStyles(widget.dataObject.context)
                                .holdingValueStyle
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            focusNode: focusNode_1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            validator: (txt) {
                              if (txt.isEmpty || double.parse(txt) <= 0) {
                                return 'Quantity cannot be empty or lower than 0.';
                              } else {
                                return null;
                              }
                            },
                            style: CustomTextStyles(widget.dataObject.context)
                                .overallCurrencyStyle
                                .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: CustomTextStyles(widget.dataObject.context)
                                  .overallCurrencyStyle
                                  .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                              hintText: hintText_1,
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onChanged: (txt) {
                              setState(() {
                                quantity = double.parse(txt.isEmpty ? '0.0' : txt);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomDivider(
                      color: seperator.withOpacity(.4),
                    ),
                  ),
                  Text(
                    'Select Portfolio',
                    style: CustomTextStyles(widget.dataObject.context)
                        .holdingValueStyle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  widget.dataObject.portfolios.length > 0
                      ? DropdownButton<String>(
                          value: widget.dataObject.onPortfolio == null
                              ? widget.dataObject.portfolios.first.name
                              : widget.dataObject.onPortfolio.name,
                          items: List.generate(widget.dataObject.portfolios.length,
                              (index) => widget.dataObject.portfolios[index].name).map((String portfolio) {
                            return DropdownMenuItem<String>(
                              value: portfolio,
                              child: Text(
                                portfolio,
                                style: CustomTextStyles(context).portfolioNameStyle,
                              ),
                            );
                          }).toList(),
                          onChanged: (selected) => setState(() {
                            widget.dataObject.onPortfolio = widget.dataObject.portfolios
                                .firstWhere((portfolio) => portfolio.name == selected);

                            pName = selected;
                          }),
                        )
                      : Text(
                          noPortfolios,
                          style: CustomTextStyles(widget.dataObject.context)
                              .portfolioNameStyle
                              .copyWith(color: redVarient),
                          textAlign: TextAlign.center,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 20),
                    child: CWApplyButton(
                      addBlur: false,
                      isLinearGradient: true,
                      isBgColurOn: false,
                      customTextColour: summaryColour,
                      customTextStyle: CustomTextStyles(widget.dataObject.context)
                          .holdingValueStyle
                          .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
                      verticalPadding: 20,
                      addBorder: false,
                      isChange: (purchasePrice > 0 && quantity > 0),
                      function: () async {
                        if (_formKey.currentState.validate() && widget.dataObject.portfolios.length > 0) {
                          quoteResult.purchasePrice = purchasePrice;
                          quoteResult.quantity = quantity;

                          var duplicateCheck = widget.dataObject.onPortfolio.holdings
                              .firstWhere((holding) => holding.name == quoteResult.name, orElse: () => null);

                          if (duplicateCheck == null) {
                            widget.dataObject.onPortfolio.holdings.add(quoteResult);
                          } else {
                            widget.dataObject.onPortfolio.holdings.remove(duplicateCheck);
                            widget.dataObject.onPortfolio.holdings.add(quoteResult);
                          }

                          await DatabaseService(uid: widget.dataObject.user.uid)
                              .updateUserData(data: widget.dataObject);

                          widget.dataObject.lastCalenderUpdate = '';
                          widget.dataObject.dividends.clear();
                          widget.dataObject.earnings.clear();
                          await LocalDataSet().updateLocalData(widget.dataObject);

                          widget.dataObject.oldDoc = null;
                          Navigator.pop(context);

                          Navigator.push(
                              widget.dataObject.context,
                              CustomPageRouteSlideTransition(
                                  direction: AxisDirection.left,
                                  child: AdditionCompletedNotification(
                                    name: quoteResult.name,
                                    isStock: true,
                                    secondaryName: pName,
                                  )));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
