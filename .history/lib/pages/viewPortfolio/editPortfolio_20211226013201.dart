import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/dataObject/data_object.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:Strice/shared/files/fileHandling.dart';
import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Strice/extensions/stringExt.dart' as str;

class EditPortfolio extends StatefulWidget {
  final DataObject dataObject;

  const EditPortfolio({Key key, this.dataObject}) : super(key: key);

  @override
  _EditPortfolioState createState() => _EditPortfolioState();
}

class _EditPortfolioState extends State<EditPortfolio> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String baseCurrency = '', name = '';
  Map data;

  FocusNode focusNode_0 = FocusNode(), focusNode_1 = FocusNode();

  bool isDataChanged = false, isMainLoaded = false;

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
          context: widget.dataObject.context,
          builder: (context) {
            return _confirmPanel();
          });
    }

    data = ModalRoute.of(context).settings.arguments;

    user = (Provider.of<UserData>(context));

    _loadData();

    headerStyle = TextStyle(
        fontSize: 20,
        color: UserThemes(widget.dataObject.themeMode).textColorVarient,
        fontWeight: FontWeight.w400);
    subStyle = TextStyle(
        fontSize: 20, color: UserThemes(widget.dataObject.themeMode).textColor, fontWeight: FontWeight.w600);

    // print(data['portfolio']);

    return Container(
      color: UserThemes(widget.dataObject.themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: UserThemes(widget.dataObject.themeMode).backColour, //change your color here
            ),
            elevation: 0,
            backgroundColor: UserThemes(widget.dataObject.themeMode).backgroundColour,
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
                              style: CustomTextStyles(widget.dataObject.themeMode).sectionSubTextStyle),
                          Text('Info', style: CustomTextStyles(widget.dataObject.themeMode).pageHeaderStyle)
                        ],
                      ),
                      InkWell(
                        onTap: () => _showConfirmPanel(),
                        child: Icon(
                          Icons.delete,
                          color: UserThemes(widget.dataObject.themeMode).redVarient,
                          size: Units().headerIconSize,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        // Container(
                        //   width: widget.dataObject.width,
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(vertical: 10.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           'CURRENCY',
                        //           style: CustomTextStyles(widget.dataObject.themeMode).holdingSubValueStyle,
                        //         ),
                        //         SizedBox(height: 5),
                        //         Text(
                        //           widget.dataObject.userCurrency,
                        //           style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          width: widget.dataObject.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'INVESTED',
                                  style: CustomTextStyles(widget.dataObject.themeMode).holdingSubValueStyle,
                                ),
                                SizedBox(height: 5),
                                Text(
                                '${widget.dataObject.userCurrencySymbol}${data['portfolio']['investedValue'].toStringAsFixed(2)}',
                                  style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: widget.dataObject.width,
                          child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'NAME',
                                        style: CustomTextStyles(widget.dataObject.themeMode)
                                            .holdingSubValueStyle,
                                      ),
                                      TextFormField(
                                          expands: false,
                                          // focusNode: focusNode_0, validator: (txt) => txt.isEmpty ? 'Passwords Do not match' : null,
                                          // inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                          validator: (txt) =>
                                              txt.isEmpty ? 'Name field must not be empty' : null,
                                          textAlign: TextAlign.start,
                                          style: CustomTextStyles(widget.dataObject.themeMode)
                                              .portfolioNameStyle,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: UserThemes(widget.dataObject.themeMode).textColor,
                                                fontWeight: FontWeight.w400),
                                            hintText: name,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.all(0),
                                            errorStyle: TextStyle(
                                                color: UserThemes(widget.dataObject.themeMode).redVarient),
                                          ),
                                          onChanged: (txt) {
                                            if (txt != '') {
                                              isDataChanged = true;
                                            } else {
                                              isDataChanged = false;
                                            }
                                            setState(() => name = txt);
                                          }),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 19,
                                  color: UserThemes(widget.dataObject.themeMode).iconColour,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Units().circularRadius),
                    ),
                    onTap: () async {
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
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, top: 15, bottom: 15, right: 10),
                      decoration: BoxDecoration(
                          color: UserThemes(widget.dataObject.themeMode)
                              .greenVarient
                              .withOpacity(isDataChanged ? .8 : .2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Apply',
                            style: CustomTextStyles(widget.dataObject.themeMode).sectionHeader,
                          ),
                        ],
                      ),
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Units().circularRadius),
                color: UserThemes(widget.dataObject.themeMode).redVarient.withOpacity(.08)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Deleting this portfolio will remove all instruments associated with this portfolio. Are you sure you want to delete this portfolio?',
                    style: CustomTextStyles(widget.dataObject.themeMode).feedDescriptonStyle,
                  ),
                ),
                InkWell(
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
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: UserThemes(widget.dataObject.themeMode).seperator.withOpacity(.5)))),
                    padding: EdgeInsets.only(left: 10.0, top: 15, bottom: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm',
                          style: CustomTextStyles(widget.dataObject.themeMode).portfolioNameStyle.copyWith(
                              color: UserThemes(widget.dataObject.themeMode).redVarient,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Ink(
            decoration: CustomDecoration(widget.dataObject.themeMode, false).baseContainerDecoration,
            padding: EdgeInsets.only(left: 10.0, top: 20, bottom: 20, right: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20, color: UserThemes(widget.dataObject.themeMode).textColor),
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
