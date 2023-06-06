import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/shared/fileHandling.dart';
import 'package:Strice/shared/themes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                      '$caption',
                      style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    data = ModalRoute.of(context).settings.arguments;
    // isDark = data['isDark'];

    return Container(
      color: DarkTheme(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: DarkTheme(isDark).backgroundColour,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight((kToolbarHeight * .8)),
            child: AppBar(
              elevation: 0,
              backgroundColor: DarkTheme(isDark).backgroundColour,
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour, //change your color here
              ),
              title: Text('Account Deletion', style: TextStyle(color: DarkTheme(isDark).textColorVarient)),
              centerTitle: true,
            ),
          ),
          body: ListView(children: [
            Container(
              // decoration: BoxDecoration(color: DarkTheme(false).goldVarient),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/icons/del.png',
                      color: DarkTheme(isDark).textColor,
                      fit: BoxFit.contain,
                      scale: 3,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: DarkTheme(isDark).summaryColour, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "We're sorry to see you go. If you want to permanently delete your account click Delete Account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: DarkTheme(isDark).textColor, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          cursorColor: DarkTheme(isDark).backColour,
                          inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                          validator: (txt) => txt.isEmpty ? 'Enter email' : null,
                          style: TextStyle(
                              fontSize: 20,
                              color: DarkTheme(isDark).textColor,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 14, color: DarkTheme(true).textColorVarient),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: DarkTheme(true).border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: DarkTheme(true).redVarient,
                              )), border: InputBorder.none,
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
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashColor: DarkTheme(isDark).border,
                      dashRadius: 0.0,
                      dashGapLength: 4.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: TextFormField(
                          cursorColor: DarkTheme(isDark).backColour,
                          validator: (txt) => txt.isEmpty ? 'Enter Password' : null,
                          obscureText: true,
                          style: TextStyle(
                              fontSize: 20,
                              color: DarkTheme(isDark).textColor,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              labelText: 'Password',
                               labelStyle: TextStyle(fontSize: 14, color: DarkTheme(true).textColorVarient),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: DarkTheme(true).border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: DarkTheme(true).redVarient,
                              )),border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(
                                Icons.vpn_key_rounded,
                                color: DarkTheme(isDark).backColour,
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
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: DarkTheme(isDark).goldVarient, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Keep Account',
                    style: TextStyle(
                        color: DarkTheme(isDark).textColor, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    border: Border.all(color: DarkTheme(isDark).border, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var result = await AuthService().deleteUser(_email, _password);
                      if (result == true) {
                        await LocalDataSet().writePortfolios('');
                        await LocalDataSet().writeStates('');

                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        _showCompleted('Deletion Completed');
                      } else {
                        _showCompleted('Wrong Credentials');
                      }
                    }
                  },
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                        color: DarkTheme(isDark).redVarient, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
