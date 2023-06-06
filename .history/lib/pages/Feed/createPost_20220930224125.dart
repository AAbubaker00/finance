import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final DataObject dataObject;

  CreatePost({this.dataObject, Key key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: widget.dataObject,
      appbarColourOption: 2,
      appBarTitle: 'Create post',
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      body: CWListView(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Title cannot be left empty' : null,
                      onChanged: (txt) => setState(() => title = txt),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle
                              .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient))),
                  TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Post cannot be left empty' : null,
                      onChanged: (txt) => setState(() => description = txt),
                      decoration: InputDecoration(
                          hintText: 'Got something on your mind?',
                          hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .appBarTitleStyle
                              .copyWith(color: UserThemes(widget.dataObject.theme).textColorVarient))),


                               Padding(
                      padding: const EdgeInsets.all(15),
                      child: CWApplyButton(
                        addBlur: false,
                        isLinearGradient: true,
                        dataObject: widget.dataObject,
                        isBgColurOn: false,
                        // customColour: UserThemes(widget.dataObject.theme).blueVarient,
                        customTextColour: UserThemes(widget.dataObject.theme).summaryColour,
                        customTextStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .appBarTitleStyle
                            .copyWith(
                                letterSpacing: 1,
                                color: UserThemes(widget.dataObject.theme).summaryColour,
                                fontWeight: FontWeight.w600),
                        verticalPadding: 20,
                        addBorder: false,
                        isChange: purchasePrice != 0 && quantity != 0,
                        function: () async {
                          if (_formKey.currentState.validate() && isPortfolioSelected) {
                            // print('heee');

                            widget.dataObject.isUpdating = true;
                            widget.dataObject.lastCalenderUpdate = '';

                            for (var portfolio in widget.dataObject.portfolios) {
                              if (portfolio['name'] == selectedPortfolio) {
                                var isAssetTypeExist = portfolio['assets'].firstWhere(
                                    (assetType) => assetType['id'] == 'stocks',
                                    orElse: () => false);

                                if (isAssetTypeExist != false) {
                                  isAssetTypeExist['items'].forEach((holding) =>
                                      holding['marketData']['quote']['symbol'] ==
                                          instrument['quote']['symbol'] ??
                                      print(holding['symbol']));
                                  print(instrumentSymbol);

                                  var isHoldingExist = isAssetTypeExist['items'].firstWhere(
                                      (holding) =>
                                          holding['marketData']['quote']['symbol'] ==
                                          instrument['quote']['symbol'],
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
                                    // isHoldingExist['Invested'] = 0;
                                    // isHoldingExist['shares'] = 0;

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

                            Future.delayed(Duration(milliseconds: 300), () => Navigator.pop(context, true));

                            widget.dataObject.isUpdating = false;
                          }
                        },
                      ),
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
