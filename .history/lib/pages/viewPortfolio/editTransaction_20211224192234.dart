import 'package:Strice/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';

class MarketOrder extends StatefulWidget {
  final Datab
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

  bool isMainLoaded = false;
  var isDark = true;


  TextStyle headStyle, subStyle;

  Map data = {};
  List changes = [];

  loadData() {
    isDark = data['isDark'];

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
      color: UserThemes(isDark).textColorVarient,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
    subStyle = TextStyle(color: UserThemes(isDark).textColor, fontWeight: FontWeight.w400, fontSize: 20);

    return Container(
      color: UserThemes(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(isDark).backgroundColour,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // if (data['event'] == null) {
                      changes.add({
                        'type': selectedEvent == 'Makret Sell' || selectedEvent == 'Market Buy' ? selectedEvent :  'Market $selectedEvent',
                        'fillPrice': fillPrice,
                        'filledQuantity': quantity,
                        'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                      });
                      // } else {
                      //   data['event']['fillPrice'] = fillPrice;
                      //   data['event']['filledOn'] = DateFormat('yyyy-MM-dd').format(_selectedDate);
                      //   data['event']['filledQuantity'] = quantity;
                      //   data['event']['type'] = selectedEvent;
                      // }

                      Navigator.pop(context, changes);
                    }
                  },
                  icon: Icon(
                    Icons.done,
                    color: UserThemes(isDark).greenVarient,
                    size: 20,
                  )),
            ],
            elevation: 0,
            centerTitle: true,
            backgroundColor: UserThemes(isDark).backgroundColour,
            iconTheme: IconThemeData(
              color: UserThemes(isDark).backColour, //change your color here
            ),
            title: Text(
              'Market Order',
              style: TextStyle(color: UserThemes(isDark).textColor, fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: UserThemes(isDark).summaryColour,
                  border: Border(
                      top: BorderSide(color: UserThemes(isDark).border, width: 1),
                      bottom: BorderSide(color: UserThemes(isDark).border))),
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
                            'Order Type:',
                            style: headStyle,
                          ),
                          Container(
                            // color: Colors.red,
                            child: DropdownButton<String>(
                              dropdownColor: UserThemes(isDark).summaryColour,
                              icon: Text(
                                selectedEvent,
                                style: subStyle,
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
                              items: <String>['Buy', 'Sell'].map<DropdownMenuItem<String>>((String option) {
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
                            width: _width * 0.7,
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
                                    color: UserThemes(isDark).textColorVarient, fontWeight: FontWeight.w400),
                                hintText: hintText_0,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: UserThemes(isDark).border)),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              onChanged: (txt) => setState(() => fillPrice = double.parse(txt)),
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
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Avalible Shares:',
                            style: headStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: UserThemes(isDark).textColorVarient.withOpacity(.7),
                            ),
                          ),
                          Text(
                            outstandingShares.toString(),
                            style: TextStyle(
                                color: UserThemes(isDark).textColorVarient.withOpacity(.7),
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
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
                                    color: UserThemes(isDark).textColorVarient, fontWeight: FontWeight.w400),
                                hintText: hintText_1,
                                helperStyle: TextStyle(color: UserThemes(isDark).textColorVarient),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: UserThemes(isDark).border)),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              onChanged: (txt) => setState(() => quantity = double.parse(txt)),
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
                                    child: Text(DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
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
          ),
        ),
      ),
    );
  }
}
