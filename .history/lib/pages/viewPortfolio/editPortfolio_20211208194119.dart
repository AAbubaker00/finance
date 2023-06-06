import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
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

  var themeMode = true;

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
    themeMode = (data['data']['states']['theme']);
    user = (Provider.of<UserData>(context));

    _loadData();

    headerStyle =
        TextStyle(fontSize: 20, color: UserThemes(themeMode).textColorVarient, fontWeight: FontWeight.w400);
    subStyle = TextStyle(fontSize: 20, color: UserThemes(themeMode).textColor, fontWeight: FontWeight.w600);

    // print(data['portfolio']);

    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(themeMode).backgroundColour,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: UserThemes(themeMode).backColour, //change your color here
            ),
            elevation: 0,
            backgroundColor: UserThemes(themeMode).backgroundColour,
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
                          Text(data['portfolio']['name'],
                              style: CustomTextStyles(themeMode).sectionSubTextStyle),
                          Text('Edit', style: CustomTextStyles(themeMode).pageHeaderStyle)
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
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
                                'NAME',
                                style: CustomTextStyles(themeMode).holdingSubValueStyle,
                              ),
                              Expanded(
                                child: TextFormField(
                                    focusNode: focusNode_0,
                                    textAlign: TextAlign.end,
                                    style: CustomTextStyles(themeMode).holdingValueStyle,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: UserThemes(themeMode).textColor,
                                          fontWeight: FontWeight.w400),
                                      hintText: name,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: UserThemes(themeMode).border)),
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
                        Divider(
                          color: UserThemes(themeMode).seperator,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CURRENCY',
                                style: CustomTextStyles(themeMode).holdingSubValueStyle,
                              ),
                              Expanded(
                                child: TextFormField(
                                  focusNode: focusNode_1,
                                  textAlign: TextAlign.end,
                                  enabled: false,
                                  style: CustomTextStyles(themeMode).holdingValueStyle,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: UserThemes(themeMode).textColorVarient,
                                        fontWeight: FontWeight.w400),
                                    hintText: baseCurrency,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: UserThemes(themeMode).border)),
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
                        color: UserThemes(themeMode).purpleVarient.withOpacity(isDataChanged ? 1 : .4),
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
                                  ? UserThemes(themeMode).textColor
                                  : UserThemes(themeMode).textColorVarient,
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
                              color: UserThemes(themeMode).redVarient,
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
              color: UserThemes(themeMode).summaryColour,
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
                      style: TextStyle(fontSize: 20, color: UserThemes(themeMode).greenVarient),
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
              color: UserThemes(themeMode).summaryColour,
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
                      style: TextStyle(fontSize: 20, color: UserThemes(themeMode).textColor),
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
