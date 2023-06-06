import 'package:Valuid/pages/home/passwordReset.dart';
import 'package:Valuid/pages/login_register/signup.dart';
import 'package:Valuid/services/Login/authentication.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isEmailLogin = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //! Email and Password data
  String _email = '';
  String _password = '';

  bool isWrongCred = false;
  bool isActive = false;
  bool isActive2 = false;
  bool isPrivate = true;
  bool isAccountExist = true;

  FocusNode focusNode_1 = FocusNode();
  FocusNode focusNode_2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ink(
                decoration: CustomDecoration().baseContainerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              )
            ],
          );
        });

    return CWScaffold(
      scaffoldBgColour: ScaffoldBgColourOptions.LIGHT,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                      child: Image.asset(
                    'assets/icons/onvestLogo.png',
                    width: 120,
                    height: 120,
                    // color: textColorVarient,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Investing is difficult.',
                    style: CustomTextStyles(context)
                        .calenderDateTextStyle
                        .copyWith(color: textColor.withOpacity(.5)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Tracking shouldn't be.",
                    style: CustomTextStyles(context)
                        .calenderDateTextStyle
                        .copyWith(color: textColor.withOpacity(.7), fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CWApplyButton(
                  isBgColurOn: false,
                  borderRadius: BorderRadius.circular(50),
                  btnText: 'Login with Google',
                  verticalPadding: 17,
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
                  verticalPadding: 17,
                  customColour: backgroundColour,
                  borderRadius: BorderRadius.circular(50),
                  customTextColour: textColor,
                  icon: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                    color: iconColour,
                    size: iconSize - 5,
                  ),
                  btnText: 'Login with email',
                  function: () => setState(() => isEmailLogin = true),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Need an account?",
                          style: CustomTextStyles(context)
                              .holdingSubValueStyle
                              .copyWith(color: textColorVarient)),
                      SizedBox(width: 5),
                      InkWell(
                        borderRadius: BorderRadius.circular(circularRadius),
                        onTap: () => Navigator.push(context,
                            CustomPageRouteSlideTransition(direction: AxisDirection.left, child: SignUp())),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("SIGN UP",
                              style: CustomTextStyles(context)
                                  .portfolioNameStyle
                                  .copyWith(color: blueVarient, fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
