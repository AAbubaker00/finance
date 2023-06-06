import 'package:Onvest/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvest/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Onvest/shared/Custome_Widgets/restricted/restricted.dart';
import 'package:Onvest/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvest/shared/TextStyle/customTextStyles.dart';
import 'package:Onvest/shared/dataObject/data_object.dart';
import 'package:Onvest/shared/decoration/customDecoration.dart';
import 'package:Onvest/shared/themes/themes.dart';
import 'package:Onvest/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderInfo extends StatefulWidget {
  final DataObject dataObject;
  final List changes;
  final Map event;
  final double outstandingShares;

  const OrderInfo({Key key, @required this.dataObject, this.changes, this.event, this.outstandingShares})
      : super(key: key);

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
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

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      fillPrice = double.parse(widget.event['fillPrice'].toString());
      quantity = double.parse(widget.event['filledQuantity'].toString());

      hintText_0 = widget.event['fillPrice'].toString();
      hintText_1 = widget.event['filledQuantity'].toString();

      selectedEvent = widget.event['type'];
      _selectedDate = DateTime.parse(widget.event['filledOn'].toString());
    }

    outstandingShares = double.parse(widget.outstandingShares.toString());
  }

  DateTime _selectedDate = DateTime.now();

  double quantity, fillPrice, outstandingShares;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  String hintText_0 = '0', hintText_1 = '0', selectedEvent = '...';

  @override
  Widget build(BuildContext context) {
    
    void _showConfirmPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) {
            return CWConfirmBottomSheetButton(
              dataObject: widget.dataObject,
              context: ctxt,
              btnText:
                  'Are you sure you want to delete this order?',
              function: () async {
             
              },
            );
          });
    }


    return CWScaffold(
      appBarTitle: 'Order',
      dataObject: widget.dataObject,
      isCenter: false,
      bottomAppBarBorderColour: false,
      appBarActions: [
        widget.event != null
            ? InkWell(
                onTap: () => _showConfirmPanel(),
                child: ClipRRect(
                    child: Image.asset('assets/icons/bin.png',
                        width: 21, height: 21, color: UserThemes(widget.dataObject.theme).iconColour)))
            : Container()
      ],
      body: widget.dataObject.userFire.isAnonymous
          ? Restricted(dataObject: widget.dataObject)
          : CWListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
                  decoration: CustomDecoration(widget.dataObject.theme).topWidgetDecoration,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ORDER',
                                style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                              ),
                              Container(
                                child: DropdownButton<String>(
                                  dropdownColor: UserThemes(widget.dataObject.theme).summaryColour,
                                  icon: Text(
                                    selectedEvent,
                                    style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
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
                                  items: <String>['Market Buy', 'Market Sell']
                                      .map<DropdownMenuItem<String>>((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      onTap: () {},
                                      child: Text(
                                        option,
                                        style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                          child: Divider(
                            color: UserThemes(widget.dataObject.theme).seperator,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ORDER PRICE',
                              style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                            ),
                            Container(
                              // color: Colors.red,
                              width: widget.dataObject.width * 0.6,
                              child: TextFormField(
                                focusNode: focusNode_0,
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                validator: (value) => value.isEmpty || fillPrice == null || fillPrice == 0
                                    ? 'Enter Order Price'
                                    : double.parse(value) <= 0
                                        ? '$selectedEvent Price must begreater than 0'
                                        : null,
                                style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true,
                                  isCollapsed: true,
                                  hintStyle: TextStyle(
                                      color: UserThemes(widget.dataObject.theme).textColorVarient,
                                      fontWeight: FontWeight.w400),
                                  hintText: hintText_0,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (txt) => setState(() => fillPrice = double.parse(txt)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                          child: Divider(
                            color: UserThemes(widget.dataObject.theme).seperator,
                          ),
                        ),
                        selectedEvent == 'Market Sell' || selectedEvent == '...'
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'AVALIBLE SHARES',
                                        style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                                      ),
                                      Text(
                                        outstandingShares.toString(),
                                        style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                                    child: Divider(
                                      color: UserThemes(widget.dataObject.theme).seperator,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'QUANTITY',
                              style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
                            ),
                            Container(
                              // color: Colors.red,
                              width: widget.dataObject.width * 0.6,
                              child: TextFormField(
                                focusNode: focusNode_1,
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                validator: (value) => value.isEmpty || quantity == null || quantity == 0
                                    ? 'Enter Quantity'
                                    : double.parse(value) <= 0
                                        ? '$selectedEvent Quantity must begreater than 0'
                                        : selectedEvent == 'Market Sell'
                                            ? double.parse(value) > outstandingShares
                                                ? 'Cannot sell more than you hold'
                                                : null
                                            : null,
                                style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true,
                                  isCollapsed: true,
                                  hintStyle: TextStyle(
                                      color: UserThemes(widget.dataObject.theme).textColorVarient,
                                      fontWeight: FontWeight.w400),
                                  hintText: hintText_1,
                                  helperStyle:
                                      TextStyle(color: UserThemes(widget.dataObject.theme).textColorVarient),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: UserThemes(widget.dataObject.theme).border)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (txt) => setState(() => quantity = double.parse(txt)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Units().dividerPaddingSpacing),
                          child: Divider(
                            color: UserThemes(widget.dataObject.theme).seperator,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'FILLED ON',
                              style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
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
                                          style:
                                              CustomTextStyles(widget.dataObject.theme).portfolioNameStyle)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: Units().mainSpacing),
                  child: CWApplyButton(
                    function: () {
                      if (_formKey.currentState.validate()) {
                        // if (widget.event == null) {
                        widget.changes.add({
                          'type': '$selectedEvent',
                          'fillPrice': fillPrice,
                          'filledQuantity': quantity,
                          'filledOn': DateFormat('yyyy-MM-dd').format(_selectedDate),
                        });

                        Navigator.pop(context, widget.changes);
                      }
                    },
                    dataObject: widget.dataObject,
                  ),
                )
              ],
            ),
    );
  }
}
