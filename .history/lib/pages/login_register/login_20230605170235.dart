import 'package:valuid/models/user/user.dart';
import 'package:valuid/pages/home/passwordReset.dart';
import 'package:valuid/pages/login_register/signup.dart';
import 'package:valuid/pages/wrapper.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:valuid/services/Login/authentication.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return CWScaffold(
      scaffoldBgColour: BgTheme.LIGHT,
      body: GestureDetector(
        onTap: () => setState(() {
          focusNode_1.unfocus();
          focusNode_2.unfocus();

          isActive = false;
          isActive2 = false;
        }),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListView(
              children: <Widget>[
                ClipRRect(
                    child: Image.asset(
                  'assets/icons/onvestLogo.png',
                  width: 110,
                  height: 110,
                  // color: textColorVarient,
                )),
                SizedBox(
                  height: 25,
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
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: [
                        TextFormField(
                          focusNode: focusNode_1,
                          onTap: () => setState(() => isActive = true),
                          validator: (txt) => txt.isEmpty ? emptyEmail : null,
                          inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                          style: CustomTextStyles(context).sectionHeader,
                          decoration: CustomInputDecoration('Email', context),
                          onChanged: (txt) {
                            setState(() => _email = txt);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          focusNode: focusNode_2,
                          onTap: () => setState(() => isActive2 = true),
                          validator: (txt) => txt!.length < 8 ? shortPassword : null,
                          inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                          obscureText: isPrivate,
                          style: CustomTextStyles(context).sectionHeader,
                          decoration: CustomInputDecoration('Password', context),
                          onChanged: (txt) {
                            setState(() => _password = txt);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: isWrongCred
                          ? Text(
                              wrongCred,
                              style: CustomTextStyles(context)
                                  .deleteTextStyle
                                  .copyWith(color: isWrongCred ? redVarient : Colors.transparent),
                              textAlign: TextAlign.center,
                            )
                          : isAccountExist
                              ? Container()
                              : Text(
                                  noAccount,
                                  style:
                                      CustomTextStyles(context).deleteTextStyle.copyWith(color: redVarient),
                                  textAlign: TextAlign.center,
                                ),
                    ),
                    Column(
                      children: [
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
                            if (_formKey.currentState!.validate()) {
                              dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);

                              if (result == null) {
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
                        SizedBox(height: 10),
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
                          function: () async {
                            dynamic result = await _auth.googleSinIn();

                            if (result == null) {
                              setState(() {
                                isWrongCred = false;
                                isAccountExist = false;
                              });
                            } else if (result.runtimeType == UserObject) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 30),
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
                        onTap: () => Navigator.pushReplacement(context,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
