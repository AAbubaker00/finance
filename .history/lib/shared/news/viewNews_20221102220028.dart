import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/news/newsCard.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final DataObject dataObject;
  final Map news;

  const NewsList({Key key, this.dataObject, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: dataObject,
      appbarColourOption: 2,
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      bottomAppBarBorderColour: true,
      appBarTitle: '${news['symbol']} news',
      body: CWListView(
        padding: EdgeInsets.all(10),
        children: news['news']
            .map<Widget>((feed) => Column(
                  children: [
                    NewsCard(
                      dataObject: dataObject,
                      feed: feed,
                    ),
                    news['news'].last != feed
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.0, ),
                            child: CustomDivider(dataObject: dataObject),
                          )
                        : Container()
                  ],
                ))
            .toList(),
      ),
    );
  }
}
