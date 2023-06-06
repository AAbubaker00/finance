import 'package:Valuid/services/database/database.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';

import 'package:flutter/material.dart';

class PortfolioInfo extends StatefulWidget {
  final DataObject dataObject;

  PortfolioInfo({Key key, this.dataObject}) : super(key: key);

  @override
  _PortfolioInfoState createState() => _PortfolioInfoState();
}

class _PortfolioInfoState extends State<PortfolioInfo> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';

  FocusNode focusNode_0 = FocusNode();

  bool isDataChanged = false;

  @override
  Widget build(BuildContext context) {
    void showDeletePanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) {
            return CWConfirmBottomSheetButton(
              dataObject: widget.dataObject,
              context: ctxt,
              btnText:
                  'Deleting this portfolio will remove all instruments associated with this portfolio. Are you sure you want to delete this portfolio?',
              function: () async {
                print(widget.dataObject.portfolios.length);
                widget.dataObject.portfolios.remove(widget.dataObject.onPortfolio);
                print(widget.dataObject.portfolios.length);

               
                await DatabaseService().updateUserData(data: widget.dataObject.databaseData);

                Navigator.pop(ctxt);
                Navigator.pop(context, true);
              },
            );
          });
    }

    return CWScaffold(
      dataObject: widget.dataObject,
      isCenter: false,
      bottomAppBarBorderColour: true,
      // appbarColourOption: 2,
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      appBarTitleWidget: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('Personalise',
                  style:
                      CustomTextStyles( widget.dataObject.context).appBarTitleStyle),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(buttonRadius),
              onTap: () => showDeletePanel(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    child: Image.asset(
                  'assets/icons/bin.png',
                  width: 20,
                  height: 20,
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
                style: CustomTextStyles( widget.dataObject.context)
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
                    if (txt.isEmpty) {
                      return 'Purchase price cannot be empty or lower than 0.';
                    } else {
                      return null;
                    }
                  },
                  style: CustomTextStyles( widget.dataObject.context)
                      .overallCurrencyStyle
                      .copyWith(
                          fontWeight: FontWeight.w800,
                          color: blueVarient),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    hintStyle: CustomTextStyles( widget.dataObject.context)
                        .overallCurrencyStyle
                        .copyWith(
                            fontWeight: FontWeight.w800,
                            color: blueVarient.withOpacity(.3)),
                    hintText: widget.dataObject.onPortfolio['name'],
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: border)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  onChanged: (txt) {
                    if (txt != '') {
                      isDataChanged = true;
                    } else {
                      isDataChanged = false;
                      name = widget.dataObject.onPortfolio['name'];
                    }

                    setState(() => name = txt);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CWApplyButton(
              isChange: isDataChanged,
              verticalPadding: 20,
              isBgColurOn: false,
              customTextColour: summaryColour,
              customTextStyle: CustomTextStyles( widget.dataObject.context)
                  .holdingValueStyle
                  .copyWith(
                      letterSpacing: 1,
                      color: summaryColour,
                      fontWeight: FontWeight.w600),
              function: () async {
                if (_formKey.currentState.validate()) {
                  widget.dataObject.databaseData['portfolios'].firstWhere(
                          (portfolio) => portfolio['name'] == widget.dataObject.onPortfolio['name'])['name'] =
                      name;

                  widget.dataObject.onPortfolio['name'] = name;

                  await DatabaseService().updateChange(widget.dataObject);

                  name = '';

                  Navigator.pop(context, true);

                  setState(() {});
                }
              },
              dataObject: widget.dataObject,
            ),
          ),
        ],
      ),
    );
  }
}
