import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/shared/loading.dart';
import 'dart:io';
import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void dispose() {
    if (!mounted) return;
    super.dispose();
  }

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isAccepted = false;

  //! Email data
  String _email;
  String _password;
  // ignore: unused_field
  String _name;

  String error;

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MainLoading();
    } else {
      return Container(
        color: DarkTheme(false).goldVarient_2,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: DarkTheme(false).backgroundColour,
          resizeToAvoidBottomInset: true,
          body: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: DarkTheme(false).goldVarient_2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Center(
                          // padding: EdgeInsets.only(top: 100.0, bottom: 0),
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/icons/sss.png',
                              color: DarkTheme(false).backColour,
                              fit: BoxFit.contain,
                              scale: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                        decoration: BoxDecoration(
                            color: DarkTheme(false).backgroundColour,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: DarkTheme(false).border.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextFormField(
                                  cursorColor: DarkTheme(false).backColour,
                                  validator: (txt) => txt.isEmpty ? 'Enter Name' : null,
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(color: DarkTheme(false).backColour),
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      icon: Icon(
                                        Icons.person,
                                        color: DarkTheme(false).backColour,
                                      )),
                                  onChanged: (txt) {
                                    setState(() => _name = txt);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: DarkTheme(false).border.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextFormField(
                                    cursorColor: DarkTheme(false).backColour,
                                    validator: (txt) => txt.isEmpty ? 'Enter Name' : null,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                    ],
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(color: DarkTheme(false).backColour),
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        icon: Icon(
                                          Icons.mail,
                                          color: DarkTheme(false).backColour,
                                        )),
                                    onChanged: (txt) {
                                      setState(() => _email = txt);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: DarkTheme(false).border.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  cursorColor: DarkTheme(false).backColour,
                                  validator: (txt) =>
                                      txt.length < 6 ? 'Passowrd Must be at least 6 characters Long' : null,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                  ],
                                  style: TextStyle(fontSize: 20),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(color: DarkTheme(false).backColour),
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      icon: Icon(
                                        Icons.lock,
                                        color: DarkTheme(false).backColour,
                                      )),
                                  onChanged: (txt) {
                                    setState(() => _password = txt);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: DarkTheme(false).border.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    cursorColor: DarkTheme(false).backColour,
                                    validator: (txt) => txt != _password ? 'Passwords Do not match' : null,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                    ],
                                    style: TextStyle(fontSize: 20),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(color: DarkTheme(false).backColour),
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        icon: Icon(
                                          Icons.lock,
                                          color: DarkTheme(false).backColour,
                                        )),
                                    onChanged: (txt) {},
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('By creating an account, you are agreeing to our',
                                      style: TextStyle(fontSize: 15)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/terms');
                                        },
                                        child: Text(
                                          'Terms of Service',
                                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        ' and ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/privacy');
                                        },
                                        child: Text(
                                          'Privacy Policy',
                                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonTheme(
                    height: 50,
                    minWidth: 140,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: DarkTheme(false).goldVarient_2,
                      child: Text(
                        'Register',
                        style: TextStyle(color: DarkTheme(false).backColour),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.registerWithEmailAndPassword(
                              email: _email, password: _password, name: _name);

                          if (result == null) {
                            setState(() {
                              // loading = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            Navigator.pushReplacementNamed(context, '/wrapper');
                          }
                        }
                      },
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Log In',
                          style: TextStyle(color: DarkTheme(false).backColour, fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          ),
        )),
      );
    }
  }
}
