import 'package:Onvest/services/database/database.dart';
import 'package:Onvest/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvest/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketOrder extends StatefulWidget {
  final DataObject dataObject;

  MarketOrder({Key key, @required this.dataObject}) : super(key: key);

  @override
  _MarketOrderState createState() => _MarketOrderState();
}

class _MarketOrderState extends State<MarketOrder> {
  void _pickDateDialog() {
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
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  DateTime _selectedDate = DateTime.now();

  double quantity, fillPrice, outstandingShares;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  String hintText_0 = '0', hintText_1 = '0', selectedEvent = '...';

  bool isMainLoaded = false;
  double purchasePrice = 0, quantity = 0;

  Map data = {};
  List changes = [];

  loadData() {
    // if (data['event'] != null && !isMainLoaded) {
    //   hintText_0 = data['event']['fillPrice'].toString();
    //   hintText_1 = data['event']['filledQuantity'].toString();

    //   selectedEvent = data['event']['type'];
    //   fillPrice = double.parse(data['event']['fillPrice'].toString());
    //   quantity = double.parse(data['event']['filledQuantity'].toString());
    //   _selectedDate = DateTime.parse(data['event']['filledOn'].toString());

    //   outstandingShares = double.parse(data['outstandingShares'].toString());

    //   isMainLoaded = true;
    // } else {
    //   changes = data['changes'];
    //   outstandingShares = data['outstandingShares'];
    // }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    loadData();

    return CWScaffold(
      dataObject: widget.dataObject,
      appBarTitle: 'Order',
      appbarColourOption: 2,
      bottomAppBarBorderColour: false,
      body: Form(
        key: _formKey,
        child: CWListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Ink(
              decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aquired shares',
                        style: CustomTextStyles(widget.dataObject.theme)
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
                        style: CustomTextStyles(widget.dataObject.theme).loginHeaderTextStyle,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          hintStyle: CustomTextStyles(widget.dataObject.theme).loginHeaderTextStyle.copyWith(
                              color: UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.3)),
                          hintText: hintText_1,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (txt) => setState(() => quantity = double.parse(txt)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: UserThemes(widget.dataObject.theme).seperator),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Purchase/Average price',
                        style: CustomTextStyles(widget.dataObject.theme)
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
                        style: CustomTextStyles(widget.dataObject.theme).loginHeaderTextStyle,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          hintStyle: CustomTextStyles(widget.dataObject.theme).loginHeaderTextStyle.copyWith(
                              color: UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.3)),
                          hintText: hintText_0,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (txt) => setState(() {
                          // _textEditingController.text = _textEditingController.text.contains('$currencySymbol')

                          //     ? _textEditingController.text
                          //     : '$currencySymbol' + _textEditingController.text..replaceAll('$currencySymbol', '');
                          // purchasePrice = double.parse(txt);
                        }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: UserThemes(widget.dataObject.theme).seperator),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // _pickDateDialog(setState);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TRANSACTION DATE',
                              style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SELECTED PORTFOLIO ',
                            style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          _sortPopupMenu(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: CWConfirmButton(
                // btnText: 'Confirm',
                dataObject: widget.dataObject,
                isChange: quantity > 0 && purchasePrice > 0 && selectedPortfolio != 'Select Portfolio',
                function: () async {
                  if (_formKey.currentState.validate() && isPortfolioSelected) {
                    // print('heee');

                    widget.dataObject.isUpdating = true;

                    for (var portfolio in widget.dataObject.portfolios) {
                      if (portfolio['name'] == selectedPortfolio) {
                        var isHoldingExist = portfolio['assets'][0]['items'].firstWhere(
                            (holding) => holding['symbol'] == instrumentSymbol,
                            orElse: () => null);

                        PrintFunctions().printStartEndLine(isHoldingExist);

                        if (isHoldingExist == null) {
                          portfolio['assets'][0]['items'].add({
                            'Invested': purchasePrice * quantity,
                            'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            'shares': quantity,
                            'value': 0.0,
                            'buyPrice': purchasePrice,
                            'avgPrice': purchasePrice,
                            'symbol': instrumentSymbol,
                            'change': 0.0,
                            'percDiff': 0.0,
                            'exchange': instrumentExchange,
                            'history': [
                              {
                                'type': 'Market Buy',
                                'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                'filledQuantity': quantity,
                                'fillPrice': purchasePrice,
                                'averagePrice': purchasePrice,
                                'outstandingShares': quantity
                              }
                            ],
                            'marketData': instrument
                          });

                          for (var database_data_portfolio in widget.dataObject.databaseData['portfolios']) {
                            if (database_data_portfolio['name'] == selectedPortfolio) {
                              database_data_portfolio['assets'][0]['items'].add({
                                'Invested': purchasePrice * quantity,
                                'buyDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                'shares': quantity,
                                'buyPrice': purchasePrice,
                                'avgPrice': purchasePrice,
                                'symbol': instrumentSymbol,
                                'exchange': instrumentExchange,
                                'history': [
                                  {
                                    'type': 'Market Buy',
                                    'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                    'filledQuantity': quantity,
                                    'fillPrice': purchasePrice,
                                    'averagePrice': purchasePrice,
                                    'outstandingShares': quantity
                                  }
                                ],
                              });
                            }
                          }
                        } else {
                          double outstandingShares = 0.0, avgPrice = 0.0;
                          double numerator = 0;

                          isHoldingExist['Invested'] = 0;
                          isHoldingExist['shares'] = 0;
                          isHoldingExist['history'].add({
                            'type': 'Market Buy',
                            'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                            'filledQuantity': quantity,
                            'fillPrice': purchasePrice,
                            'averagePrice': 0,
                            'outstandingShares': 0,
                          });

                          for (var database_data_portfolio in widget.dataObject.databaseData['portfolios']) {
                            if (database_data_portfolio['name'] == selectedPortfolio) {
                              for (var database_holding in database_data_portfolio['assets'][0]['items']) {
                                if (database_holding['symbol'] == isHoldingExist['symbol']) {
                                  database_holding['Invested'] = 0;
                                  database_holding['shares'] = 0;
                                  database_holding['history'].add({
                                    'type': 'Market Buy',
                                    'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                                    'filledQuantity': quantity,
                                    'fillPrice': purchasePrice,
                                    'averagePrice': 0,
                                    'outstandingShares': 0,
                                  });

                                  database_holding['history'].sort((a, b) =>
                                      DateTime.parse(a['filledOn']).compareTo(DateTime.parse(b['filledOn'])));

                                  for (var event in isHoldingExist['history']) {
                                    // print(event['filledOn']);

                                    isHoldingExist['Invested'] +=
                                        event['filledQuantity'] * event['fillPrice'];

                                    outstandingShares += event['filledQuantity'];

                                    numerator += event['filledQuantity'] * event['fillPrice'];
                                    avgPrice = numerator / outstandingShares;

                                    event['outstandingShares'] = outstandingShares;
                                    event['averagePrice'] = avgPrice;
                                  }

                                  isHoldingExist['avgPrice'] = avgPrice;
                                  database_holding['avgPrice'] = avgPrice;

                                  isHoldingExist['shares'] = outstandingShares;
                                  database_holding['shares'] = outstandingShares;

                                  database_holding['Invested'] = isHoldingExist['Invested'];
                                  database_holding['history'] = isHoldingExist['history'];
                                }
                              }
                            }
                          }
                        }
                      }
                    }

                    widget.dataObject.lastCalenderUpdate = '';

                    DatabaseService().updateChange(widget.dataObject);

                    Navigator.pop(context);

                    widget.dataObject.isUpdating = false;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String selectedPortfolio = 'Select Portfolio';

  bool isDataLoaded = false, isPortfolioSelected = false;

  Widget _sortPopupMenu() => PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Units().circularRadius)),
        color: UserThemes(widget.dataObject.theme).backgroundColour,
        elevation: 8,
        offset: Offset(0, 30),
        onSelected: (option) {
          setState(() {
            isPortfolioSelected = true;
            selectedPortfolio = option['name'];
          });
        },
        child: Text(
          selectedPortfolio,
          style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle.copyWith(
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
