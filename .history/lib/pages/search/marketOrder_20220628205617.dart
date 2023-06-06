import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
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

    return Container(
      color: UserThemes(widget.dataObject.theme).backgroundColour,
      child: SafeArea(
        child: CWScaffold(
          dataObject: widget.dataObject,
          appBarTitle: 'Order',
          appbarColourOption: 2,
          bottomAppBarBorderColour: false,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                            Text('Transaction',
                                style: CustomTextStyles(widget.dataObject.theme).pageHeaderStyle)
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
                              color: UserThemes(widget.dataObject.theme).greenVarient,
                              size: Units().iconSize,
                            )),
                      ],
                    ),
                  ),
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
                                hintStyle: CustomTextStyles(widget.dataObject.theme)
                                    .loginHeaderTextStyle
                                    .copyWith(
                                        color:
                                            UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.3)),
                                hintText: hintText_1,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: UserThemes(widget.dataObject.theme).border)),
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
                              controller: _textEditingController,
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
                                hintStyle: CustomTextStyles(widget.dataObject.theme)
                                    .loginHeaderTextStyle
                                    .copyWith(
                                        color:
                                            UserThemes(widget.dataObject.theme).blueVarient.withOpacity(.3)),
                                hintText: hintText_0,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: UserThemes(widget.dataObject.theme).border)),
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
                          child: Divider(color: UserThemes(widget.dataObject.theme).seperator),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
