import 'package:valuid/pages/news/newsCard.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:flutter/material.dart';

class ViewNews extends StatelessWidget {
  final Map<dynamic, dynamic> news;
  final int index;

  const ViewNews({Key? key, required this.news, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      scaffoldBgColour: BgTheme.LIGHT,
      bottomAppBarBorderColour: true,
      appBarTitle: '${news['symbol']} News',
      body: CWListView(
        padding: EdgeInsets.all(15),
        children: news['news']
            .map<Widget>((feed) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: NewsCard(index: index, news: feed),
                ))
            .toList(),
      ),
    );
  }
}
