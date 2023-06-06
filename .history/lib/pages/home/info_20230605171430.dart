// ignore_for_file: unnecessary_statements

import 'package:valuid/services/database/database.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/files/fileHandler.dart';
import 'package:valuid/shared/pageLoaders/removalConfirm.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';

import 'package:flutter/material.dart';

class PortfolioInfo extends StatefulWidget {
  final DataObject dataObject;

  PortfolioInfo({Key? key, required this.dataObject}) : super(key: key);

  @override
  _PortfolioInfoState createState() => _PortfolioInfoState();
}

class _PortfolioInfoState extends State<PortfolioInfo> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode_0 = FocusNode();

  String name = '';

  @override
  Widget build(BuildContext context) {
    void _showConfirmPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) {
            return CWConfirmBottomSheetButton(
              context: ctxt,
              dataObject: widget.dataObject,
              btnText: 'Are you sure you want to delete ${widget.dataObject.onPortfolio!.name}?',
              function: () async {
                widget.dataObject.portfolios.remove(widget.dataObject.onPortfolio);

                await DatabaseService(uid: widget.dataObject.user.uid)
                    .updateUserData(data: widget.dataObject);

                widget.dataObject.portfolios.length > 0
                    ? widget.dataObject.onPortfolio = widget.dataObject.portfolios.first
                    : null;

                widget.dataObject.lastCalenderUpdate = '';
                widget.dataObject.earnings.clear();
                widget.dataObject.dividends.clear();

                await LocalDataSet().deleteLocalData();

                Navigator.pop(ctxt);
                Navigator.pop(context, 'delete');

                Navigator.push(
                    widget.dataObject.context,
                    CustomPageRouteSlideTransition(
                        direction: AxisDirection.left,
                        child: RemovalCompletedNotification(
                          name: widget.dataObject.onPortfolio!.name,
                          isStock: false,
                        )));
              },
            );
          });
    }

    return CWScaffold(
      isCenter: false,
      bottomAppBarBorderColour: true,
      // appbarColourOption: 2,
      scaffoldBgColour: BgTheme.LIGHT,
      appBarTitleWidget: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('Personalise', style: CustomTextStyles(widget.dataObject.context).appBarTitleStyle),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(buttonRadius),
              onTap: () => _showConfirmPanel(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    child: Image.asset(
                  'assets/icons/bin.png',
                  width: iconSize,
                  height: iconSize,
                  color: iconColour,
                )),
              ),
            )
          ],
        ),
      ),
      body: CWListView(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Name',
                style: CustomTextStyles(widget.dataObject.context)
                    .holdingValueStyle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: TextFormField(
                  focusNode: focusNode_0,
                  textAlign: TextAlign.center,
                  // keyboardType: TextInputType.number,
                  validator: (txt) {
                    if (txt!.isEmpty) {
                      return 'Name field cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  style: CustomTextStyles(widget.dataObject.context)
                      .overallCurrencyStyle
                      .copyWith(fontWeight: FontWeight.w800, color: blueVarient),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    hintStyle: CustomTextStyles(widget.dataObject.context)
                        .overallCurrencyStyle
                        .copyWith(fontWeight: FontWeight.w800, color: blueVarient.withOpacity(.3)),
                    hintText: widget.dataObject.onPortfolio!.name,
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: border)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  onChanged: (txt) {
                    setState(() => name = txt);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CWApplyButton(
              isChange: name != '',
              verticalPadding: 20,
              isBgColurOn: false,
              customTextColour: summaryColour,
              customTextStyle: CustomTextStyles(widget.dataObject.context)
                  .holdingValueStyle
                  .copyWith(letterSpacing: 1, color: summaryColour, fontWeight: FontWeight.w600),
              function: () async {
                if (_formKey.currentState!.validate()) {
                  widget.dataObject.onPortfolio!.name = name;
                  await DatabaseService(uid: widget.dataObject.user.uid)
                      .updateUserData(data: widget.dataObject);
                  Navigator.pop(context, 'name');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
