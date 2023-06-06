import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      scaffoldBgColour: Scaffold,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 30, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    child: Image.asset(
                  'assets/icons/onvestLogo.png',
                  width: 90,
                  height: 90,
                  // color: textColorVarient,
                )),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Column(
                children: [
                  CWApplyButton(
                    isChange: true,
                    isBgColurOn: false,
                    verticalPadding: 20,
                    customTextColour: Colors.white,
                    icon: Icon(
                      Icons.email_rounded,
                      color: Colors.white,
                      size: iconSize - 5,
                    ),
                    btnText: 'Login with Email',
                    function: () async {
                      // if (_formKey.currentState.validate()) {
                      //   dynamic result =
                      //       await _auth.signInWithEmailAndPassword(_email, _password);

                      //   if (result == false) {
                      //     setState(() {
                      //       isWrongCred = true;
                      //     });
                      //   } else {
                      //     isWrongCred = false;

                      //     Navigator.pushAndRemoveUntil(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => Wrapper()),
                      //         (route) => false);
                      //   }
                      // }
                    },
                  ),
                  SizedBox(height: 10),
                  CWApplyButton(
                    isBgColurOn: false,
                    addBorder: true,
                    btnText: 'Login with Google',
                    customColour: summaryColour,
                    customTextColour: textColorVarient,
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: iconSize - 5,
                    ),
                    function: () async {
                      // dynamic result = await _auth.googleSinIn();

                      // if (result == false) {
                      //   setState(() {
                      //     isWrongCred = false;
                      //     isAccountExist = false;
                      //   });
                      // } else if (result.runtimeType == u.UserObject) {
                      //   Navigator.pushAndRemoveUntil(context,
                      //       MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
                      // }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
