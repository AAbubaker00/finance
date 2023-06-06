import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                  ],
                                  style: CustomTextStyles(context).sectionHeader,
                                  decoration:
                                      CustomInputDecoration('Email', context),
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                  ],
                                  obscureText: isPrivate,
                                  style: CustomTextStyles(context).sectionHeader,
                                  decoration:
                                      CustomInputDecoration('Password', context),
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
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PasswordReset()));
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
                                            style: CustomTextStyles(context)
                                                .deleteTextStyle
                                                .copyWith(color: redVarient),
                                            textAlign: TextAlign.center,
                                          ),
                              ),
                            ],
                          ),
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
                                  if (_formKey.currentState.validate()) {
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(_email, _password);

                                    if (result == false) {
                                      setState(() {
                                        isWrongCred = true;
                                      });
                                    } else {
                                      isWrongCred = false;

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => Wrapper()),
                                          (route) => false);
                                    }
                                  }
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
                                  dynamic result = await _auth.googleSinIn();

                                  if (result == false) {
                                    setState(() {
                                      isWrongCred = false;
                                      isAccountExist = false;
                                    });
                                  } else if (result.runtimeType == u.UserObject) {
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
                                  }
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