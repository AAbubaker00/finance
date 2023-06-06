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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    child: Image.asset(
                  'assets/icons/onvestLogo.png',
                  width: 100,
                  height: 100,
                  // color: textColorVarient,
                )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Investing is difficult.',
                  style: CustomTextStyles(context).calenderDateTextStyle.copyWith(
                        color: textColor.withOpacity(.5),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Tracking shouldn't be.",
                  style: CustomTextStyles(context)
                      .calenderDateTextStyle
                      .copyWith(color: textColor.withOpacity(.8), fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
}
