import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      scaffoldBgColour: ScaffoldBgColourOptions.LIGHT,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  child: Image.asset(
                'assets/icons/onvestLogo.png',
                width: 90,
                height: 90,
                // color: textColorVarient,
              )),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'All your investments in one place',
                  style: CustomTextStyles(context).overallValueStyle.copyWith(
                        color: chartTextColour,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                CWApplyButton(
                  isBgColurOn: false,
                  addBorder: true,
                  borderRadius: BorderRadius.circular(50),
                  btnText: 'Login with Google',
                  customColour: backgroundColour,
                  customTextColour: textColor,
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                    size: iconSize - 5,
                  ),
                ),
                SizedBox(height: 10),
                CWApplyButton(
                  isChange: true,
                  isBgColurOn: false,
                  addBorder: true,
                  customColour: backgroundColour,
                  borderRadius: BorderRadius.circular(50),
                  customTextColour: textColor,
                  icon: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                    color: iconColour,
                    size: iconSize - 5,
                  ),
                  btnText: 'Login with email',
                  function: () async {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
