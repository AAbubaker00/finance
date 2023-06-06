import 'dart:convert';
import 'package:finance/models/user/user.dart';
import 'package:finance/pages/Initilize.dart';
import 'package:finance/services/database/database.dart';
import 'package:finance/services/yahooapi/yahoo_api_provider.dart';
import 'package:finance/shared/loading.dart';
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

  Future<bool> getStockData() async {
    selectedStock =
        await YahooApiService().getAllStockData(symbol: data['symbol'], exchange: data['exchange']);

    selectedStockSymbol = data['symbol'];
    selectedStockExchange = data['exch'];
    changes = data['changes'];
    stockName = selectedStock['quote']['longName'];
    modifiedPortfolios = data['portfolios'];

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    // loadData();

    return FutureBuilder<bool>(
      future: getStockData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text('data');
        } else {
          return Loading();
        }
      },
    );

  }
}
