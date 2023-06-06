import 'dart:ui';

import 'package:Strice/services/clearbit/clearbit.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:Strice/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'package:Strice/shared/update/marketUpdate.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

class GetInstrument extends StatefulWidget {
  GetInstrument({Key key}) : super(key: key);

  @override
  _GetInstrument createState() => _GetInstrument();
}

class _GetInstrument extends State<GetInstrument> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() => setRatio();

  getPrice() {
    _selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(_selectedDate));

    var dateExist = selectedStock['chartData']['max']['timestamp']
        .firstWhere((date) => DateTime.parse(date) == _selectedDate, orElse: () => null);

    if (dateExist != null) {
      priceAtDate = selectedStock['chartData']['max']['close']
          [selectedStock['chartData']['max']['timestamp'].indexOf(dateExist)];
    } else {
      priceAtDate = null;
    }
  }

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

        getPrice();

        sState(() {});
      }
    });
  }

  getIcons() async {
    if (!isIconsLoaded) {
      if (selectedStock['assets'] == null || selectedStock['assets']['website'] == null) {
        selectedStock['logo'] = null;
      } else {
        String src = selectedStock['assets']['website'];
        // print('/////////////////////////////////');
        // print(src);
        // print('/////////////////////////////////');

        src = src.replaceAll(RegExp('http://www.'), '');
        selectedStock['logo'] = await Clearbit().getLogo(src);
        setState(() {});

        // var s = getImagePalette(stock['logo']['logo']);
        isIconsLoaded = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    setRatio();
  }

  setRatio() => setState(() {
        ratio = (window.physicalSize.height / window.physicalSize.width);
      });

  refresh() {
    setState(() {});
  }

  DateTime _selectedDate = DateTime.now();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List changes = [];
  List displayedData = [];
  List modifiedPortfolios = [];
  List newPortfolio = [];

  Map data = {};
  Map dashaboardData;
  Map selectedStock = {};
  Map initData = {};

  FocusNode focusNode_0 = FocusNode();
  FocusNode focusNode_1 = FocusNode();

  double purchasePrice, quantity;
  double _width, _height, ratio;
  var priceAtDate;

  String selectedStockSymbol;
  String selectedStockExchange;
  String hintText_0 = '0';
  String hintText_1 = '0';
  String stockName = '';

  bool isIconsLoaded = false;
  bool isDateError = false, isSharesError = false, isBuyPriceError = false, isAddNewPortfolio = false;
  bool isDataChange = false;
  bool isDataLoaded = false;
  bool isPortfolioSelected = false;

  var isDark = true;

  TextStyle tickerSubTextStyle;
  TextStyle tickerHeadTextStyle;
  TextStyle headStyle, subStyle;

  Function underDevFunction;

  String currencySymbol = '';

  Future<bool> getStockData() async {
    // print('/////////////////////////////////');
    // print(data['symbol']);
    // print('/////////////////////////////////');

    selectedStock =
        await YahooApiService().getAllAssetData(symbol: data['symbol'], exchange: data['exchange']);

    // selectedStock = await YahooApiService().getAllAssetData(symbol: 'AAPL', exchange: 'NASDAQ');
    // print(selectedStock);
    currencySymbol = MarketUpdate(selectedStock['quote']['currency']).getCurrencySymbol()['symbol'];

    if (selectedStock.isEmpty) {
      Navigator.pop(context);

      CustomeBottomSheet(isDark)
          .underDevelopment(context, text: 'This asset class is not supported in basic version');

      return Future.value(false); //(computation)
    } else {
      // selectedStock['quote'].forEach((key, value) {
      //   print('${key.toString()} : ${value.toString()}');
      //   print('/////////////////////////////////');
      // });
      // print('/////////////////////////////////');
      // print(selectedStock['quote']['currency']);
      // print('/////////////////////////////////');

      selectedStockSymbol = data['symbol'];
      selectedStockExchange = selectedStock['quote']['exchange'];
      changes = data['changes'];
      stockName = selectedStock['quote']['longName'] == null
          ? selectedStock['quote']['shortName']
          : selectedStock['quote']['longName'];
      modifiedPortfolios = data['portfolios'];

      // modifiedPortfolios.forEach((element) {
      //   if (element == null) {
      //     modifiedPortfolios.remove(element);
      //   }
      // });

      // modifiedPortfolios.forEach((element) => print(element['name']));

      isDataLoaded = true;

      priceAtDate = selectedStock['quote']['regularMarketPrice'];

      portfolioReset();
      // print('/////////////////////////////////');

      getIcons();

      return Future.value(true);
    }
  }

  bool firstLoad = true;
  portfolioReset() {
    if (firstLoad == true) {
      modifiedPortfolios.forEach((portfolio) {
        portfolio['isSelected'] = false;
      });

      firstLoad = false;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    void _underDevelopment(String section) {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  color: UserThemes(isDark).insideColour,
                  border: Border.all(color: UserThemes(isDark).border),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        '$section',
                        style: TextStyle(color: UserThemes(isDark).textColorVarient, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }

    underDevFunction = _underDevelopment;

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    data = ModalRoute.of(context).settings.arguments;
    isAddNewPortfolio = data['newPort'];
    isDark = (data['data']['states']['theme']);

    headStyle = TextStyle(
      color: UserThemes(isDark).textColorVarient,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
    subStyle = TextStyle(color: UserThemes(isDark).textColor, fontWeight: FontWeight.w500, fontSize: 18);

    return FutureBuilder<bool>(
      future: isDataLoaded ? null : getStockData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done || isDataLoaded) {
          isDataLoaded = true;
          return Container(
            color: UserThemes(isDark).backgroundColour,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: UserThemes(isDark).backgroundColour,
                  appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: UserThemes(isDark).backgroundColour,
                    iconTheme: IconThemeData(
                      color: UserThemes(isDark).backColour, //change your color here
                    ),
                    title: Text(
                      stockName,
                      style: TextStyle(
                          color: UserThemes(isDark).textColor, fontSize: 20, fontWeight: FontWeight.w400),
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
                                underDevFunction(
                                    'Close price cannot be retrieved on the selected date, please select another date.');
                              });
                            } else {
                              isDateError = false;

                              if (isAddNewPortfolio) {
                                if (_formKey.currentState.validate()) {
                                  if (isPortfolioSelected) {
                                    modifiedPortfolios.forEach((portfolio) {
                                      if (portfolio['isSelected']) {
                                        changes.add({
                                          'name': portfolio['name'],
                                          'item': selectedStock,
                                          'buyPrice': purchasePrice,
                                          'shares': quantity,
                                          'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                          'Invested': quantity * purchasePrice
                                        });
                                      }
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              } else {
                                if (_formKey.currentState.validate()) {
                                  if (isPortfolioSelected) {
                                    modifiedPortfolios.forEach((portfolio) {
                                      if (portfolio['isSelected']) {
                                        if (portfolio['assets'][0]['items'].isNotEmpty) {
                                          changes.add({
                                            'name': portfolio['name'],
                                            'item': selectedStock,
                                            'buyPrice': purchasePrice,
                                            'shares': quantity,
                                            'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                            'Invested': quantity * purchasePrice
                                          });
                                        }
                                      }
                                    });
                                  }
                                }

                                Navigator.pop(context);
                              }
                            }
                          },
                          icon: Icon(
                            Icons.done,
                            color: UserThemes(isDark).greenVarient,
                            size: 20,
                          )),
                    ],
                  ),
                  body: Form(
                    key: _formKey,
                    child: ListView(
                      physics: ScrollPhysics(),
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                          // decoration: BoxDecoration(
                          //     // color: UserThemes(isDark).summaryColour,
                          //     border: Border.symmetric(
                          //         horizontal: BorderSide(color: UserThemes(isDark).border))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('$currencySymbol',
                                          style: TextStyle(
                                              color: UserThemes(isDark).textColor,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 35)),
                                      Text(
                                          selectedStockExchange == 'LSE'
                                              ? '${(selectedStock['quote']['regularMarketPrice'] / 100).toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                              : selectedStock['quote']['regularMarketPrice']
                                                  .toString()
                                                  .replaceAllMapped(
                                                      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                      (Match m) => '${m[1]},'),
                                          style: TextStyle(
                                              color: UserThemes(isDark).textColor,
                                              fontSize: 45,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          (selectedStock['quote']['regularMarketChange'] >= 0)
                                              ? '+$currencySymbol${selectedStock['quote']['regularMarketChange'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(selectedStock['quote']['regularMarketChangePercent']).toStringAsFixed(2)}%)'
                                              : '-$currencySymbol${(selectedStock['quote']['regularMarketChange'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(selectedStock['quote']['regularMarketChangePercent']).toStringAsFixed(2)}%)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: (selectedStock['quote']['regularMarketChange'] > 0)
                                                  ? UserThemes(isDark).greenVarient
                                                  : UserThemes(isDark).redVarient)),
                                      Text(' DAILY', style: headStyle),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                child: selectedStock['logo'] == null
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 13, bottom: 13, left: 3),
                                        child: Container(
                                          height: 60, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: UserThemes(isDark).backgroundColour,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${selectedStock['quote']['symbol']}",
                                              style: TextStyle(
                                                  color: UserThemes(isDark).textColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        // color: Colors.transparent,
                                        padding: EdgeInsets.only(top: 13, bottom: 13, left: 3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child:  Image.network(selectedStock['logo']['logo'],
                                          
                                              errorBuilder: (context, error, stackTrace) => Container(
                                                    height:
                                                        60, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          UserThemes(isDark).backgroundColour.withOpacity(.7),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Center(
                                                        child: Text(
                                                          "${selectedStock['quote']['symbol']}",
                                                          style: TextStyle(
                                                              color: UserThemes(isDark).textColor,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              height: 60, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                                              width: 100, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: UserThemes(isDark).summaryColour,
                                border: Border.symmetric(
                                    horizontal: BorderSide(color: UserThemes(isDark).border, width: 1))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: _width * .45,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'EXCHANGE',
                                              style: headStyle,
                                            ),
                                            Text(
                                              selectedStock['quote']['fullExchangeName'],
                                              style: subStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: _width * .45,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'SYMBOL',
                                              style: headStyle,
                                            ),
                                            Text(
                                              selectedStock['quote']['symbol'],
                                              style: subStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 4.0,
                                  dashColor: UserThemes(isDark).border,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: _width * .45,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'REGION',
                                              style: headStyle,
                                            ),
                                            Text(
                                              selectedStock['quote']['region'],
                                              style: subStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: _width * .45,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'MARKET CAP',
                                              style: headStyle,
                                            ),
                                            Text(
                                              selectedStock['quote']['marketCap'] == null
                                                  ? '---'
                                                  : NumberFormat.compact()
                                                      .format(selectedStock['quote']['marketCap']),
                                              style: subStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 4.0,
                                  dashColor: UserThemes(isDark).border,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: _width * .45,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'SHARES OUTSTANDING',
                                                style: headStyle,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                            Text(
                                              selectedStock['quote']['sharesOutstanding'] == null
                                                  ? '---'
                                                  : NumberFormat.compact()
                                                      .format(selectedStock['quote']['sharesOutstanding']),
                                              style: subStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: _width * .45,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'VOLUME',
                                              style: headStyle,
                                            ),
                                            Text(
                                              selectedStock['quote']['regularMarketVolume'] == null
                                                  ? '---'
                                                  : NumberFormat.compact()
                                                      .format(selectedStock['quote']['regularMarketVolume']),
                                              style: subStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: UserThemes(isDark).summaryColour,
                              border: Border.symmetric(
                                  horizontal: BorderSide(color: UserThemes(isDark).border, width: 1))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  Padding(
                              //    padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                              //    child: Text('Market Order',
                              //        style: TextStyle(
                              //          fontSize: 30,
                              //          fontWeight: FontWeight.w300,
                              //          color: UserThemes(isDark).textColor,
                              //        )),
                              //  ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ORDER TYPE',
                                      style: headStyle,
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      child: DropdownButton<String>(
                                        dropdownColor: UserThemes(isDark).summaryColour,
                                        icon: Text(
                                          'Buy',
                                          style: subStyle,
                                        ),
                                        autofocus: true,
                                        underline: Container(
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String option) {
                                          setState(() {
                                            // selectedEvent = option;
                                          });
                                        },
                                        isDense: true,
                                        isExpanded: false,
                                        items: <String>['Buy'].map<DropdownMenuItem<String>>((String option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            onTap: () {},
                                            child: Text(
                                              option,
                                              style: TextStyle(color: UserThemes(isDark).textColor),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor: UserThemes(isDark).border,
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'FILL PRICE',
                                        style: headStyle.copyWith(
                                            color: isBuyPriceError
                                                ? UserThemes(isDark).redVarient
                                                : UserThemes(isDark).textColorVarient),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$currencySymbol @ DATE ${priceAtDate == null ? '' : currencySymbol}${priceAtDate == null ? '...' : priceAtDate.toStringAsFixed(2)}',
                                        style: headStyle.copyWith(
                                            color: UserThemes(isDark).textColorVarient, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    // color: Colors.red,
                                    child: TextFormField(
                                      focusNode: focusNode_0,
                                      textAlign: TextAlign.end,
                                      keyboardType: TextInputType.number,
                                      validator: (txt) {
                                        setState(() {
                                          if (txt.isEmpty || double.parse(txt) <= 0) {
                                            isBuyPriceError = true;
                                            underDevFunction('Fill Price cannot be empty or lower than 0.');

                                            return null;
                                          } else {
                                            isBuyPriceError = false;
                                            return null;
                                          }
                                        });

                                        return null;
                                      },
                                      style: subStyle.copyWith(
                                          color: isBuyPriceError
                                              ? UserThemes(isDark).redVarient
                                              : UserThemes(isDark).textColor),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: UserThemes(isDark).textColorVarient,
                                            fontWeight: FontWeight.w400),
                                        hintText: hintText_0,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: UserThemes(isDark).border)),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                      onChanged: (txt) {
                                        setState(() => purchasePrice = double.parse(txt.toString()));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor: UserThemes(isDark).border,
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'QUANTITY',
                                    style: headStyle.copyWith(
                                        color: isSharesError
                                            ? UserThemes(isDark).redVarient
                                            : UserThemes(isDark).textColorVarient),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      focusNode: focusNode_1,
                                      textAlign: TextAlign.end,
                                      keyboardType: TextInputType.number,
                                      validator: (txt) {
                                        setState(() {
                                          if (txt.isEmpty || double.parse(txt) <= 0) {
                                            isSharesError = true;
                                            underDevFunction('Quantity cannot be empty or lower than 0.');

                                            return null;
                                          } else {
                                            isSharesError = false;
                                            return null;
                                          }
                                        });
                                        return null;
                                      },
                                      style: subStyle.copyWith(
                                          color: isSharesError
                                              ? UserThemes(isDark).redVarient
                                              : UserThemes(isDark).textColor),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: UserThemes(isDark).textColorVarient,
                                            fontWeight: FontWeight.w400),
                                        hintText: hintText_1,
                                        helperStyle: TextStyle(color: UserThemes(isDark).textColorVarient),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: UserThemes(isDark).border)),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                      onChanged: (txt) {
                                        setState(() => quantity = double.parse(txt.toString()));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor: UserThemes(isDark).border,
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'DATE OF TRANSACTION ',
                                      style: headStyle.copyWith(
                                          color: isDateError
                                              ? UserThemes(isDark).redVarient
                                              : UserThemes(isDark).textColorVarient),
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        onTap: () {
                                          _pickDateDialog(setState);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                                  style: subStyle.copyWith(
                                                      color: isDateError
                                                          ? UserThemes(isDark).redVarient
                                                          : UserThemes(isDark).textColor))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor: UserThemes(isDark).border,
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SELECT PORTFOLIO ',
                                      style: headStyle,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 1, top: 10),
                                      height: (ratio <= 1.6) ? _height * 0.1 : _height * 0.05,
                                      child: Center(
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: (modifiedPortfolios).map<Widget>((p) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isPortfolioSelected = !p['isSelected'];
                                                  p['isSelected'] = !p['isSelected'];

                                                  modifiedPortfolios.forEach((elpement) {
                                                    if (elpement != p && !isPortfolioSelected) {
                                                      isPortfolioSelected = elpement['isSelected'];
                                                    }
                                                  });
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(right: 5),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: p['isSelected']
                                                          ? UserThemes(isDark).blueVarient
                                                          : Colors.transparent,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(
                                                          color: p['isSelected']
                                                              ? UserThemes(isDark).purpleVarient
                                                              : UserThemes(isDark).textColorVarient)),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(10.0),
                                                      child: Text(
                                                        p['name'],
                                                        style: TextStyle(
                                                            color: p['isSelected']
                                                                ? UserThemes(isDark).backgroundColour
                                                                : UserThemes(isDark).textColorVarient,
                                                            fontWeight: FontWeight.w600),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        } else {
          return Loading(isDark);
        }
      },
    );
  }
}
