import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  DeleteAccount({Key key}) : super(key: key);

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool isDark = true;

  Map data = {};

  String _email = '';

  @override
  Widget build(BuildContext context) {
    void _showCompleted() {
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
                      'Password reset link sent to:',
                      style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20),
                    ),
                    Text(
                      ' $_email',
                      style: TextStyle(
                          color: DarkTheme(isDark).textColor, fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Container(
      color: DarkTheme(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight((kToolbarHeight * .8)),
            child: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour, //change your color here
              ),
              backgroundColor: DarkTheme(isDark).backgroundColour,
              title: Text('Rest Password', style: TextStyle(color: DarkTheme(isDark).textColor)),
              centerTitle: true,
            ),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: DarkTheme(isDark).backVarient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        cursorColor: DarkTheme(isDark).backColour,
                        validator: (txt) => txt.isEmpty ? 'Enter email' : null,
                        style: TextStyle(
                            fontSize: 20, color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: DarkTheme(isDark).textColor),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            icon: Icon(
                              Icons.mail,
                              color: DarkTheme(isDark).backColour,
                            )),
                        onChanged: (txt) {
                          setState(() => _email = txt);
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,),
                        decoration: BoxDecoration(
                          color: DarkTheme(isDark).backVarient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          cursorColor: DarkTheme(isDark).backColour,
                          validator: (txt) => txt.isEmpty ? 'Enter Password' : null,
                          style: TextStyle(
                              fontSize: 20, color: DarkTheme(isDark).textColor, fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: DarkTheme(isDark).textColor),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(
                                Icons.mail,
                                color: DarkTheme(isDark).backColour,
                              )),
                          onChanged: (txt) {
                            setState(() => _email = txt);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // _auth.passwordReset(email: _email);
                _showCompleted();
              }
            },
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 35,
            ),
            backgroundColor: DarkTheme(isDark).backgroundColour,
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
