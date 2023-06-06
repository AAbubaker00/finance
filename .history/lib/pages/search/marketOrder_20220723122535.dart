import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/calls/getIcons.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:Valuid/shared/update/initialise.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketOrder extends StatefulWidget {
  final DataObject dataObject;
  Map instrument;
  final bool isView;

  MarketOrder({Key key, @required this.dataObject, @required this.instrument, this.isView = false})
      : super(key: key);

  @override
  _MarketOrderState createState() => _MarketOrderState();
}

class _MarketOrderState extends State<MarketOrder> {
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

  @override
  void initState() {
    super.initState();
    currencySymbol =
        Initialise(baseCurrency: widget.instrument['quote']['currency']).getCurrencySymbol()['symbol'];

    instrumentSymbol = widget.instrument['quote']['symbol'];
    instrumentExchange = widget.instrument['quote']['exchange'];
    instrumentName = widget.instrument['quote']['shortName'];

    if (widget.isView) {
      hintText_0 = widget.dataObject.onHolding['shares'].toStringAsFixed(2);
      hintText_1 = widget.dataObject.onHolding['avgPrice'].toStringAsFixed(2);
      selectedPortfolio = widget.dataObject.onPortfolio['name'];
      isPortfolioSelected = true;
    }

    getIcon();
  }

  getIcon() async {
    widget.instrument = await GetIcons().getIcon(widget.instrument,
        symbol: widget.instrument['quote']['symbol'],
        exchange: widget.instrument['quote']['fullExchangeName']);

    setState(() {});
  }

  DateTime _selectedDate = DateTime.now();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  double purchasePrice = 0, quantity = 0;

  String hintText_0 = '0', hintText_1 = '0';
  String instrumentSymbol, currencySymbol;
  String instrumentExchange, instrumentName;

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: widget.dataObject,
      // preferredSizeValue: 2,
      appBarTitleWidget: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.instrument['quote'].containsKey('longName')
                  ? '${widget.instrument['quote']['longName']}'
                  : widget.instrument['quote']['shortName'].toString(),
              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).appBarTitleStyle,
            ),
            widget.instrument['logo'] == null
                ? Container(
                    height: 25, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                    width: 25,
                    decoration: BoxDecoration(
                      color: UserThemes(widget.dataObject.theme).backgroundColour,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "${widget.instrument['quote']['symbol']}",
                        style: TextStyle(
                            color: UserThemes(widget.dataObject.theme).textColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(Units().circularRadius),
                    child: Image.network(widget.instrument['logo'],
                        errorBuilder: (context, error, stackTrace) => Container(
                              height: 25, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                              width: 25,
                              decoration: BoxDecoration(
                                color: UserThemes(widget.dataObject.theme).backgroundColour.withOpacity(.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    "${widget.instrument['quote']['symbol']}",
                                    style: TextStyle(
                                        color: UserThemes(widget.dataObject.theme).textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        height: 25, //(ratio <= 1.6) ? _height * 0.06 : _height * 0.2,
                        width: 25, //(ratio <= 1.6) ? _width * 0.045 : _width * 0.11,
                        fit: BoxFit.fill),
                  ),
          ],
        ),
      ),
      bottomAppBarBorderColour: true,
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Ink(
                      decoration: CustomDecoration(widget.dataObject.theme).curvedBaseContainerDecoration,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0, left: 1),
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
                                            ? '${(widget.instrument['quote']['regularMarketPrice'] / 100).toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
                                            : '${widget.instrument['quote']['regularMarketPrice'].toStringAsFixed(0).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                            .overallValueStyle,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 3.0, left: 1),
                                        child: Text(
                                          instrumentExchange == 'LSE'
                                              ? '${(double.parse((widget.instrument['quote']['regularMarketPrice'] / 100).toStringAsFixed(2)) - (double.parse((widget.instrument['quote']['regularMarketPrice'] / 100).toStringAsFixed(2))).toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}'
                                              : '${(widget.instrument['quote']['regularMarketPrice'] - widget.instrument['quote']['regularMarketPrice'].toInt()).toStringAsFixed(2).replaceRange(0, 1, '')}',
                                          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                              .overallCurrencyStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      (widget.instrument['quote']['regularMarketChange'] >= 0)
                                          ? '+$currencySymbol${widget.instrument['quote']['regularMarketChange'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(widget.instrument['quote']['regularMarketChangePercent']).toStringAsFixed(2)}%)'
                                          : '-$currencySymbol${(widget.instrument['quote']['regularMarketChange'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(widget.instrument['quote']['regularMarketChangePercent']).toStringAsFixed(2)}%)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: (widget.instrument['quote']['regularMarketChange'] > 0)
                                              ? UserThemes(widget.dataObject.theme).greenVarient
                                              : UserThemes(widget.dataObject.theme).redVarient)),
                                  Text(' DAILY',
                                      style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                          .tableHeaderStyle),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CustomDivider(dataObject: widget.dataObject),
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
                                  hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .loginHeaderTextStyle
                                      .copyWith(
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
                            child: CustomDivider(dataObject: widget.dataObject),
                          ),
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
                                  hintStyle: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .loginHeaderTextStyle
                                      .copyWith(
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
                                  purchasePrice = double.parse(txt);
                                }),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CustomDivider(dataObject: widget.dataObject),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pickDateDialog(setState);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TRANSACTION DATE',
                                      style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                          .holdingSubValueStyle,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                            .portfolioNameStyle),
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
                                    style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                        .holdingSubValueStyle,
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
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CWApplyButton(
                        dataObject: widget.dataObject,
                        customTextColour: UserThemes(widget.dataObject.theme).summaryColour,
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
                                    'history': [],
                                    'marketData': widget.instrument
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
                                        'history': [],
                                      });
                                    }
                                  }
                                } else {
                                  isHoldingExist['Invested'] = 0;
                                  isHoldingExist['shares'] = 0;
              
                                  for (var database_data_portfolio in widget.dataObject.databaseData['portfolios']) {
                                    if (database_data_portfolio['name'] == selectedPortfolio) {
                                      for (var database_holding in database_data_portfolio['assets'][0]['items']) {
                                        if (database_holding['symbol'] == isHoldingExist['symbol']) {
                                          database_holding['Invested'] = quantity * purchasePrice;
                                          database_holding['shares'] = quantity;
              
                                          isHoldingExist['avgPrice'] = purchasePrice;
                                          database_holding['avgPrice'] = purchasePrice;
              
                                          isHoldingExist['shares'] = quantity;
                                          database_holding['shares'] = quantity;
              
                                          database_holding['Invested'] = quantity * purchasePrice;
                                          database_holding['history'] = quantity * purchasePrice;
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
                    ),
                  ],
                ),
              )
            

            ,Container(
              padding: eDGE,
            )
            ],
          ),
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
        enabled: !widget.isView,
        child: Text(
          selectedPortfolio,
          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
              .portfolioNameStyle
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
