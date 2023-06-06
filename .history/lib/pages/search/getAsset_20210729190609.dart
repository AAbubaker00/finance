import 'package:Strice/services/clearbit/clearbit.dart';
import 'package:Strice/services/yahooapi/yahoo_api_provider.dart';
import 'package:Strice/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Strice/shared/Custome_Widgets/loading/loading.dart';
import 'package:Strice/shared/update/update.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:intl/intl.dart';

class GetAsset extends StatefulWidget {
  GetAsset({Key key}) : super(key: key);

  @override
  _BuyStockState createState() => _BuyStockState();
}

class _BuyStockState extends State<GetAsset> {
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
  double _width, _height;

  String selectedStockSymbol;
  String selectedStockExchange;
  String hintText_0 = '0';
  String hintText_1 = '0';
  String stockName = '';

  bool isDateError = false, isSharesError = false, isBuyPriceError = false, isAddNewPortfolio = false;
  bool isDataChange = false;
  bool isDataLoaded = false;
  bool isPortfolioSelected = false;
  bool isDark = true;
  bool isIconsLoaded = false;

  TextStyle tickerSubTextStyle;
  TextStyle tickerHeadTextStyle;
  TextStyle headStyle, subStyle;

  Function underDevFunction;

  Future<bool> getStockData() async {
    // print('/////////////////////////////////');
    // print(data['symbol']);
    // print('/////////////////////////////////');

    selectedStock =
        await YahooApiService().getAllAssetData(symbol: data['symbol'], exchange: data['exchange']);

    print(selectedStock);

    if (selectedStock.isEmpty) {
      Navigator.pop(context);

      CustomeBottomSheet()
          .underDevelopment(context, text: 'This asset class is not supported in basic version');
    } else {

      selectedStock['quote'].forEach((key, value) { })
      // print('/////////////////////////////////');
      // print(selectedStock['quote']['currency']);
      // print('/////////////////////////////////');

      // selectedStock = await YahooApiService().getAllStockData(symbol: 'AAPL', exchange: 'NASDAQ');
      selectedStockSymbol = data['symbol'];
      selectedStockExchange = data['exch'];
      changes = data['changes'];
      stockName = selectedStock['quote']['longName'];
      modifiedPortfolios = data['portfolios'];

      // modifiedPortfolios.forEach((element) {
      //   if (element == null) {
      //     modifiedPortfolios.remove(element);
      //   }
      // });

      modifiedPortfolios.forEach((element) => print(element['name']));

      isDataLoaded = true;

      portfolioReset();
      // print('/////////////////////////////////');

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
                  color: DarkTheme(isDark).insideColour,
                  border: Border.all(color: DarkTheme(isDark).border),
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
                        style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 20),
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
    // isDark = (data['data']['states']['dark']);

    // loadData();

    headStyle = TextStyle(
      color: DarkTheme(isDark).textColorVarient,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400, fontSize: 20);

    getIcons();

    return FutureBuilder<bool>(
      future: isDataLoaded ? null : getStockData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done || isDataLoaded) {
          isDataLoaded = true;
          return Container(
            color: DarkTheme(isDark).summaryColour,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: DarkTheme(isDark).backgroundColour,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight * .8),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide(color: DarkTheme(isDark).border))),
                      child: AppBar(
                        elevation: 0,
                        centerTitle: true,
                        backgroundColor: DarkTheme(isDark).summaryColour,
                        iconTheme: IconThemeData(
                          color: DarkTheme(isDark).backColour, //change your color here
                        ),
                        title: Text(
                          stockName,
                          style: TextStyle(color: DarkTheme(isDark).textColorVarient),
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
                                color: DarkTheme(isDark).greenVarient,
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                  body: Form(
                    key: _formKey,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedStock['logo'] == null
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 10.0, left: 5),
                                      child: Container(
                                        height: _height * 0.065,
                                        width: _width * 0.14,
                                        decoration: BoxDecoration(
                                          color: DarkTheme(isDark).summaryColour,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${selectedStock['quote']['symbol']}",
                                            style: TextStyle(
                                                color: DarkTheme(isDark).textColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(right: 10.0, left: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: Image.network(selectedStock['logo']['logo'],
                                                errorBuilder: (context, error, stackTrace) => Container(
                                                      height: _height * 0.07,
                                                      width: _width * 0.1,
                                                      child: Center(
                                                        child: Text(
                                                          "${selectedStock['quote']['symbol']}",
                                                          style: TextStyle(
                                                              color: DarkTheme(isDark).textColor,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                height: _height * 0.065,
                                                width: _width * 0.14,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                    ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            '${Update(selectedStock['quote']['currency']).getCurrencySymbol()['symbol']} ',
                                            style: TextStyle(
                                                color: DarkTheme(isDark).textColor,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 50)),
                                        Text(
                                            selectedStockExchange == 'LSE'
                                                ? '${(selectedStock['quote']['regularMarketPrice'] / 100).toString()}'
                                                : selectedStock['quote']['regularMarketPrice'].toString(),
                                            style: TextStyle(
                                                color: DarkTheme(isDark).textColor,
                                                fontSize: 50,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: DarkTheme(isDark).summaryColour,
                                    border: Border(
                                        top: BorderSide(color: DarkTheme(isDark).border),
                                        bottom: BorderSide(color: DarkTheme(isDark).border))),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Order Type:',
                                            style: headStyle,
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            child: DropdownButton<String>(
                                              dropdownColor: DarkTheme(isDark).summaryColour,
                                              icon: Text(
                                                'Buy',
                                                style: subStyle,
                                              ),
                                              autofocus: isDark,
                                              underline: Container(
                                                color: Colors.transparent,
                                              ),
                                              onChanged: (String option) {
                                                setState(() {
                                                  // selectedEvent = option;
                                                });
                                              },
                                              isDense: isDark,
                                              isExpanded: false,
                                              items: <String>['Buy']
                                                  .map<DropdownMenuItem<String>>((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  onTap: () {},
                                                  child: Text(
                                                    option,
                                                    style: TextStyle(color: DarkTheme(isDark).textColor),
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
                                      dashColor: DarkTheme(isDark).border,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Fill Price:',
                                            style: headStyle.copyWith(
                                                color: isBuyPriceError
                                                    ? DarkTheme(isDark).redVarient
                                                    : DarkTheme(isDark).textColorVarient),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            width: _width * 0.7,
                                            child: TextFormField(
                                              focusNode: focusNode_0,
                                              textAlign: TextAlign.end,
                                              keyboardType: TextInputType.number,
                                              validator: (txt) {
                                                setState(() {
                                                  if (txt.isEmpty || double.parse(txt) <= 0) {
                                                    isBuyPriceError = true;
                                                    underDevFunction(
                                                        'Fill Price cannot be empty or lower than 0.');

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
                                                      ? DarkTheme(isDark).redVarient
                                                      : DarkTheme(isDark).textColor),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    color: DarkTheme(isDark).textColorVarient,
                                                    fontWeight: FontWeight.w400),
                                                hintText: hintText_0,
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: DarkTheme(isDark).border)),
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
                                    ),
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: DarkTheme(isDark).border,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Quantity:',
                                            style: headStyle.copyWith(
                                                color: isSharesError
                                                    ? DarkTheme(isDark).redVarient
                                                    : DarkTheme(isDark).textColorVarient),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            width: _width * 0.7,
                                            child: TextFormField(
                                              focusNode: focusNode_1,
                                              textAlign: TextAlign.end,
                                              keyboardType: TextInputType.number,
                                              validator: (txt) {
                                                setState(() {
                                                  if (txt.isEmpty || double.parse(txt) <= 0) {
                                                    isSharesError = true;
                                                    underDevFunction(
                                                        'Quantity cannot be empty or lower than 0.');

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
                                                      ? DarkTheme(isDark).redVarient
                                                      : DarkTheme(isDark).textColor),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    color: DarkTheme(isDark).textColorVarient,
                                                    fontWeight: FontWeight.w400),
                                                hintText: hintText_1,
                                                helperStyle:
                                                    TextStyle(color: DarkTheme(isDark).textColorVarient),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: DarkTheme(isDark).border)),
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
                                    ),
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: DarkTheme(isDark).border,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Date Of Transaction: ',
                                            style: headStyle.copyWith(
                                                color: isDateError
                                                    ? DarkTheme(isDark).redVarient
                                                    : DarkTheme(isDark).textColorVarient),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _pickDateDialog(setState);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(_selectedDate)
                                                            .toString(),
                                                        style: subStyle.copyWith(
                                                            color: isDateError
                                                                ? DarkTheme(isDark).redVarient
                                                                : DarkTheme(isDark).textColor))),
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
                                      dashColor: DarkTheme(isDark).border,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.0),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Select Portfolio: ',
                                            style: headStyle,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _pickDateDialog(setState);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: 10,
                                                left: 1,
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.05,
                                              // width: _width * 0.6,
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
                                                                  ? DarkTheme(isDark).blueVarient
                                                                  : Colors.transparent,
                                                              borderRadius: BorderRadius.circular(5),
                                                              border: Border.all(
                                                                  color: p['isSelected']
                                                                      ? DarkTheme(isDark).blueVarient
                                                                      : DarkTheme(isDark).textColorVarient)),
                                                          child: Center(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(10.0),
                                                              child: Text(
                                                                p['name'],
                                                                style: TextStyle(
                                                                    color: p['isSelected']
                                                                        ? DarkTheme(isDark).backgroundColour
                                                                        : DarkTheme(isDark).textColorVarient,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
