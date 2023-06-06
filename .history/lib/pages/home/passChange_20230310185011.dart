import 'package:Valuid/services/Login/authentication.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class PassChange extends StatefulWidget {
  final DataObject dataObject;

  const PassChange({Key key, this.dataObject}) : super(key: key);

  @override
  _PassChangeState createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {
  FocusNode focusNode_0 = FocusNode();
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool isChanged = false, isSent = false, isFromSet = false;
  var isDark = true;

  Map data = {};
  @override
  void initState() {
    super.initState();
  }

  String _email = '';
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Password reset link',
      dataObject: widget.dataObject,
      bottomAppBarBorderColour:false,
      body: CWListView(
        centerWidget: isSent
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send_rounded,
                          color: isFromSet ? Colors.green : blueVarient, size: 100),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Link Sent.',
                        style: CustomTextStyles( widget.dataObject.context)
                            .overallCurrencyStyle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'The email with further instructions was sent to the submitted email address.',
                        style: CustomTextStyles( widget.dataObject.context)
                            .sectionHeader,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              )
            : null,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
            decoration: CustomDecoration(
              
            ).baseContainerDecoration,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: CustomDecoration(
                      
                    ).baseContainerDecoration,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EMAIL',
                            style: CustomTextStyles( widget.dataObject.context)
                                .holdingSubValueStyle,
                          ),
                          Expanded(
                            child: TextFormField(
                                focusNode: focusNode_0,
                                textAlign: TextAlign.end,
                                  style: CustomTextStyles( widget.dataObject.context)
                            .sectionHeader,
                                validator: (value) => value.isEmpty ? 'Enter Eamil' : null,
                                decoration: InputDecoration(
                                  hintStyle:
                                      CustomTextStyles( widget.dataObject.context)
                                          .portfolioSubValuetyle,
                                  hintText: '...',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: border)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (txt) {
                                  setState(() {
                                    _email = txt;
                                    isChange = _email.isEmpty ? false : true;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: CWApplyButton(
                btnText: 'Request',
                customTextColour: Colors.white,
                dataObject: widget.dataObject,
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
    );
  }
}
