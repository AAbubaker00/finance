import 'package:Valuid/pages/home/passwordReset.dart';
import 'package:Valuid/pages/login_register/signup.dart';
import 'package:Valuid/pages/wrapper.dart';
import 'package:Valuid/services/Login/authentication.dart';
import 'package:Valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
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

  getEmailLoginForm() {
    showModalBottomSheet(
        context: context,
        builder: (ctxt) {
          return MainCustomBottomSheet(
            customHeight: true,
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      decoration: CustomDecoration().curvedContainerDecoration.copyWith(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            width: .7,
                            color: isActive ? blueVarient : seperator.withOpacity(.7),
                          )),
                      child: TextFormField(
                        focusNode: focusNode_1,
                        onTap: () => setState(() => isActive = true),
                        validator: (txt) => txt.isEmpty ? 'Email section cannot be empty' : null,
                        inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                        style: CustomTextStyles(context).sectionHeader,
                        decoration: CustomInputDecoration('Email', context),
                        onChanged: (txt) {
                          setState(() => _email = txt);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      decoration: CustomDecoration().curvedContainerDecoration.copyWith(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            width: .7,
                            color: isActive2 ? blueVarient : seperator.withOpacity(.7),
                          )),
                      child: TextFormField(
                        focusNode: focusNode_2,
                        onTap: () => setState(() => isActive2 = true),
                        validator: (txt) => txt.length < 8 ? 'Enter passowrd longer than 8' : null,
                        inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                        obscureText: isPrivate,
                        style: CustomTextStyles(context).sectionHeader,
                        decoration: CustomInputDecoration('Password', context),
                        onChanged: (txt) {
                          setState(() => _password = txt);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => PasswordReset()));
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Forgot Password?",
                                style: CustomTextStyles(context)
                                    .holdingSubValueStyle
                                    .copyWith(color: blueVarient),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: isWrongCred
                          ? Text(
                              'The entered email and password does match with any of the accounts in your system. Make sure your details are correct or try creating a new account. If issue has not been resolved please contact us',
                              style: CustomTextStyles(context)
                                  .deleteTextStyle
                                  .copyWith(color: isWrongCred ? redVarient : Colors.transparent),
                              textAlign: TextAlign.center,
                            )
                          : isAccountExist
                              ? Container()
                              : Text(
                                  'The account does not exist. Enter a different account or create a different account.',
                                  style:
                                      CustomTextStyles(context).deleteTextStyle.copyWith(color: redVarient),
                                  textAlign: TextAlign.center,
                                ),
                    ),
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
                      function: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);

                          if (result == false) {
                            setState(() {
                              isWrongCred = true;
                            });
                          } else {
                            isWrongCred = false;

                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                  function: () => getEmailLoginForm(),
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
