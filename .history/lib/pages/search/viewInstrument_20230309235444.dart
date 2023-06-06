import 'dart:ui';

import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:Valuid/shared/update/initialise.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Valuid/extensions/stringExt.dart';

import 'package:Valuid/shared/themes/themes.dart';

class ViewInstrument extends StatefulWidget {
  final DataObject dataObject;
  final bool isView;
  final bool isCrypto;

  final String symbol;
  final String exch;

  final var holding;

  const ViewInstrument(
      {Key key, this.dataObject, this.isView = false, this.symbol, this.exch, this.isCrypto = false, this.holding})
      : super(key: key);
  @override
  _ViewInstrument createState() => _ViewInstrument();
}

class _ViewInstrument extends State<ViewInstrument> {
  Future<bool> initializeData() async {
    instrument = await YahooApiService().getAllAssetData(symbol: widget.symbol, exchange: widget.exch);

    if (instrument.isEmpty) {
      Navigator.pop(context);

      CustomeBottomSheet()
          .underDevelopment(context, widget.dataObject.theme, text: 'This instrument is not supported yet.');

      return Future.value(false);
    } else {
      currencySymbol =
          Initialise(baseCurrency: instrument['quote']['currency']).getCurrencySymbol()['symbol'];

      instrumentSymbol = instrument['quote']['symbol'];
      instrumentExchange = instrument['quote']['exchange'];
      instrumentName = instrument['quote']['shortName'];

      isDataLoaded = true;

      // instrument = await GetIcons().getEodIcon(instrument,
      //     symbol: instrument['quote']['symbol'], exchange: instrument['quote']['fullExchangeName']);

      // if (instrument['logo'] == null) {
      //   instrument = await GetIcons().getClearBitIcon(instrument,
      //       symbol: instrument['quote']['symbol'], exchange: instrument['quote']['fullExchangeName']);
      // }

      setState(() {});

      return Future.value(true);
    }
  }

  Future<bool> preLoaded() async {
    isDataLoaded = true;

    currencySymbol = Initialise(baseCurrency: instrument['quote']['currency']).getCurrencySymbol()['symbol'];

    instrumentSymbol = instrument['quote']['symbol'];
    instrumentExchange = instrument['quote']['exchange'];
    instrumentName = instrument['quote']['shortName'];

    hintText_1 = widget.dataObject.onHolding['shares'].toStringAsFixed(2);
    hintText_0 = widget.dataObject.onHolding['avgPrice'].toStringAsFixed(2);

    pp = double.parse(hintText_0);
    q = double.parse(hintText_1);

    selectedPortfolio = widget.dataObject.onPortfolio['name'];
    isPortfolioSelected = true;

    getReturn();

    return Future.value(true);
  }

  getReturn() {
    instrumentReturn =
        ((instrument['quote']['regularMarketPrice'] / (instrumentExchange == 'LSE' ? 100 : 1)) - pp) * q;

    setState(() {});
  }

  double purchasePrice = 0, quantity = 0, instrumentReturn = 0.0, pp = 0.0, q = 0.0;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  Map instrument = {};

  String instrumentSymbol;
  String instrumentExchange;
  String instrumentName = '';
  String currencySymbol = '';

  bool isDataLoaded = false, isPortfolioSelected = false;

  String selectedPortfolio = 'Select Portfolio', hintText_0 = '0', hintText_1 = '0';

  @override
  Widget build(BuildContext context) {
    void _showDeleteHoldingConfirmPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) {
            return CWConfirmBottomSheetButton(
              dataObject: widget.dataObject,
              context: ctxt,
              btnText:
                  'Are you sure you want to delete ${instrument['quote'].containsKey('longName') ? instrument['quote']['longName'] : instrument['quote']['shortName']} investment from ${widget.dataObject.onPortfolio['name']} portfolio?',
              function: () async {
                widget.dataObject.databaseData['portfolios']
                    .firstWhere((portfolio) => portfolio['name'] == selectedPortfolio)['assets']
                    .firstWhere((holdingType) => holdingType['id'] == 'stocks')['items']
                    .removeWhere((holding) => holding['symbol'] == instrumentSymbol);

                widget.dataObject.onPortfolio['assets']
                    .firstWhere((holdingType) => holdingType['id'] == 'stocks')['items']
                    .removeWhere((holding) => holding['symbol'] == instrumentSymbol);

                widget.dataObject.lastCalenderUpdate = '';

                DatabaseService(uid: widget.dataObject.userFire.uid).updateChange(widget.dataObject);

                Navigator.pop(context);
                Navigator.pop(ctxt, true);
              },
            );
          });
    }

    return FutureBuilder<bool>(
      future: isDataLoaded
          ? Future.value(true)
          : widget.isView
              ? preLoaded()
              : initializeData(),
      builder: (context, snapshot) {
        if (isDataLoaded) {
          return CWScaffold(
            dataObject: widget.dataObject,
            isCenter: false,
            scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
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
                              '$currencySymbol',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                  .overallCurrencyStyle,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                instrumentExchange == 'LSE'
                                    ? '${(instrument['quote']['regularMarketPrice'] / 100).toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                    : '${instrument['quote']['regularMarketPrice'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                    .overallValueStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0, left: 1),
                                child: Text(
                                  instrumentExchange == 'LSE'
                                      ? '${(double.parse((instrument['quote']['regularMarketPrice'] / 100).toStringAsFixed(2)) - (double.parse((instrument['quote']['regularMarketPrice'] / 100).toStringAsFixed(2))).toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}'
                                      : '${(instrument['quote']['regularMarketPrice'] - instrument['quote']['regularMarketPrice'].toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .overallCurrencyStyle,
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
                            (instrument['quote']['regularMarketChange'] >= 0)
                                ? '+$currencySymbol${instrument['quote']['regularMarketChange'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(instrument['quote']['regularMarketChangePercent']).toStringAsFixed(2)}%)'
                                : '-$currencySymbol${(instrument['quote']['regularMarketChange'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(instrument['quote']['regularMarketChangePercent']).toStringAsFixed(2)}%)',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: (instrument['quote']['regularMarketChange'] > 0)
                                    ? UserThemes(widget.dataObject.theme).greenVarient
                                    : UserThemes(widget.dataObject.theme).redVarient)),
                        Text(' DAILY',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .tableHeaderStyle),
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
                    child: Text(
                        instrument['quote'].containsKey('longName')
                            ? instrument['quote']['longName'].toString().removeStr()
                            : instrument['quote']['shortName'].toString().removeStr(),
                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .appBarTitleStyle),
                  ),
                  widget.isView
                      ? InkWell(
                          borderRadius: BorderRadius.circular(buttonRadius),
                          onTap: () => _showDeleteHoldingConfirmPanel(),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                                child: Image.asset(
                              'assets/icons/bin.png',
                              width: iconSize,
                              height: iconSize,
                              color: UserThemes(widget.dataObject.theme).iconColour,
                            )),
                          ),
                        )
                      : Container()
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
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
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
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .overallCurrencyStyle
                                .copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: UserThemes(widget.dataObject.theme).blueVarient),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                  .overallCurrencyStyle
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.3)),
                              hintText: hintText_0,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onChanged: (txt) {
                              purchasePrice = double.parse(txt.isEmpty ? '0.0' : txt);
                              pp = double.parse(txt.isEmpty ? '0.0' : txt);
                              getReturn();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomDivider(
                          dataObject: widget.dataObject,
                          color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.4),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Aquired shares',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
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
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .overallCurrencyStyle
                                .copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: UserThemes(widget.dataObject.theme).blueVarient),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                  .overallCurrencyStyle
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.3)),
                              hintText: hintText_1,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onChanged: (txt) {
                              quantity = double.parse(txt.isEmpty ? '0.0' : txt);
                              q = double.parse(txt.isEmpty ? '0.0' : txt);
                              getReturn();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomDivider(
                          dataObject: widget.dataObject,
                          color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.4),
                        ),
                      ),
                      //  widget.isView?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Designated portfolio',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .holdingValueStyle
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          _sortPopupMenu(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomDivider(
                          dataObject: widget.dataObject,
                          color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.4),
                        ),
                      ),
                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(
                          'EARNINGS',
                          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .holdingSubValueStyle,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '$currencySymbol${instrumentReturn.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .portfolioNameStyle
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: instrumentReturn >= 0
                                      ? UserThemes(widget.dataObject.theme).greenVarient
                                      : UserThemes(widget.dataObject.theme).redVarient),
                        ),
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 20),
                    child: CWApplyButton(
                      addBlur: false,
                      isLinearGradient: true,
                      dataObject: widget.dataObject,
                      isBgColurOn: false,
                      customTextColour: UserThemes(widget.dataObject.theme).summaryColour,
                      customTextStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                          .holdingValueStyle
                          .copyWith(
                              letterSpacing: 1,
                              color: UserThemes(widget.dataObject.theme).summaryColour,
                              fontWeight: FontWeight.w600),
                      verticalPadding: 20,
                      addBorder: false,
                      isChange: purchasePrice != 0 && quantity != 0,
                      function: () async {
                        if (_formKey.currentState.validate() && isPortfolioSelected) {
                          widget.dataObject.lastCalenderUpdate = '';

                          for (var portfolio in widget.dataObject.portfolios) {
                            if (portfolio['name'] == selectedPortfolio) {
                              var isAssetTypeExist = portfolio['assets'].firstWhere(
                                  (assetType) => assetType['id'] == 'stocks',
                                  orElse: () => false);

                              if (isAssetTypeExist != false) {
                                var isHoldingExist = isAssetTypeExist['items'].firstWhere(
                                    (holding) =>
                                        holding['marketData']['quote']['symbol'] ==
                                        instrument['quote']['symbol'],
                                    orElse: () => null);

                                // PrintFunctions().printStartEndLine(isHoldingExist);

                                if (isHoldingExist == null) {
                                  isAssetTypeExist['items'].add({
                                    'Invested': purchasePrice * quantity,
                                    'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                    'shares': quantity,
                                    'value': 0.0,
                                    'buyPrice': purchasePrice,
                                    'avgPrice': purchasePrice,
                                    'symbol': instrumentSymbol,
                                    'change': 0.0,
                                    'typeId': 'stocks',
                                    'percDiff': 0.0,
                                    'exchange': instrumentExchange,
                                    'history': [],
                                    'marketData': instrument
                                  });

                                  for (var database_data_portfolio
                                      in widget.dataObject.databaseData['portfolios']) {
                                    if (database_data_portfolio['name'] == selectedPortfolio) {
                                      var isAssetTypeExist = database_data_portfolio['assets'].firstWhere(
                                          (assetType) => assetType['id'] == 'stocks',
                                          orElse: () => false);

                                      isAssetTypeExist['items'].add({
                                        'Invested': purchasePrice * quantity,
                                        'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                        'shares': quantity,
                                        'buyPrice': purchasePrice,
                                        'avgPrice': purchasePrice,
                                        'symbol': instrumentSymbol,
                                        'exchange': instrumentExchange,
                                        'history': [],
                                      });
                                    }
                                  }
                                } else {
                                  for (var database_data_portfolio
                                      in widget.dataObject.databaseData['portfolios']) {
                                    if (database_data_portfolio['name'] == selectedPortfolio) {
                                      for (var database_holding in database_data_portfolio['assets']
                                          .firstWhere(
                                              (holdingType) => holdingType['id'] == 'stocks')['items']) {
                                        if (database_holding['symbol'] == isHoldingExist['symbol']) {
                                          database_holding['Invested'] = quantity * purchasePrice;
                                          database_holding['shares'] = quantity;

                                          isHoldingExist['avgPrice'] = purchasePrice;
                                          database_holding['avgPrice'] = purchasePrice;

                                          isHoldingExist['shares'] = quantity;
                                          database_holding['shares'] = quantity;

                                          database_holding['Invested'] = quantity * purchasePrice;
                                          database_holding['history'] = [];
                                        }
                                      }
                                    }
                                  }
                                }
                              } else {
                                for (var database_data_portfolio
                                    in widget.dataObject.databaseData['portfolios']) {
                                  if (database_data_portfolio['name'] == portfolio['name']) {
                                    database_data_portfolio['assets'].add({
                                      'id': 'stocks',
                                      'items': [
                                        {
                                          'Invested': purchasePrice * quantity,
                                          'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                          'shares': quantity,
                                          'buyPrice': purchasePrice,
                                          'avgPrice': purchasePrice,
                                          'symbol': instrumentSymbol,
                                          'exchange': instrumentExchange,
                                          'history': [],
                                        }
                                      ]
                                    });

                                    portfolio['assets'].add({
                                      'id': 'stocks',
                                      'items': [
                                        {
                                          'Invested': purchasePrice * quantity,
                                          'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                          'shares': quantity,
                                          'value': 0.0,
                                          'buyPrice': purchasePrice,
                                          'typeId': 'stocks',
                                          'avgPrice': purchasePrice,
                                          'symbol': instrumentSymbol,
                                          'change': 0.0,
                                          'percDiff': 0.0,
                                          'exchange': instrumentExchange,
                                          'history': [],
                                          'marketData': instrument
                                        }
                                      ]
                                    });
                                  }
                                }
                              }
                            }
                          }

                          DatabaseService().updateChange(widget.dataObject);

                          Navigator.pop(context, true);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading(
            theme: widget.dataObject.theme,
          );
        }
      },
    );
  }

  Widget _sortPopupMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
        color: UserThemes(widget.dataObject.theme).backgroundColour,
        elevation: 8,
        offset: Offset(0, 30),
        onSelected: (option) {
          setState(() {
            isPortfolioSelected = true;
            selectedPortfolio = option['name'];
          });
        },
        enabled: !widget.isView,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            selectedPortfolio,
            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                .portfolioNameStyle
                .copyWith(
                    color: isPortfolioSelected
                        ? UserThemes(widget.dataObject.theme).textColor
                        : UserThemes(widget.dataObject.theme).redVarient),
          ),
        ),
        itemBuilder: (context) => widget.dataObject.portfolios.map<PopupMenuItem<Map>>((option) {
          return PopupMenuItem(
            value: option,
            child: Text(
              option['name'],
              style: TextStyle(
                  color: selectedPortfolio == option['name']
                      ? UserThemes(widget.dataObject.theme).textColor
                      : UserThemes(widget.dataObject.theme).textColorVarient,
                  fontWeight: selectedPortfolio == option['name'] ? FontWeight.w600 : FontWeight.w400),
            ),
          );
        }).toList(),
      );
}
