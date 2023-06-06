import 'package:valuid/services/Login/authentication.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  FocusNode focusNode_0 = FocusNode();

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool isChanged = false, isSent = false, isFromSet = false;

  String _email = '';
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Reset Password',
      bottomAppBarBorderColour: false,
      scaffoldBgColour: BgTheme.LIGHT,
      body: Form(
        key: _formKey,
        child: CWListView(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          centerWidget: isSent
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send_rounded, color: isFromSet ? Colors.green : blueVarient, size: 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Link Sent.',
                          style: CustomTextStyles(context).overallCurrencyStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          passwordRest,
                          style: CustomTextStyles(context).portfolioNameStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email',
                        style:
                            CustomTextStyles(context).holdingValueStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        focusNode: focusNode_0,
                        textAlign: TextAlign.center,
                        validator: (value) => value.isEmpty ? emptyEmail : null,
                        style: CustomTextStyles(context)
                            .overallCurrencyStyle
                            .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          isDense: true,
                          hintStyle: CustomTextStyles(context)
                              .overallCurrencyStyle
                              .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                          hintText: 'email',
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (txt) {
                          setState(() {
                            _email = txt.replaceAll(' ', '');
                            isChange = _email.isEmpty ? false : true;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: CWApplyButton(
                            btnText: 'Request',
                            verticalPadding: 17,
                            customTextColour: Colors.white,
                            isChange: isChange,
                            function: () {
                              if (_formKey.currentState.validate()) {
                                _auth.passwordReset(email: _email);
                                setState(() {
                                  isSent = true;
                                  isChanged = false;
                                });
                              }
                            }),
                      ),
                    ],
                  ),
              ),
        ),
      ),
    );
  }
}
