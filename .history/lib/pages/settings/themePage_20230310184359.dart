
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/files/fileHandler.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  final DataObject dataObject;

  const ThemePage({Key key, this.dataObject}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  void dispose() {
    OverlayTheme(widget.dataObject.theme).setOverlayTheme();

    super.dispose();
  }

  List themes = [
    {'id': 'Dark', 'value': true},
    {'id': 'Light', 'value': false},
  ];

  @override
  Widget build(BuildContext context) {
    // print(widget.dataObject.theme);

    return CWScaffold(
      dataObject: widget.dataObject,
      appBarTitle: 'Theme',
      body: CWListView(
        children: [
          Container(
            decoration: CustomDecoration(
              widget.dataObject.theme,
            ).baseContainerDecoration,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: themes
                  .map((theme) => Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              widget.dataObject.theme = theme['value'];

                              // var localPortfolioDataSet = await LocalDataSet().readPortfolios();
                              // var userProfileSettings = json.decode(localPortfolioDataSet);

                              // Navigator.pushAndRemoveUntil(
                              //     widget.dataObject.context,
                              //     MaterialPageRoute(
                              //       builder: (context) => Home(data: {
                              //         'initalData': userProfileSettings['initalData'],
                              //         'portfolios': userProfileSettings['portfolios'],
                              //         'filteredStocks': userProfileSettings['filteredStocks'],
                              //         'news': userProfileSettings['news'],
                              //         'theme': userProfileSettings['theme'],
                              //         'rates': userProfileSettings['rates']
                              //       }),
                              //     ),
                              //     (route) => false);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        theme['id'],
                                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).portfolioNameStyle,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    size: iconSize,
                                    color: widget.dataObject.theme == theme['value']
                                        ? greenVarient
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          themes.indexOf(theme) == 1
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Divider(
                                    color: seperator,
                                  ),
                                )
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
