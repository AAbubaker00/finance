import 'package:valuid/pages/login_register/verify.dart';
import 'package:valuid/pages/wrapper.dart';
import 'package:valuid/services/Login/authentication.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/inputDecoration/inputDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  //! Email and Password data
  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  late String error;

  FocusNode focusNode_1 = FocusNode();
  FocusNode focusNode_2 = FocusNode();
  FocusNode focusNode_3 = FocusNode();
  FocusNode focusNode_4 = FocusNode();

  bool isError = false;

  bool isActive = false;
  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;

  bool isEqual = false, isLong = false;

  checkPassword() {
    setState(() {
      if (_password == _passwordConfirm) {
        isEqual = true;
      } else {
        isEqual = false;
      }

      isLong = _password.length >= 8 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _emailValidate() {
      showModalBottomSheet(
          context: context,
          builder: (ctxt) => CWConfirmBottomSheetButton(
                context: ctxt,
                btnText: 'A validation code will be sent to the entered email, $_email, is this correct?',
                isRed: false,
                function: () async {
                  dynamic result =
                      await _auth.registerWithEmailAndPassword(email: _email, password: _password);

                  print(result);

                  if (result == null) {
                    setState(() {
                      isError = true;
                    });
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => VerifyScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
              ));
    }

    return CWScaffold(
      scaffoldBgColour: BgTheme.LIGHT,
      body: GestureDetector(
        onTap: () => setState(() {
          focusNode_1.unfocus();
          focusNode_2.unfocus();
          focusNode_3.unfocus();
          focusNode_4.unfocus();

          isActive = false;
          isActive1 = false;
          isActive2 = false;
          isActive3 = false;
        }),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Create Account",
                                style: CustomTextStyles(context)
                                    .calenderDateTextStyle
                                    .copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Sign up to get started!",
                              style: CustomTextStyles(context).seeAllTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Column(
                            children: [
                              TextFormField(
                                validator: (txt) => txt!.isEmpty ? emptyEmail : null,
                                onTap: () => setState(() => isActive1 = true),
                                focusNode: focusNode_2,
                                inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                style: CustomTextStyles(context).sectionHeader,
                                onChanged: (txt) {
                                  setState(() => _email = txt);
                                },
                                decoration: CustomInputDecoration('Email', context),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                obscureText: true,
                                focusNode: focusNode_3,
                                onTap: () => setState(() => isActive2 = true),
                                validator: (txt) => txt!.length < 8 ? shortPassword : null,
                                inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                style: CustomTextStyles(context).sectionHeader,
                                onChanged: (txt) {
                                  _password = txt;
                                  checkPassword();
                                },
                                decoration: CustomInputDecoration('Password', context),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                obscureText: true,
                                focusNode: focusNode_4,
                                validator: (txt) => txt != _password ? 'Passwords Do not match' : null,
                                onTap: () => setState(() => isActive3 = true),
                                inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                                style: CustomTextStyles(context).sectionHeader,
                                onChanged: (txt) {
                                  _passwordConfirm = txt;
                                  checkPassword();
                                },
                                decoration: CustomInputDecoration('Confirm Password', context),
                              ),
                            ],
                          ),
                          isError
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'An error has occured. Make sure your email is in the correct format.',
                                    style: CustomTextStyles(context)
                                        .deleteTextStyle
                                        .copyWith(color: isError ? redVarient : Colors.transparent),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                            child: CWApplyButton(
                              isBgColurOn: false,
                              verticalPadding: 17,
                              borderRadius: BorderRadius.circular(50),
                              btnText: 'Create Account',
                              customTextColour: Colors.white,
                              function: () async {
                                if (_formKey.currentState!.validate() && isLong && isEqual) {
                                  _emailValidate();
                                }
                              },
                            ),
                          ),
                          CWApplyButton(
                            isBgColurOn: false,
                            verticalPadding: 17,
                            borderRadius: BorderRadius.circular(50),
                            btnText: 'Register with Google',
                            customColour: backgroundColour,
                            customTextColour: textColor,
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                              size: iconSize - 5,
                            ),
                            function: () async {
                              dynamic result = await _auth.googleSignUp();

                              if (result == null) {
                                setState(() {
                                  isError = true;
                                });
                                print('error');
                              } else {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => Wrapper()),
                                    (Route<dynamic> route) => false);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text: 'By Registering you agree and acknowledge our',
                                          style: CustomTextStyles(context).disclaimerTextStyle,
                                        ),
                                        TextSpan(
                                          text: ' Terms of Use',
                                          style: CustomTextStyles(context)
                                              .disclaimerTextStyle
                                              .copyWith(color: blueVarient),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              if (await canLaunchUrl(Uri.parse(
                                                  'https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO')))
                                                await launchUrl(Uri.parse(
                                                    'https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO'));
                                              else
                                                throw "Could not launch https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO";
                                            },
                                        ),
                                        TextSpan(
                                          text: ' and ',
                                          style: CustomTextStyles(context).disclaimerTextStyle,
                                        ),
                                        TextSpan(
                                            text: 'Privacy Notice',
                                            style: CustomTextStyles(context)
                                                .disclaimerTextStyle
                                                .copyWith(color: blueVarient),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                if (await canLaunchUrl(Uri.parse(
                                                    'https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO')))
                                                  await launchUrl(Uri.parse(
                                                      'https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO'));
                                                else
                                                  throw "Could not launch https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO";
                                              }),
                                        TextSpan(
                                          text: '.',
                                          style: CustomTextStyles(context).disclaimerTextStyle,
                                        ),
                                      ])),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already a member?",
                          style: CustomTextStyles(context)
                              .holdingSubValueStyle
                              .copyWith(color: textColorVarient)),
                      SizedBox(width: 5),
                      InkWell(
                        borderRadius: BorderRadius.circular(circularRadius),
                        onTap: () => Navigator.push(context,
                            CustomPageRouteSlideTransition(direction: AxisDirection.left, child: Login())),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("LOGIN",
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
