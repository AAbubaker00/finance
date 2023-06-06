import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';

class MarketOrder extends StatefulWidget {
  MarketOrder({Key key}) : super(key: key);

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

  double _width, quantity, fillPrice, outstandingShares;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  String hintText_0 = '0', hintText_1 = '0', selectedEvent = '...';

  Map instrument = {};

  bool isMainLoaded = false;
  var themeMode = true;

  TextStyle headStyle, subStyle;

  Map data = {};
  List changes = [];

  loadData() {
    themeMode = data['themeMode'];

    if (data['event'] != null && !isMainLoaded) {
      hintText_0 = data['event']['fillPrice'].toString();
      hintText_1 = data['event']['filledQuantity'].toString();

      selectedEvent = data['event']['type'];
      fillPrice = double.parse(data['event']['fillPrice'].toString());
      quantity = double.parse(data['event']['filledQuantity'].toString());
      _selectedDate = DateTime.parse(data['event']['filledOn'].toString());

      outstandingShares = double.parse(data['outstandingShares'].toString());

      isMainLoaded = true;
    } else {
      changes = data['changes'];
      outstandingShares = data['outstandingShares'];
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    data = ModalRoute.of(context).settings.arguments;

    loadData();

    headStyle = TextStyle(
      color: UserThemes(themeMode).textColorVarient,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: UserThemes(themeMode).textColor, fontWeight: FontWeight.w400, fontSize: 20);

    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(themeMode).backgroundColour,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: UserThemes(themeMode).backgroundColour,
            iconTheme: IconThemeData(
              color: UserThemes(themeMode).backColour, //change your color here
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 15, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: CustomTextStyles(themeMode)
                                .portfolioNameStyle
                                .copyWith(color: UserThemes(themeMode).textColorVarient, fontSize: 17),
                          ),
                          Text(
                            'Market Order',
                            style: CustomTextStyles(themeMode)
                                .sectionHeader
                                .copyWith(fontWeight: FontWeight.w500, fontSize: 40),
                          )
                        ],
                      ),
                      InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (DateFormat('EEEE').format(_selectedDate) == 'Sunday' ||
                                DateFormat('EEEE').format(_selectedDate) == 'Saturday' ||
                                instrument['chartData']['max']['timestamp'].firstWhere(
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
                                          'item': instrument,
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
                                            'item': instrument,
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
                          child: Icon(
                            Icons.done,
                            color: UserThemes(themeMode).greenVarient,
                            size: Units().headerIconSize,
                          )),
                    ],
                  ),
                ),
                Container(
                  decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 15, right: 10, left: 10),
                        child: Text(
                          'Order',
                          style: CustomTextStyles(themeMode).sectionHeader,
                        ),
                      ),
                      Container(
                        decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                        padding: EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Fill Price:',
                                      style: headStyle,
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      width: _width * 0.6,
                                      child: TextFormField(
                                        focusNode: focusNode_0,
                                        textAlign: TextAlign.end,
                                        keyboardType: TextInputType.number,
                                        validator: (value) => value.isEmpty
                                            ? 'Enter $selectedEvent Price'
                                            : double.parse(value) <= 0
                                                ? '$selectedEvent Price must begreater than 0'
                                                : null,
                                        style: subStyle,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: UserThemes(themeMode).textColorVarient,
                                              fontWeight: FontWeight.w400),
                                          hintText: hintText_0,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: UserThemes(themeMode).border)),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                        onChanged: (txt) => setState(() => fillPrice = double.parse(txt)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: UserThemes(themeMode).seperator),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Avalible Shares:',
                                      style: headStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: UserThemes(themeMode).textColorVarient.withOpacity(.7),
                                      ),
                                    ),
                                    Text(
                                      outstandingShares.toString(),
                                      style: TextStyle(
                                          color: UserThemes(themeMode).textColorVarient.withOpacity(.7),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: UserThemes(themeMode).seperator),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Quantity:',
                                      style: headStyle,
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      width: _width * 0.7,
                                      child: TextFormField(
                                        focusNode: focusNode_1,
                                        textAlign: TextAlign.end,
                                        keyboardType: TextInputType.number,
                                        validator: (value) => value.isEmpty
                                            ? 'Enter Quantity'
                                            : double.parse(value) <= 0
                                                ? '$selectedEvent Quantity must begreater than 0'
                                                : selectedEvent == 'Sell'
                                                    ? double.parse(value) > outstandingShares
                                                        ? 'Cannot sell more than you hold'
                                                        : null
                                                    : null,
                                        style: subStyle,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: UserThemes(themeMode).textColorVarient,
                                              fontWeight: FontWeight.w400),
                                          hintText: hintText_1,
                                          helperStyle:
                                              TextStyle(color: UserThemes(themeMode).textColorVarient),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: UserThemes(themeMode).border)),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                        onChanged: (txt) => setState(() => quantity = double.parse(txt)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: UserThemes(themeMode).seperator),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Date Of Transaction: ',
                                      style: headStyle,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _pickDateDialog();
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
                                                  DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                                  style: subStyle)),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
