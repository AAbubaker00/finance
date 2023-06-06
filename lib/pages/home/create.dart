import 'package:valuid/models/portfolio/portfolio.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/pageLoaders/additionConfirm.dart';
import 'package:flutter/material.dart';
import 'package:valuid/shared/themes/themes.dart';

class CreatePortfolio extends StatefulWidget {
  final DataObject dataObject;

  const CreatePortfolio({Key? key, required this.dataObject}) : super(key: key);

  @override
  _CreatePortfolioState createState() => _CreatePortfolioState();
}

class _CreatePortfolioState extends State<CreatePortfolio> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode_0 = FocusNode();

  String name = '';

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      appBarTitle: 'Create portfolio',
      bottomAppBarBorderColour: true,
      scaffoldBgColour: BgTheme.LIGHT,
      body: CWListView(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: CustomTextStyles(widget.dataObject.context)
                      .holdingValueStyle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                TextFormField(
                    focusNode: focusNode_0,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles(widget.dataObject.context)
                        .overallCurrencyStyle
                        .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                    validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                    decoration: InputDecoration(
                      hintStyle: CustomTextStyles(widget.dataObject.context)
                          .overallCurrencyStyle
                          .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                      hintText: '...',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    onChanged: (txt) {
                      setState(() {
                        name = txt;
                      });
                    }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: CWApplyButton(
              btnText: 'CREATE',
              verticalPadding: 20,
              customTextColour: summaryColour,
              customTextStyle: CustomTextStyles(widget.dataObject.context)
                  .holdingValueStyle
                  .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
              function: () async {
                widget.dataObject.portfolios
                    .add(PortfolioObject.fromMap({'name': name, 'goal': 100000.0, 'holdings': []}));

                await DatabaseService(uid: widget.dataObject.user.uid)
                    .updateUserData(data: widget.dataObject);
                Navigator.pop(context);

                Navigator.push(
                    widget.dataObject.context,
                    CustomPageRouteSlideTransition(
                        direction: AxisDirection.left,
                        child: AdditionCompletedNotification(
                          name: name,
                          isStock: false,
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
