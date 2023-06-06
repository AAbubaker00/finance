import 'package:Strice/pages/wrapper.dart';
import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/shared/loading.dart';
import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void dispose() {
    if (!mounted) return;
    super.dispose();
  }

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  //! Email and Password data
  String email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme(false).goldVarient,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 70),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/icons/wasd.png',
                      color: DarkTheme(false).backColour,
                      fit: BoxFit.contain,
                      scale: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: DarkTheme(false).goldVarient_2,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          cursorColor: DarkTheme(false).backColour,
                          validator: (txt) => txt.isEmpty ? 'Enter email' : null,
                          inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: DarkTheme(false).backColour),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(
                                Icons.mail,
                                color: DarkTheme(false).backColour,
                              )),
                          onChanged: (txt) {
                            setState(() => email = txt);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: DarkTheme(false).goldVarient_2,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            cursorColor: DarkTheme(false).backColour,
                            validator: (txt) => txt.length < 6 ? 'Enter passowrd longer than 6' : null,
                            inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                            style: TextStyle(fontSize: 20),
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: DarkTheme(false).backColour),
                                border: InputBorder.none,
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: ButtonTheme(
                      height: 50,
                      minWidth: 140,
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            dynamic result = await _auth.signInWithEmailAndPassword(email, _password);

                            if (result == null) {
                              Future.delayed(Duration(seconds: 3, (){});
                            } else {
                              // Navigator.pop(context);

                              return Wrapper();
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: DarkTheme(false).backColour,
                        child: Text(
                          "Login In",
                          style: TextStyle(color: DarkTheme(false).goldVarient),
                        ),
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                  ),
                  ButtonTheme(
                    height: 50,
                    minWidth: 140,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: DarkTheme(false).backColour,
                      child: Text(
                        "Register",
                        style: TextStyle(color: DarkTheme(false).goldVarient),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/passReset');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: DarkTheme(false).backColour, fontWeight: FontWeight.w800),
                      )))
            ],
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
          // floatingActionButton: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     FloatingActionButton(
          //       backgroundColor: Colors.transparent,
          //       elevation: 0,
          //       onPressed: () {},
          //       child: ClipRRect(
          //         child: Image.asset(
          //           'assets/icons/google.png',
          //           color: DarkTheme(false).backColour,
          //           fit: BoxFit.scaleDown,
          //           scale: 30,
          //           height: 40,
          //         ),
          //       ),
          //     )
          // ],
          // ),
        ),
      ),
    );
  }
}
