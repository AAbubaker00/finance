import 'package:valuid/pages/home/create.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final DataObject? dataObject;
  const EmptyList({this.dataObject});

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      body: Container(
          color: summaryColour,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  child: Image.asset('assets/icons/emptyPort.png',
                      width: 100, height: 100, color: chartTextColour)),
              SizedBox(height: 20),
             
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('No portfolio? No worries, create one and start tracking',
                    style: CustomTextStyles(context).overallCurrencyStyle.copyWith(
                          color: chartTextColour,
                        ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: CWApplyButton(
                    function: () => Navigator.push(
                        context,
                        CustomPageRouteSlideTransition(
                          direction: AxisDirection.left,
                          child: CreatePortfolio(
                            dataObject: dataObject,
                          ),
                        )),
                    verticalPadding: 20,
                    customTextColour: Colors.white,
                    btnText: 'CREATE'),
              )
            ],
          )),
    );
  }
}
