import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/dataObject/data_object.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketOrder extends StatefulWidget {
  final DataObject dataObject;

  const MarketOrder({Key key, @required this.dataObject}) : super(key: key);

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

  Map data = {};
  List changes = [];

  loadData() {
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
    data = ModalRoute.of(context).settings.arguments;

    loadData();

    return Container(
      color: UserThemes(widget.dataObject.themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
            iconTheme: IconThemeData(
              color: UserThemes(widget.dataObject.themeMode).backColour, //change your color here
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10, bottom: 15, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("", style: CustomTextStyles(widget.dataObject.themeMode).sectionSubTextStyle),
                          Text('Order', style: CustomTextStyles(widget.dataObject.themeMode).pageHeaderStyle)
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // if (data['event'] == null) {
                              changes.add({
                                'type': selectedEvent == 'Makret Sell' || selectedEvent == 'Market Buy'
                                    ? selectedEvent
                                    : 'Market $selectedEvent',
                                'fillPrice': fillPrice,
                                'filledQuantity': quantity,
                                'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                              });

                              Navigator.pop(context, changes);
                            }
                          },
                          icon: Icon(
                            Icons.done,
                            color: UserThemes(widget.dataObject.themeMode).greenVarient,
                            size: Units().headerIconSize,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ORDER',
                                style: CustomTextStyles(widget.dataObject.themeMode).portfolioSubValuetyle,
                              ),
                              Container(
                                // color: Colors.red,
                                child: DropdownButton<String>(
                                  dropdownColor: UserThemes(widget.dataObject.themeMode).summaryColour,
                                  icon: Text(
                                    selectedEvent,
                                    style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle,
                                  ),
                                  autofocus: true,
                                  underline: Container(
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String option) {
                                    setState(() {
                                      selectedEvent = option;
                                    });
                                  },
                                  isDense: true,
                                  isExpanded: false,
                                  items:
                                      <String>['Buy', 'Sell'].map<DropdownMenuItem<String>>((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      onTap: () {},
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                            color: UserThemes(widget.dataObject.themeMode).textColor),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: UserThemes(widget.dataObject.themeMode).seperator,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'PURCHASE PRICE',
                                style: CustomTextStyles(widget.dataObject.themeMode).portfolioSubValuetyle,
                              ),
                              Container(
                                // color: Colors.red,
                                width: widget.dataObject.width * 0.6,
                                child: TextFormField(
                                  focusNode: focusNode_0,
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value.isEmpty
                                      ? 'Enter $selectedEvent Price'
                                      : double.parse(value) <= 0
                                          ? '$selectedEvent Price must begreater than 0'
                                          : null,
                                  style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: UserThemes(widget.dataObject.themeMode).textColorVarient,
                                        fontWeight: FontWeight.w400),
                                    hintText: hintText_0,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: UserThemes(widget.dataObject.themeMode).border)),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  onChanged: (txt) => setState(() => fillPrice = double.parse(txt)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: UserThemes(widget.dataObject.themeMode).seperator,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'AVALIBLE SHARES',
                                style: CustomTextStyles(widget.dataObject.themeMode)
                                    .portfolioSubValuetyle
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: UserThemes(widget.dataObject.themeMode)
                                          .textColorVarient
                                          .withOpacity(.7),
                                    ),
                              ),
                              Text(
                                outstandingShares.toString(),
                                style: TextStyle(
                                    color: UserThemes(widget.dataObject.themeMode)
                                        .textColorVarient
                                        .withOpacity(.7),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: UserThemes(widget.dataObject.themeMode).seperator,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'QUANTITY',
                                style: CustomTextStyles(widget.dataObject.themeMode).portfolioSubValuetyle,
                              ),
                              Container(
                                // color: Colors.red,
                                width: widget.dataObject.width * 0.6,
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
                                  style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: UserThemes(widget.dataObject.themeMode).textColorVarient,
                                        fontWeight: FontWeight.w400),
                                    hintText: hintText_1,
                                    helperStyle: TextStyle(
                                        color: UserThemes(widget.dataObject.themeMode).textColorVarient),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: UserThemes(widget.dataObject.themeMode).border)),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  onChanged: (txt) => setState(() => quantity = double.parse(txt)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: UserThemes(widget.dataObject.themeMode).seperator,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ORDER DATE',
                                style: CustomTextStyles(widget.dataObject.themeMode).portfolioSubValuetyle,
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
                                        child: Text(DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                            style: CustomTextStyles(widget.dataObject.themeMode)
                                                .portfolioNameStyle)),
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
        ),
      ),
    );
  }
}
