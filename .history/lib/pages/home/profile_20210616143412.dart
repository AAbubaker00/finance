import 'dart:convert';

import 'package:Strice/models/user/user.dart';
import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/services/database/database.dart';
import 'package:Strice/shared/fileHandling.dart';
import 'package:Strice/shared/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String currency = '';
  String userUID = '';

  FocusNode focusNode_0 = FocusNode();
  FocusNode focusNode_1 = FocusNode();

  bool isDataChanged = false, isMainLoaded = false;
  bool isDark = true, isDelete = false, isLoaded = false;

  double _width;

  Map data;
  Map selectedCurrency;

  TextStyle headerStyle, subStyle;
  UserData user;

  loadData() {
    if (isLoaded == false) {
      setState(() {
        userUID = user.uid;
        email = user.email;
      });

      isLoaded = true;
    }
  }

  _deleteAccountDialog() {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            backgroundColor: DarkTheme(isDark).insideColour,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: DarkTheme(isDark).border),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Delete Account',
                    style: TextStyle(color: DarkTheme(isDark).goldVarient, fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Are you sure you want to delete your account?\nif you delete your account, you will permanently lose your data.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: DarkTheme(isDark).textColorVarient, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          User _u = FirebaseAuth.instance.currentUser;
                          User fireUser = _auth.currentUser;

                          if (fireUser.isAnonymous) {
                            dynamic result = await AuthService().deleteAnonUser();
                            if (result == null) {
                              print('error');
                            } else {
                              await LocalDataSet().writePortfolios('');
                              await LocalDataSet().writeStates('');

                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                              _showCompleted('Deletion Completed');
                            }
                          } else if (_u.providerData[0].providerId == 'google.com') {
                            dynamic result = await AuthService().deleteGoogleAccount();
                            if (result == null) {
                              print('error');
                            } else {
                              await LocalDataSet().writePortfolios('');
                              await LocalDataSet().writeStates('');

                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                              _showCompleted('Deletion Completed');
                            }
                          } else {
                            Navigator.pushNamed(context, '/del', arguments: {'data': data, 'isDark': isDark});
                          }
                        },
                        child: Text('DELETE ACCOUNT',
                            style: TextStyle(color: DarkTheme(isDark).redVarient, fontSize: 18)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Function _showCompletionFunction;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    data = ModalRoute.of(context).settings.arguments;
    // isDark = data['states']['dark'];

    headerStyle =
        TextStyle(fontSize: 18, color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w400);
    subStyle = TextStyle(fontSize: 16, color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400);

    void _showCompleted(String caption) {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  color: DarkTheme(isDark).insideColour,
                  border: Border.all(color: DarkTheme(isDark).border),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Deletion Completed',
                      style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    user = (Provider.of<UserData>(context));
    _showCompletionFunction = _showCompleted;

    loadData();

    return Container(
      color: DarkTheme(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: DarkTheme(isDark).backgroundColour,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 0.8),
            child: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour,
              ),
              backgroundColor: DarkTheme(isDark).backgroundColour,
              title: Text(
                'Account Details',
                style: TextStyle(color: DarkTheme(isDark).textColorVarient),
              ),
              centerTitle: true,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    width: _width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: DarkTheme(isDark).iconColour.withOpacity(.1), width: 1))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ACCOUNT ID',
                            style: headerStyle,
                          ),
                          Text(
                            userUID,
                            style: subStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: _width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: DarkTheme(isDark).iconColour.withOpacity(.1), width: 1))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EMAIL',
                            style: headerStyle,
                          ),
                          Text(
                            email,
                            style: subStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: DarkTheme(isDark).iconColour.withOpacity(.1), width: 1))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'USER NAME',
                            style: headerStyle,
                          ),
                          TextFormField(
                            expands: false,
                            // focusNode: focusNode_0, validator: (txt) => txt.isEmpty ? 'Passwords Do not match' : null,
                            // inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                            validator: (txt) => txt.isEmpty ? 'Name field must not be empty' : null,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20,
                                color: DarkTheme(isDark).textColor,
                                fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400),
                              hintText: data['userDetails']['userName'],
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 20,
                                color: DarkTheme(isDark).iconColour,
                              ),
                            ),
                            onChanged: (txt) {
                              if (name != '') {
                                isDataChanged = true;
                              } else {
                                isDataChanged = false;
                              }
                              setState(() => name = txt);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: _width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: DarkTheme(isDark).iconColour.withOpacity(.1), width: 1))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: InkWell(
                        splashColor: DarkTheme(isDark).reponseColour,
                        highlightColor: DarkTheme(isDark).reponseColour,
                        focusColor: DarkTheme(isDark).reponseColour,
                        hoverColor: DarkTheme(isDark).reponseColour,
                        onTap: () {
                          _deleteAccountDialog();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: DarkTheme(isDark).redVarient,
                              size: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Delete Account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: DarkTheme(isDark).redVarient,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          color: DarkTheme(isDark).goldVarient.withOpacity(isDataChanged ? 1 : .4),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate() && isDataChanged) {
                            await DatabaseService(uid: user.uid)
                                .updateUserData(portfolios: data['initalData']['portfolios'], userDetails: {
                              'userName': name.isEmpty ? data['userDetails']['userName'] : name,
                              'userEmail': email.isEmpty ? data['userDetails']['userEmail'] : email,
                              'baseCurrency': currency
                            });

                            data['userDetails']['userName'] =
                                name.isEmpty ? data['userDetails']['userName'] : name;
                            data['userDetails']['userEmail'] =
                                email.isEmpty ? data['userDetails']['userEmail'] : email;
                            data['userDetails']['baseCurrency'] = currency;

                            for (var portfolio in data['portfolios']) {
                              portfolio['baseCurrency'] = currency;
                            }

                            LocalDataSet().writePortfolios(json.encode(data));

                            Navigator.pop(context, true);
                          }
                        },
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: DarkTheme(true).textColorVarient.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            child: Text(
                              'KEEP ACCOUNT',
                              style: TextStyle(
                                  color: DarkTheme(isDark).textColorVarient, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: DarkTheme(isDark).goldVarient.withOpacity(isDataChanged ? 1 : .4),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'DELETE ACCOUNT',
                            style:
                                TextStyle(color: DarkTheme(isDark).redVarient, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: isDelete
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'vbtn0',
                      onPressed: () {
                        setState(() {
                          isDelete = false;
                        });
                      },
                      mini: true,
                      child: Icon(
                        Icons.close,
                        color: DarkTheme(isDark).redVarient,
                        size: 35,
                      ),
                      backgroundColor: DarkTheme(isDark).backgroundColour,
                      elevation: 5,
                    ),
                    FloatingActionButton(
                      heroTag: 'vbtn1',
                      onPressed: () async {
                        User _u = FirebaseAuth.instance.currentUser;
                      },
                      mini: true,
                      child: Icon(
                        Icons.done,
                        color: DarkTheme(isDark).greenVarient,
                        size: 35,
                      ),
                      backgroundColor: DarkTheme(isDark).backgroundColour,
                      elevation: 5,
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
