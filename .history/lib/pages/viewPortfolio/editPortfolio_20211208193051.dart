import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/files/fileHandling.dart';
import 'package:Strice/shared/printFunctions/custom_Print_Functions.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPortfolio extends StatefulWidget {
  @override
  _EditPortfolioState createState() => _EditPortfolioState();
}

class _EditPortfolioState extends State<EditPortfolio> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String baseCurrency = '', name = '';
  Map data;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  bool isDataChanged = false, isMainLoaded = false;

  var isDark = true;

  TextStyle headerStyle, subStyle;

  _loadData() {
    if (isMainLoaded == false) {
      name = data['portfolio']['name'];
      baseCurrency = 'USD'; //data['portfolio']['base']

      isMainLoaded = true;
    }
  }

  UserData user;

  @override
  Widget build(BuildContext context) {
    void _showConfirmPanel() {
      showModalBottomSheet(
          // barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _confirmPanel();
          });
    }

    data = ModalRoute.of(context).settings.arguments;
    isDark = (data['data']['states']['theme']);
    user = (Provider.of<UserData>(context));

    _loadData();

    headerStyle =
        TextStyle(fontSize: 20, color: UserThemes(isDark).textColorVarient, fontWeight: FontWeight.w400);
    subStyle = TextStyle(fontSize: 20, color: UserThemes(isDark).textColor, fontWeight: FontWeight.w600);

    // print(data['portfolio']);

    return Container(
      color: UserThemes(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(isDark).backgroundColour,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: UserThemes(isDark).backColour, //change your color here
            ),
            elevation: 0,
            backgroundColor: UserThemes(isDark).backgroundColour,
            title: Text('Edit',
                style: TextStyle(
                    color: UserThemes(isDark).textColor, fontSize: 20, fontWeight: FontWeight.w400)),
            centerTitle: true,
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
                              'Edit,',
                              style: CustomTextStyles(themeMode)
                                  .portfolioNameStyle
                                  .copyWith(color: UserThemes(themeMode).textColorVarient, fontSize: 17),
                            ),
                            Text(
                              'Transaction',
                              style: CustomTextStyles(themeMode)
                                  .sectionHeader
                                  .copyWith(fontWeight: FontWeight.w500, fontSize: 40),
                            )
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
                              color: UserThemes(themeMode).greenVarient,
                              size: Units().headerIconSize,
                            )),
                      ],
                    ),
                  ),
                Container(
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
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Portfolio name:',
                                style: headerStyle,
                              ),
                              Expanded(
                                child: TextFormField(
                                    focusNode: focusNode_0,
                                    textAlign: TextAlign.end,
                                    style: subStyle,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: UserThemes(isDark).textColor, fontWeight: FontWeight.w400),
                                      hintText: name,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: UserThemes(isDark).border)),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (txt) {
                                      if (txt != '') {
                                        isDataChanged = true;
                                      } else {
                                        isDataChanged = false;
                                      }
                                      setState(() => name = txt);
                                    }),
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
                            children: [
                              Text(
                                'Currency:',
                                style: headerStyle,
                              ),
                              Expanded(
                                child: TextFormField(
                                  focusNode: focusNode_1,
                                  textAlign: TextAlign.end,
                                  enabled: false,
                                  style: subStyle,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: UserThemes(isDark).textColorVarient,
                                        fontWeight: FontWeight.w400),
                                    hintText: baseCurrency,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: UserThemes(isDark).border)),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  onChanged: (txt) => setState(() => baseCurrency = txt),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        color: UserThemes(isDark).purpleVarient.withOpacity(isDataChanged ? 1 : .4),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                        if (isDataChanged) {
                          for (var portfolio in data['data']['initalData']['portfolios']) {
                            if (portfolio['name'] == data['portfolio']['name']) {
                              if (name.isNotEmpty) {
                                portfolio['name'] = name;

                                for (var p in data['data']['portfolios']) {
                                  if (p['name'] == data['portfolio']['name']) {
                                    p['name'] = name;
                                  }
                                }
                              } else {
                                portfolio['name'] = data['portfolio']['name'];
                                for (var p in data['data']['portfolios']) {
                                  if (p['name'] == data['portfolio']['name']) {
                                    p['name'] = data['portfolio']['name'];
                                  }
                                }
                              }
                            }
                          }

                          //! Amy, Hi!!

                          await DatabaseService(uid: user.uid).updateUserData(
                              portfolios: data['data']['initalData']['portfolios'],
                              userDetails: data['data']['userDetails']);

                          LocalDataSet().writePortfolios(json.encode(data['data']));
                          Navigator.pop(context, true);
                        }
                      },
                      child: Text('Save Changes',
                          style: TextStyle(
                              color: isDataChanged
                                  ? UserThemes(isDark).textColor
                                  : UserThemes(isDark).textColorVarient,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () => _showConfirmPanel(),
                      child: Text('Delete Portfolio',
                          style: TextStyle(
                              color: UserThemes(isDark).redVarient,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
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

  _confirmPanel() {
    if (!mounted) return;

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(isDark).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                data['data']['portfolios'].remove(data['portfolio']);

                data['data']['initalData']['portfolios']
                    .removeWhere((portfolio) => portfolio['name'] == data['portfolio']['name']);

                await DatabaseService(uid: user.uid).updateUserData(
                    portfolios: data['data']['initalData']['portfolios'],
                    userDetails: data['data']['userDetails']);

                LocalDataSet().writePortfolios(json.encode(data));

                Navigator.pop(context);
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 20, color: UserThemes(isDark).greenVarient),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Ink(
            decoration: BoxDecoration(
              color: UserThemes(isDark).summaryColour,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: UserThemes(isDark).textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
