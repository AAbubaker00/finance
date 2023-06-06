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

  int themeMode = 0;

  Map data = {};

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    void _showCompleted(String caption) {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  color: DarkTheme(themeMode).insideColour,
                  border: Border.all(color: DarkTheme(themeMode).border),
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
                      '$caption',
                      style: TextStyle(color: DarkTheme(themeMode).textColor, fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    data = ModalRoute.of(context).settings.arguments;
    themeMode = data['themeMode'];

    return Container(
      color: DarkTheme(themeMode).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight((kToolbarHeight * .8)),
            child: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: DarkTheme(themeMode).backColour, //change your color here
              ),
              backgroundColor: DarkTheme(themeMode).backgroundColour,
              title: Text('Delete Account', style: TextStyle(color: DarkTheme(themeMode).textColorVarient)),
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
                        color: DarkTheme(themeMode).backVarient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        cursorColor: DarkTheme(themeMode).backColour,
                        validator: (txt) => txt.isEmpty ? 'Enter email' : null,
                        style: TextStyle(
                            fontSize: 20, color: DarkTheme(themeMode).textColor, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: DarkTheme(themeMode).textColor),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            icon: Icon(
                              Icons.mail,
                              color: DarkTheme(themeMode).backColour,
                            )),
                        onChanged: (txt) {
                          setState(() => _email = txt);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: DarkTheme(themeMode).backVarient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          cursorColor: DarkTheme(themeMode).backColour,
                          validator: (txt) => txt.isEmpty ? 'Enter Password' : null,
                          obscureText: true,
                          style: TextStyle(
                              fontSize: 20, color: DarkTheme(themeMode).textColor, fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: DarkTheme(themeMode).textColor),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(
                                Icons.mail,
                                color: DarkTheme(themeMode).backColour,
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
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var result = await AuthService().deleteUser(_email, _password);
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                if (result == true) {
                  _showCompleted('Deletion Completed');
                } else {
                  _showCompleted('Wrong Credentials');
                }
              }
            },
            child: Icon(
              Icons.delete,
              color: DarkTheme(themeMode).redVarient,
              size: 35,
            ),
            backgroundColor: DarkTheme(themeMode).backgroundColour,
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
