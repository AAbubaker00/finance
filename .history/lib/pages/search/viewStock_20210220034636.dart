import 'dart:convert';
import 'package:finance/models/user/user.dart';
import 'package:finance/pages/Initilize.dart';
import 'package:finance/services/database/database.dart';
import 'package:finance/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finance/shared/themes.dart';
import 'package:intl/intl.dart';

class ViewStock extends StatefulWidget {
  ViewStock({Key key}) : super(key: key);

  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  DateTime _selectedDate = DateTime.now();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  refresh() {
    setState(() {});
  }

  List changes = [];

  //Method for showing the date picker
  void _pickDateDialog(Function sState) {
    showDatePicker(
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    surface: Colors.transparent,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child,
              );
            },
            context: context,
            initialDate: _selectedDate,
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime.now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      } else {
        _selectedDate = pickedDate;

        sState(() {});
      }
    });
  }

  Map data = {};
  List displayedData = [];
  List modifiedPortfolios = [];
  List newPortfolio = [];

  Map dashaboardData;
  Map selectedStock = {};
  Map initData = {};

  FocusNode focusNode_0 = FocusNode();
  FocusNode focusNode_1 = FocusNode();

  double purchasePrice;
  double quantity;

  String selectedStockSymbol;
  String selectedStockExchange;
  String hintText_0 = '0';
  String hintText_1 = '0';
  String stockName = '';

  bool isDataChange = false;
  bool isPortfolioSelected = false;
  bool isDateError = false, isSharesError = false, isBuyPriceError = false, isAddNewPortfolio = false;

  TextStyle tickerSubTextStyle;
  TextStyle tickerHeadTextStyle;

  loadData() {
    setState(() {
      selectedStock = data['stock'];
      selectedStockSymbol = data['symbol'];
      selectedStockExchange = data['exch'];
      changes = data['changes'];
      stockName = selectedStock['quote']['longName'];
      modifiedPortfolios = data['portfolios'];
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    loadData();

    return Container(
      color: DarkTheme().backgroundColour,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: DarkTheme().backgroundColour,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight * .8),
              child: AppBar(
                backgroundColor: DarkTheme().backgroundColour,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  stockName,
                  style: TextStyle(color: DarkTheme().textColorVarient),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (DateFormat('EEEE').format(_selectedDate) == 'Sunday' ||
                            DateFormat('EEEE').format(_selectedDate) == 'Saturday' ||
                            selectedStock['chartData']['max']['timestamp'].firstWhere(
                                    (date) => date == DateFormat('yyyy-MM-dd').format(_selectedDate),
                                    orElse: () => null) ==
                                null) {
                          setState(() {
                            isDateError = true;
                          });
                        } else {
                          isDateError = false;

                          if (isAddNewPortfolio) {
                            /* -------------------------------------------------------------------------- */
/*                           Creating New Portfolio                           */
/* -------------------------------------------------------------------------- */

/* --------------------- checking if stock already exits -------------------- */

                            if (newPortfolio[0]['isSelected']) {
                              isPortfolioSelected = true;
                              if (newPortfolio[0]['stocks'].isEmpty) {
                                newPortfolio[0]['stocks'].add({
                                  'Invested': quantity * purchasePrice,
                                  'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                  'buyPrice': purchasePrice,
                                  'exchange': selectedStockExchange,
                                  'symbol': selectedStockSymbol,
                                  'shares': quantity,
                                  'history': [
                                    {
                                      'type': 'Market Buy',
                                      'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                      'filledQuantity': quantity,
                                      'fillPrice': purchasePrice,
                                      'totalShares': quantity,
                                      'averagePrice': purchasePrice,
                                    }
                                  ]
                                });
                              } else {
                                Map isStockExist = newPortfolio[0]['stocks'].map(
                                    (stock) => stock['symbol'] == selectedStockSymbol,
                                    orElse: () => null);

                                if (isStockExist == null) {
                                  newPortfolio[0]['stocks'].add({
                                    'Invested': quantity * purchasePrice,
                                    'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                    'buyPrice': purchasePrice,
                                    'exchange': selectedStockExchange,
                                    'symbol': selectedStockSymbol,
                                    'shares': quantity,
                                    'history': [
                                      {
                                        'type': 'Market Buy',
                                        'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                        'filledQuantity': quantity,
                                        'fillPrice': purchasePrice,
                                        'totalShares': quantity,
                                        'averagePrice': purchasePrice,
                                      }
                                    ]
                                  });
                                } else {
                                  newPortfolio[0]['stocks'].forEach((stock) {
                                    if (stock['symbol'] == selectedStockSymbol) {
                                      stock['Invested'] += quantity * purchasePrice;
                                      stock['shares'] += quantity;
                                      stock['history'].add({
                                        'type': 'Market Buy',
                                        'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                        'filledQuantity': quantity,
                                        'fillPrice': purchasePrice,
                                        'totalShares': quantity,
                                        'averagePrice': purchasePrice,
                                      });
                                    }
                                  });
                                }
                              }

                              isDataChange = true;
                              Navigator.pop(context);
                            } else {
                              isPortfolioSelected = false;
                              print('select a portfolio');
                            }
                          } else {
                            isPortfolioSelected = false;
                            

                            if (_formKey.currentState.validate()) {
                              modifiedPortfolios.forEach((portfolio) {
                                if (portfolio['isSelected']) {
                                  isPortfolioSelected = true;

                                  if (portfolio['stocks'].isNotEmpty) {
                                    print(portfolio['name']);

                                    var preStock = portfolio['stocks']
                                        .firstWhere((stock) => stock['symbol'] == selectedStockSymbol);

                                    if (preStock == null) {
                                      print('yee');
                                    }
                                  }
                                }
                              });
                            }

                            // if (_formKey.currentState.validate()) {
                            //   for (Map portfolio in modifiedPortfolios) {
                            //     if (portfolio['isSelected']) {
                            //       print(portfolio['name']);

                            //       isPortfolioSelected = true;

                            //       if (!portfolio['stocks'].isEmpty) {
                            //         Map isStockExist = portfolio['stocks'].firstWhere(
                            //             (stock) => stock['symbol'].toString() == selectedStockSymbol,
                            //             orElse: () => null);

                            //         // print(isStockExist);

                            //         if (isStockExist == null) {
                            //           dashaboardData['initalData']['portfolios']
                            //                   [dashaboardData['portfolios'].indexOf(portfolio)]['stocks']
                            //               .add({
                            //             'Invested': quantity * purchasePrice,
                            //             'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //             'buyPrice': purchasePrice,
                            //             'exchange': selectedStockExchange,
                            //             'symbol': selectedStockSymbol,
                            //             'shares': quantity,
                            //             'history': [
                            //               {
                            //                 'type': 'Market Buy',
                            //                 'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //                 'filledQuantity': quantity,
                            //                 'fillPrice': purchasePrice,
                            //                 'totalShares': quantity,
                            //                 'averagePrice': purchasePrice,
                            //               }
                            //             ]
                            //           });

                            //           dashaboardData['portfolios']
                            //                   [dashaboardData['portfolios'].indexOf(portfolio)]['stocks']
                            //               .add({
                            //             'Invested': quantity * purchasePrice,
                            //             'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //             'buyPrice': purchasePrice,
                            //             'exchange': selectedStockExchange,
                            //             'symbol': selectedStockSymbol,
                            //             'shares': quantity,
                            //             'history': [
                            //               {
                            //                 'type': 'Market Buy',
                            //                 'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //                 'filledQuantity': quantity,
                            //                 'fillPrice': purchasePrice,
                            //                 'totalShares': quantity,
                            //                 'averagePrice': purchasePrice,
                            //               }
                            //             ],
                            //             'marketData': selectedStock
                            //           });
                            //         } else {
                            //           dashaboardData['initalData']['portfolios']
                            //                   [dashaboardData['portfolios'].indexOf(portfolio)]['stocks']
                            //               .forEach((stock) {
                            //             if (stock['symbol'] == isStockExist['symbol']) {
                            //               stock['shares'] =
                            //                   double.parse(stock['shares'].toString()) + quantity;
                            //               stock['Invested'] = double.parse(stock['Invested'].toString()) +
                            //                   (purchasePrice * quantity);
                            //               stock['history'].add({
                            //                 [
                            //                   {
                            //                     'type': 'Market Buy',
                            //                     'filledOn':
                            //                         DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //                     'filledQuantity': quantity,
                            //                     'fillPrice': purchasePrice,
                            //                     'totalShares': quantity,
                            //                     'averagePrice': purchasePrice,
                            //                   }
                            //                 ]
                            //               });
                            //             }
                            //           });

                            //           portfolio['stocks'].forEach((stock) {
                            //             if (stock['symbol'] == isStockExist['symbol']) {
                            //               stock['shares'] =
                            //                   double.parse(stock['shares'].toString()) + quantity;
                            //               stock['Invested'] =
                            //                   stock['Invested'] + (purchasePrice * quantity);
                            //               stock['history'].add({
                            //                 [
                            //                   {
                            //                     'type': 'Market Buy',
                            //                     'filledOn':
                            //                         DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //                     'filledQuantity': quantity,
                            //                     'fillPrice': purchasePrice,
                            //                     'totalShares': quantity,
                            //                     'averagePrice': purchasePrice,
                            //                   }
                            //                 ]
                            //               });
                            //             }
                            //           });

                            //           // isStockExist['']
                            //         }
                            //       } else {
                            //         portfolio['stocks'].add({
                            //           'Invested': quantity * purchasePrice,
                            //           'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //           'buyPrice': purchasePrice,
                            //           'exchange': selectedStockExchange,
                            //           'symbol': selectedStockSymbol,
                            //           'shares': quantity,
                            //           'history': [
                            //             {
                            //               'type': 'Market Buy',
                            //               'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //               'filledQuantity': quantity,
                            //               'fillPrice': purchasePrice,
                            //               'totalShares': quantity,
                            //               'averagePrice': purchasePrice,
                            //             }
                            //           ]
                            //         });

                            //         dashaboardData['initalData']['portfolios'].add({
                            //           'baseCurrency': portfolio['baseCurrency'],
                            //           'name': portfolio['name'],
                            //           'totalStocks': 1,
                            //           'totalShares': 0,
                            //           'stocks': [
                            //             {
                            //               'Invested': quantity * purchasePrice,
                            //               'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //               'buyPrice': purchasePrice,
                            //               'exchange': selectedStockExchange,
                            //               'symbol': selectedStockSymbol,
                            //               'shares': quantity,
                            //               'history': [
                            //                 {
                            //                   'type': 'Market Buy',
                            //                   'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            //                   'filledQuantity': quantity,
                            //                   'fillPrice': purchasePrice,
                            //                   'totalShares': quantity,
                            //                   'averagePrice': purchasePrice,
                            //                 }
                            //               ]
                            //             }
                            //           ]
                            //         });
                            //       }

                            //       isDataChange = true;
                            //       Navigator.pop(context);
                            //     } else {
                            //       // print('selected A portfolio');
                            //     }
                            //   }
                            // }
                          }
                        }

                        // print(dashaboardData['initalData']['portfolios'][0]['stocks']);
                        // print(dashaboardData['portfolios']['stocks'].last);
                      },
                      icon: Text(
                        'ADD',
                        style: TextStyle(
                            color: DarkTheme().goldVarient, fontWeight: FontWeight.w400, fontSize: 16),
                      )),
                ],
              ),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${selectedStock['quote']['symbol']} ',
                            style:
                                TextStyle(color: DarkTheme().textColorVarient, fontWeight: FontWeight.w400)),
                        Icon(
                          Icons.circle,
                          size: 5,
                          color: DarkTheme().iconColour,
                        ),
                        Text(' ${selectedStock['quote']['market'].toString()} ',
                            style:
                                TextStyle(color: DarkTheme().textColorVarient, fontWeight: FontWeight.w400)),
                        Icon(
                          Icons.circle,
                          size: 5,
                          color: DarkTheme().iconColour,
                        ),
                        Text(' ${selectedStock['quote']['fullExchangeName']}',
                            style:
                                TextStyle(color: DarkTheme().textColorVarient, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(selectedStock['quote']['currency'],
                              style: TextStyle(color: DarkTheme().textColor, fontWeight: FontWeight.w100)),
                          Text(selectedStock['quote']['regularMarketPrice'].toString(),
                              style: TextStyle(
                                  color: DarkTheme().textColor, fontSize: 50, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  color: DarkTheme().insideColour,
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: Column(
                    children: [
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Purchase or Sell Price',
                                style: TextStyle(color: DarkTheme().textColorVarient, fontSize: 20),
                              ),
                              TextFormField(
                                validator: (txt) {
                                  setState(() {
                                    if (txt.isEmpty || double.parse(txt) <= 0) {
                                      isBuyPriceError = true;
                                      return null;
                                    } else {
                                      isBuyPriceError = false;
                                      return null;
                                    }
                                  });

                                  return null;
                                },
                                focusNode: focusNode_0,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: 50,
                                    color: DarkTheme().blueVarient,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: DarkTheme().blueVarient, fontWeight: FontWeight.w300),
                                  hintText: hintText_0,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onChanged: (txt) {
                                  setState(() => purchasePrice = double.parse(txt.toString()));
                                },
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Purchase Price must not be empty or lower than 1',
                                  style: TextStyle(
                                      color: isBuyPriceError ? DarkTheme().redVarient : Colors.transparent),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    color: DarkTheme().backgroundColour,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Enter the purchase or sell price of a single order or the Avg purchase or Sell price of multiple orders',
                                    style: TextStyle(
                                        color: DarkTheme().textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Number of Shares',
                                style: TextStyle(color: DarkTheme().textColorVarient, fontSize: 20),
                              ),
                              TextFormField(
                                validator: (txt) {
                                  setState(() {
                                    if (txt.isEmpty || double.parse(txt) <= 0) {
                                      isSharesError = true;
                                      return null;
                                    } else {
                                      isSharesError = false;
                                      return null;
                                    }
                                  });

                                  return null;
                                },
                                focusNode: focusNode_1,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: 50,
                                    color: DarkTheme().blueVarient,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: DarkTheme().blueVarient, fontWeight: FontWeight.w300),
                                  hintText: hintText_1,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onChanged: (txt) {
                                  setState(() => quantity = double.parse(txt.toString()));
                                },
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Share quanity must not be empty or less than 1',
                                  style: TextStyle(
                                      color: isSharesError ? DarkTheme().redVarient : Colors.transparent),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                // height: MediaQuery.of(context).size.height*0.06,
                                decoration: BoxDecoration(
                                    color: DarkTheme().backgroundColour,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Enter the total shares purchased or sold in a single or multiple orders ',
                                    style: TextStyle(
                                        color: DarkTheme().textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Purchase Date',
                                style: TextStyle(
                                    color: DarkTheme().textColorVarient,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    _pickDateDialog(setState);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.045,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: Colors.grey[600])),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                            style: TextStyle(
                                                color: DarkTheme().textColor, fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Market is Closed on the selected date',
                                  style: TextStyle(
                                      color: isDateError ? DarkTheme().redVarient : Colors.transparent),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Select Portfolio',
                                  style: TextStyle(
                                      color: DarkTheme().textColorVarient,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10, left: 1),
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: Center(
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: (isAddNewPortfolio ? newPortfolio : modifiedPortfolios)
                                        .map<Widget>((p) {
                                      return InkWell(
                                        onTap: () {

                                          setState(() => p['isSelected'] = !p['isSelected']);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(right: 5),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: p['isSelected']
                                                        ? DarkTheme().goldVarient
                                                        : DarkTheme().iconColour)),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  isAddNewPortfolio ? p['name'] : p['name'],
                                                  style: TextStyle(
                                                      color: DarkTheme().textColor,
                                                      fontWeight: FontWeight.w200),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                                Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Select Portfolio',
                                  style: TextStyle(
                                      color: isPortfolioSelected ? DarkTheme().redVarient : Colors.transparent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
