import 'package:Onvesting/services/database/database.dart';
import 'package:Onvesting/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Onvesting/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Onvesting/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Onvesting/shared/TextStyle/customTextStyles.dart';
import 'package:Onvesting/shared/calculations/Inception_Date/inception_Date.dart';
import 'package:Onvesting/shared/dataObject/data_object.dart';
import 'package:Onvesting/shared/dateFormat/customeDateFormatter.dart';
import 'package:Onvesting/shared/decoration/customDecoration.dart';
import 'package:Onvesting/shared/files/fileHandler.dart';
import 'package:Onvesting/shared/themes/themes.dart';
import 'package:Onvesting/shared/units/units.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Onvesting/extensions/stringExt.dart';

class PortfolioInfo extends StatefulWidget {
  final DataObject dataObject;
  final Map onPortfolio;

  PortfolioInfo({Key key, this.dataObject, this.onPortfolio}) : super(key: key);

  @override
  _PortfolioInfoState createState() => _PortfolioInfoState();
}

class _PortfolioInfoState extends State<PortfolioInfo> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';
  Map data;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  bool isDataChanged = false, isMainLoaded = false;

  TextStyle headerStyle, subStyle;

  var inceptionDate;

  String duration = '';

  _loadData() {
    if (isMainLoaded == false) {
      name = widget.dataObject.onPortfolio['name'];

      isMainLoaded = true;

      if (widget.dataObject.onHoldings.length != 0) {
        inceptionDate = InceptionDate().getInceptionDae(widget.dataObject.onHoldings);

        int totalDays = DateTime.now().difference(inceptionDate).inDays;
        int years = totalDays ~/ 365;
        int months = (totalDays - years * 365) ~/ 30;
        int days = totalDays - years * 365 - months * 30;
        duration = "$years Years, $months Months,  $days Days";
      }
    }
  }

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
                  'Deleting this portfolio will remove all instruments associated with this portfolio. Are you sure you want to delete this portfolio?',
              function: () async {
                widget.dataObject.portfolios.remove(widget.dataObject.onPortfolio);

                widget.dataObject.databaseData['portfolios']
                    .removeWhere((portfolio) => portfolio['name'] == widget.dataObject.onPortfolio['name']);

                // widget.dataObject.portfolios.remove(widget.dataObject.portfolios.indexOf(data[]))

                await DatabaseService(uid: widget.dataObject.user.uid)
                    .updateUserData(data: widget.dataObject.databaseData);
                await LocalDataSet()
                    .writePortfolios(json.encode(DataObject().dataObjectToMap(widget.dataObject)));

                Navigator.pop(ctxt);
                Navigator.pop(context);
              },
            );
          });
    }

    _loadData();

    return CWScaffold(
      appBarTitle: 'Info',
      dataObject: widget.dataObject,
      isCenter: false,
      bottomAppBarBorderColour: false,
      body: CWListView(
        physics: ScrollPhysics(),
        children: [
          getPersonlise(),
          SizedBox(height: Units().mainSpacing),
          getInfo(),
          SizedBox(height: Units().mainSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CWApplyButton(
              isChange: isDataChanged,
              function: () async {
                if (isDataChanged) {
                  for (var portfolio in widget.dataObject.portfolios) {
                    if (portfolio['name'] == widget.onPortfolio['name']) {
                      for (var p in widget.dataObject.databaseData['portfolios']) {
                        if (p['name'] == widget.onPortfolio['name']) {
                          p['name'] = name;
                          portfolio['name'] = name;
                        }
                      }
                    }
                  }

                  final _auth = FirebaseAuth.instance;
                  User user = _auth.currentUser;

                  // print(widget.dataObject.databaseData);

                  // for (var p in widget.dataObject.databaseData['portfolios']) {
                  //   print(p['name']);
                  // }

                  await DatabaseService(uid: user.uid).updateChange(widget.dataObject);
                  isDataChanged = false;

                  setState(() {});
                }
              },
              dataObject: widget.dataObject,
            ),
          ),
          SizedBox(height: Units().mainSpacing * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _showConfirmPanel(),
                borderRadius: BorderRadius.circular(Units().circularRadius),
                child: Text(
                  'Delete',
                  style: Cust(
                      color: UserThemes(widget.dataObject.theme).textColorVarient.withOpacity(.3),
                      fontSize: 19,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: Units().mainSpacing * 2),
            ],
          )
        ],
      ),
    );
  }

  getPersonlise() {
    return Ink(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      decoration: CustomDecoration(
        widget.dataObject.theme,
      ).topWidgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Customise', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
                  ClipRRect(
                      child: Image.asset(
                    'assets/icons/edit.png',
                    width: 20,
                    height: 20,
                    color: UserThemes(widget.dataObject.theme).textColorVarient,
                  )),
                ],
              )),
          Row(
            children: [
              Text(
                'NAME',
                style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
              ),
              // SizedBox(height: 5),
              Flexible(
                child: TextFormField(
                  expands: false,

                  // focusNode: focusNode_0, validator: (txt) => txt.isEmpty ? 'Passwords Do not match' : null,
                  // inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                  validator: (txt) => txt.isEmpty ? 'Name field must not be empty' : null,
                  textAlign: TextAlign.end,
                  style: CustomTextStyles(widget.dataObject.theme).appBarTitleStyle,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isCollapsed: true,
                    hintStyle: CustomTextStyles(widget.dataObject.theme).appBarTitleStyle,
                    hintText: widget.onPortfolio['name'],
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorStyle: TextStyle(color: UserThemes(widget.dataObject.theme).redVarient),
                  ),
                  onChanged: (txt) {
                    if (txt != '') {
                      isDataChanged = true;
                    } else {
                      isDataChanged = false;
                    }

                    setState(() => name = txt);
                  },
                ),
              ),
            ],
          ),
       
        ],
      ),
    );
  }

  getInfo() {
    return Ink(
      padding: EdgeInsets.only(top: 15.0, bottom: 20, right: 15, left: 15),
      decoration: CustomDecoration(
        widget.dataObject.theme,
      ).baseContainerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Information', style: CustomTextStyles(widget.dataObject.theme).sectionHeader),
                ],
              )),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'INVESTED',
                style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
              ),
              // SizedBox(height: 5),
              Text(
                '${widget.dataObject.userCurrencySymbol}${widget.dataObject.onPortfolio['investedValue'].toStringAsFixed(2).toString().addCommas()}',
                style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child:
                Divider(thickness: .8, color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.5)),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'INCEPTION',
                style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
              ),
              // SizedBox(height: 5),
              Text(
                inceptionDate == null
                    ? ''
                    : '${CustomDateFormatter().weekdaysFull[(DateTime.parse(inceptionDate.toString()).weekday - 1)].toString()}, ${CustomDateFormatter().formatDateStyle(inceptionDate.toString())}',
                style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child:
                Divider(thickness: .8, color: UserThemes(widget.dataObject.theme).seperator.withOpacity(.5)),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'DURATION',
                style: CustomTextStyles(widget.dataObject.theme).holdingSubValueStyle,
              ),
              // SizedBox(height: 5),
              Text(
                duration,
                style: CustomTextStyles(widget.dataObject.theme).portfolioNameStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
