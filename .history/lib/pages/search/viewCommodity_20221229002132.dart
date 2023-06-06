import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:Valuid/shared/update/initialise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewCommodity extends StatefulWidget {
  final DataObject dataObject;
  final Map commodity;
  final isView;

  ViewCommodity({Key key, this.dataObject, this.commodity, this.isView = false}) : super(key: key);

  @override
  State<ViewCommodity> createState() => _ViewCommodityState();
}

class _ViewCommodityState extends State<ViewCommodity> {
  Future<bool> initialiseCryptoData() async {
    instrument = widget.commodity;
    currencySymbol = Initialise(baseCurrency: 'USD').getCurrencySymbol()['symbol'];

    isDataLoaded = true;
    return Future.value(true);
  }

  Future<bool> preLoad() async {
    instrument = widget.dataObject.onHolding['marketData'];

    isDataLoaded = true;

    currencySymbol = Initialise(baseCurrency: 'USD').getCurrencySymbol()['symbol'];

    hintText_1 = widget.dataObject.onHolding['shares'].toString();
    hintText_0 = widget.dataObject.onHolding['avgPrice'].toString();

    pp = double.parse(hintText_0);
    q = double.parse(hintText_1);

    selectedPortfolio = widget.dataObject.onPortfolio['name'];
    isPortfolioSelected = true;

    getReturn();

    isDataLoaded = true;
    return Future.value(true);
  }

  getReturn() {
    instrumentReturn = ((instrument['rate']) - pp) * q;

    setState(() {});
  }

  double purchasePrice = 0, quantity = 0, instrumentReturn = 0.0, pp = 0.0, q = 0.0;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  Map instrument = {};

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
                  'Are you sure you want to delete ${instrument['id']} investment from ${widget.dataObject.onPortfolio['name']} portfolio?',
              function: () async {
                widget.dataObject.isUpdating = true;

                widget.dataObject.databaseData['portfolios']
                    .firstWhere((portfolio) => portfolio['name'] == selectedPortfolio)['assets']
                    .firstWhere((holdingType) => holdingType['id'] == 'commodities')['items']
                    .removeWhere((holding) => holding['symbol'] == instrument['symbol']);

                widget.dataObject.onPortfolio['assets']
                    .firstWhere((holdingType) => holdingType['id'] == 'commodities')['items']
                    .removeWhere((holding) => holding['symbol'] == instrument['symbol']);

                // isMainLoaded = false;
                final _auth = FirebaseAuth.instance;

                User currentUser = _auth.currentUser;

                // print(currentUser.uid);

                widget.dataObject.lastCalenderUpdate = '';

                DatabaseService(uid: currentUser.uid).updateChange(widget.dataObject);

                Navigator.pop(context);
                Navigator.pop(ctxt, true);

                widget.dataObject.isUpdating = false;
              },
            );
          });
    }

    return FutureBuilder(
        future: isDataLoaded
            ? Future.value(true)
            : widget.isView
                ? preLoad()
                : initialiseCryptoData(),
        builder: (context, snapshot) {
          if (isDataLoaded) {
            return CWScaffold(
              dataObject: widget.dataObject,
              appBarTitle: instrument['name'],
              isCenter: false,
              appbarColourOption: 2,
              scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
              bottomAppBarBorderColour: true,
              preferredSizeValue: 2.2,
              appBarBottomWidget: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$currencySymbol',
                            style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                .overallCurrencyStyle,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${instrument['rate'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                    .overallValueStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: Text(
                                  '${(instrument['rate'] - instrument['rate'].toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .overallCurrencyStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              appBarActions: [
                instrument['logo'] == null
                    ? Center(
                        child: Text(
                          "${instrument['symbol']}",
                          style: TextStyle(
                              color: UserThemes(widget.dataObject.theme).textColor,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(circularRadius),
                        child: Image.network(instrument['logo'],
                            errorBuilder: (context, error, stackTrace) => Center(
                                  child: Text(
                                    "${instrument['symbol']}",
                                    style: TextStyle(
                                        color: UserThemes(widget.dataObject.theme).textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                            height: 25, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                            width: 25, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                            fit: BoxFit.contain),
                      ),
              ],
              body: Form(
                key: _formKey,
                child: Container(
                  color: UserThemes(widget.dataObject.theme).summaryColour,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Purchase/Average price',
                                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .appBarTitleStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 15),
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
                                      .loginHeaderTextStyle,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true,
                                    hintStyle:
                                        CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                            .loginHeaderTextStyle
                                            .copyWith(
                                                color: UserThemes(widget.dataObject.theme)
                                                    .blueVarient
                                                    .withOpacity(.3)),
                                    hintText: hintText_0,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: UserThemes(widget.dataObject.theme).border)),
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
                                      .appBarTitleStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 15),
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
                                      .loginHeaderTextStyle,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true,
                                    hintStyle:
                                        CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                            .loginHeaderTextStyle
                                            .copyWith(
                                                color: UserThemes(widget.dataObject.theme)
                                                    .blueVarient
                                                    .withOpacity(.3)),
                                    hintText: hintText_1,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  onChanged: (txt) {
                                    // print(txt);
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Designated portfolio',
                                  style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .appBarTitleStyle
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: CWApplyButton(
                                addBlur: false,
                                isLinearGradient: true,
                                dataObject: widget.dataObject,
                                isBgColurOn: false,
                                customColour: UserThemes(widget.dataObject.theme).blueVarient,
                                customTextColour: UserThemes(widget.dataObject.theme).summaryColour,
                                customTextStyle:
                                    CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                        .appBarTitleStyle
                                        .copyWith(
                                            letterSpacing: 1,
                                            color: UserThemes(widget.dataObject.theme).summaryColour,
                                            fontWeight: FontWeight.w600),
                                verticalPadding: 20,
                                addBorder: false,
                                function: () async {
                                  if (_formKey.currentState.validate() && isPortfolioSelected) {
                                    // print('heee');

                                    widget.dataObject.isUpdating = true;

                                    //   var _databaseCurrentPortfolio = widget.dataObject.databaseData['portfolios']
                                    //       .firstWhere((portfolio) => portfolio['name'] == widget.dataObject.onPortfolio['name']);

                                    //  var _databaseCurrentHolding =  _databaseCurrentPortfolio['assets']
                                    //       .firstWhere((assetType) => assetType['id'] == 'cryptos').firstWhere((holding) => holding['symbol'] == widget.dataObject.onHolding['']);

                                    for (var portfolio in widget.dataObject.portfolios) {
                                      if (portfolio['name'] == selectedPortfolio) {
                                        var isAssetTypeExist = portfolio['assets'].firstWhere(
                                            (assetType) => assetType['id'] == 'commodities',
                                            orElse: () => false);

                                        if (isAssetTypeExist != false) {
                                          var isHoldingExist = isAssetTypeExist['items'].firstWhere(
                                              (holding) => holding['symbol'] == instrument['symbol'],
                                              orElse: () => null);

                                          PrintFunctions().printStartEndLine(isHoldingExist);

                                          if (isHoldingExist == null) {
                                            isAssetTypeExist['items'].add({
                                              'Invested': purchasePrice * quantity,
                                              'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                              'shares': quantity,
                                              'value': 0.0,
                                              'buyPrice': purchasePrice,
                                              'avgPrice': purchasePrice,
                                              'symbol': instrument,
                                              'name': instrument['name'],
                                              'change': 0.0,
                                              'percDiff': 0.0,
                                              'history': [],
                                              'marketData': instrument
                                            });

                                            for (var database_data_portfolio
                                                in widget.dataObject.databaseData['portfolios']) {
                                              if (database_data_portfolio['name'] == selectedPortfolio) {
                                                var isAssetTypeExist = database_data_portfolio['assets']
                                                    .firstWhere(
                                                        (assetType) => assetType['id'] == 'commodities',
                                                        orElse: () => false);

                                                isAssetTypeExist['items'].add({
                                                  'Invested': purchasePrice * quantity,
                                                  'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                                  'shares': quantity,
                                                  'buyPrice': purchasePrice,
                                                  'avgPrice': purchasePrice,
                                                  'symbol': instrument['symbol'],
                                                  'name': instrument['name'],
                                                  'history': [],
                                                });
                                              }
                                            }
                                          } else {
                                            // isHoldingExist['Invested'] = 0;
                                            // isHoldingExist['shares'] = 0;

                                            for (var database_data_portfolio
                                                in widget.dataObject.databaseData['portfolios']) {
                                              if (database_data_portfolio['name'] == selectedPortfolio) {
                                                for (var database_holding in database_data_portfolio['assets']
                                                    .firstWhere((holdingType) =>
                                                        holdingType['id'] == 'commodities')['items']) {
                                                  if (database_holding['symbol'] ==
                                                      isHoldingExist['symbol']) {
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
                                                'id': 'commodities',
                                                'items': [
                                                  {
                                                    'Invested': purchasePrice * quantity,
                                                    'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                                    'shares': quantity,
                                                    'buyPrice': purchasePrice,
                                                    'avgPrice': purchasePrice,
                                                    'symbol': instrument['symbol'],
                                                    'name': instrument['name'],
                                                    'history': [],
                                                  }
                                                ]
                                              });

                                              portfolio['assets'].add({
                                                'id': 'commodities',
                                                'items': [
                                                  {
                                                    'Invested': purchasePrice * quantity,
                                                    'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                                    'shares': quantity,
                                                    'buyPrice': purchasePrice,
                                                    'avgPrice': purchasePrice,
                                                    'symbol': instrument['symbol'],
                                                    'name': instrument['name'],
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

                                    // widget.dataObject.lastCalenderUpdate = '';

                                    DatabaseService().updateChange(widget.dataObject);

                                    Future.delayed(
                                        Duration(milliseconds: 300), () => Navigator.pop(context, true));

                                    widget.dataObject.isUpdating = false;
                                  }
                                },
                              ),
                            ),
                            widget.isView
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: CWApplyButton(
                                      isBgColurOn: false,
                                      dataObject: widget.dataObject,
                                      customColour: UserThemes(widget.dataObject.theme).backgroundColour,
                                      customTextColour: UserThemes(widget.dataObject.theme).textColorVarient,
                                      function: () => _showDeleteHoldingConfirmPanel(),
                                      btnText: '',
                                      verticalPadding: 12,
                                      borderRadius: BorderRadius.circular(50),
                                      addBorder: true,
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 2),
                                        child: ClipRRect(
                                            child: Image.asset(
                                          'assets/icons/bin.png',
                                          width: 25,
                                          height: 25,
                                          color: UserThemes(widget.dataObject.theme).textColorVarient,
                                        )),
                                      ),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading(
              theme: widget.dataObject.theme,
            );
          }
        });
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
        child: Text(
          selectedPortfolio,
          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
              .appBarTitleStyle
              .copyWith(
                  color: isPortfolioSelected
                      ? UserThemes(widget.dataObject.theme).textColor
                      : UserThemes(widget.dataObject.theme).redVarient),
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
