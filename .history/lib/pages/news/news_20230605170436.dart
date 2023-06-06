import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/services/investing.com/investing_com.dart';
import 'package:valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:valuid/shared/Custome_Widgets/cards/newsList.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  final DataObject dataObject;

  const News({Key? key, required this.dataObject}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    for (var portfolio in widget.dataObject.portfolios) {
      for (var holding in portfolio.holdings) {
        var exist = allHoldings.firstWhere((h) => h.name == holding.name, orElse: () => null);

        if (exist == null) {
          test.add(holding);
        }
      }
    }
  }

  Future<bool> getNews() async {
    switch (selected) {
      case 'For You':
        try {
          for (var sy in test) {
            List s = await YahooApiService().getNews(sy.symbol!);

            if (s.length > 0) news.add({'symbol': sy.name, 'news': s, 'type': true});
          }
        } catch (e) {
          print(e.toString());
        }
        break;
      case 'Finance':
        List s = await InvestingCom(newsType: NewsType.ECONOMY).getNews();
        s.removeRange(3, 6);

        clenseNews(s, 'Finance');
        break;
      case 'Currency':
        List s = await InvestingCom(newsType: NewsType.CURRENCY).getNews();
        s.removeRange(3, 6);

        clenseNews(s, 'Currency');

        break;
      case 'Property':
        List s = await YahooApiService().propertyNews();
        clenseNews(s, 'Property');

        break;
      case 'Cryptocurrency':
        List s = await InvestingCom(newsType: NewsType.CRYPTO).getNews();
        s.removeRange(3, 6);

        List ss = await YahooApiService().cryptoNews();

        s.addAll(ss);

        clenseNews(s, 'Cryptocurrency');

        break;
      case 'Commodities':
        List s = await InvestingCom(newsType: NewsType.COMMODITY).getNews();
        s.removeRange(3, 6);

        clenseNews(s, 'Commodities');

        break;
      case 'Politics':
        List s = await InvestingCom(newsType: NewsType.POLITITCS).getNews();
        s.removeRange(3, 6);

        clenseNews(s, 'Politics');

        break;
      case 'World':
        List s = await InvestingCom(newsType: NewsType.WORLD).getNews();
        s.removeRange(3, 6);

        clenseNews(s, 'World');

        break;
    }

    isNewsLoaded = true;

    return Future.value(true);
  }

  clenseNews(List s, String type) {
    s = s.reversed.toList();

    news.add({'symbol': type, 'news': s, 'type': false});
  }

  List<QuoteObject> test = [];

  bool isNewsLoaded = false;

  String selectedSymbol = '';
  String selected = 'Finance';

  List<QuoteObject> allHoldings = [];
  List<Map<dynamic, dynamic>> news = [];
  List options = [
    {'type': 'For You', 'icon': 'assets/icons/likeOn.png'},
    {'type': 'Finance', 'icon': 'assets/icons/business.png'},
    {'type': 'Currency', 'icon': 'assets/icons/currency.png'},
    {'type': 'Property', 'icon': 'assets/icons/property.png'},
    {'type': 'Cryptocurrency', 'icon': 'assets/icons/crypto.png'},
    {'type': 'Commodities', 'icon': 'assets/icons/commodity.png'},
    // {'type': 'Politics', 'icon': 'assets/icons/politics.png'},
    {'type': 'World', 'icon': 'assets/icons/world.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: news.isEmpty ? getNews() : Future.value(true),
      builder: (context, snapshot) {
        if (isNewsLoaded) {
          return CWScaffold(
            scaffoldBgColour: BgTheme.LIGHT,
            bottomAppBarBorderColour: true,
            preferredSizeValue: 1.3,
            appBarBottomWidget: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
                child: Row(
                  children: options
                      .map((option) => Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selected = option['type'];
                                  isNewsLoaded = false;
                                  news.clear();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: option['type'] == selected ? blueVarient : backgroundColour),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        child: Image.asset(
                                      option['icon'],
                                      height: newsIconSize,
                                      width: newsIconSize,
                                      color: option['type'] == selected ? summaryColour : iconColour,
                                    )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        option['type'],
                                        style: CustomTextStyles(context, value: 15)
                                            .portfolioNameStyle
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    option['type'] == selected ? summaryColour : textColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            body: Column(children: [
              NewsList(
                news: news,
              )
            ]),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
