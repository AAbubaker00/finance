import 'package:Valuid/services/marketbeat/marketbeat.dart';
import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/restricted/restricted.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/decoration/customDecoration.dart';
import 'package:Valuid/shared/news/newsCard.dart';
import 'package:Valuid/shared/news/viewNews.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:Valuid/extensions/stringExt.dart';

class News extends StatefulWidget {
  final DataObject dataObject;

  const News({Key key, @required this.dataObject}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Future<bool> getNews() async {
    // Initialise().updateOnHoldings(widget.dataObject);

    // print(widget.dataObject.onPortfolio['news'].length);

    // print(widget.dataObject.news.indexOf((pNews) => pNews['name'] == widget.dataObject.onPortfolio['name']));

    // print(widget.dataObject.news.length);

    if (widget.dataObject.news.isEmpty || refresh == true) {
      newsList.clear();

      for (var holding in widget.dataObject.stocks) {
        var result = selectedProvider == 'Yahoo Finance'
            ? await YahooApiService().getNews(holding)
            : selectedProvider == 'Marketbeat'
                ? await Marketbeat().getNews(holding)
                : null;
        // var marketbeatResult = [];
        //await Marketbeat().getNews(holding);

        // print(marketbeatResult.length);

        if (result.isNotEmpty) {
          // print(yahooResult.length);

          newsList.add({
            'icon': holding['marketData']['logo'],
            'symbol': holding['symbol'],
            'name': (holding['marketData']['quote'].containsKey('longName')
                ? holding['marketData']['quote']['longName'].toString().removeStr()
                : holding['marketData']['quote']['shortName'].toString().removeStr()),
            'news': []..addAll(result)
            // ..shuffle()
          });

          widget.dataObject.news = newsList;
        }
      }

      // print(widget.dataObject.news.first);

      // if (selectedProvider == 'Yahoo Finance') {
      //   for (var holding in widget.dataObject.cryptos) {
      //     var yahooResult = await YahooApiService().getNews(holding);

      //     // print(yahooResult);

      //     if (yahooResult.isNotEmpty) {
      //       newsList.add({
      //         'icon': holding['marketData']['logo'],
      //         'symbol': holding['symbol'],
      //         'name': holding['marketData']['name'],
      //         'news': yahooResult
      //       });

      //       if (widget.dataObject.news.isEmpty) {
      //         print('object');
      //         widget.dataObject.news.add({'name': widget.dataObject.onPortfolio['name'], 'news': newsList});
      //       } else {
      //         var portfolioNews = widget.dataObject.news.firstWhere(
      //             (pNews) => pNews['name'] == widget.dataObject.onPortfolio['name'],
      //             orElse: () => false);

      //         if (portfolioNews != false) {
      //           portfolioNews['news'] = newsList;
      //         } else {
      //           widget.dataObject.news
      //               .add({'name': widget.dataObject.onPortfolio['name'], 'news': newsList});
      //         }
      //       }
      //     }
      //   }
      // }

      refresh = false;
      isNewsLoaded = true;
      return Future.value(true);
    } else {
      refresh = false;
      isNewsLoaded = true;

      return Future.value(true);
    }
  }

  bool isNewsLoaded = false, refresh = false;

  List newsProviders = [
    'Yahoo Finance',
    'Marketbeat',
  ];

  List newsList = [];

  String selectedProvider = 'Yahoo Finance';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: isNewsLoaded ? Future.value(true) : getNews(),
        builder: (context, snapshot) {
          if (isNewsLoaded) {
            return CWScaffold(
                dataObject: widget.dataObject,
                preferredSizeValue: 1,
                appBarBottomWidget: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.c,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: newsProviders
                            .map<Widget>((provider) => Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: IntrinsicWidth(
                                    child: InkWell(
                                      onTap: () => setState(() {
                                        selectedProvider = provider;
                                        refresh = true;
                                        isNewsLoaded = false;
                                      }),
                                      // borderRadius: BorderRadius.circular(Units().circularRadius),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(provider,
                                                style: CustomTextStyles(
                                                        widget.dataObject.theme, widget.dataObject.context)
                                                    .holdingValueStyle
                                                    .copyWith(
                                                      color: selectedProvider == provider
                                                          ? UserThemes(widget.dataObject.theme).blueVarient
                                                          : UserThemes(widget.dataObject.theme).chartTextColour,))
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Container(
                                              height: 5,
                                              decoration: BoxDecoration(
                                                  color: selectedProvider == provider
                                                      ? UserThemes(widget.dataObject.theme)
                                                          .blueVarient
                                                          .withOpacity(.7)
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(Units().circularRadius),
                                                      topRight: Radius.circular(Units().circularRadius))),
                                              child: Container(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                body: CWListView(
                  centerWidget: widget.dataObject.stocks.length < 1
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                child: Image.asset(
                              'assets/icons/empty.png',
                              width: 40,
                              height: 40,
                              color: UserThemes(widget.dataObject.theme).textColorVarient,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Add instruments to view newsList',
                              style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                  .holdingSubValueStyle,
                            )
                          ],
                        ))
                      : null,
                  children: widget.dataObject.userFire.isAnonymous
                      ? [
                          Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Restricted(dataObject: widget.dataObject))
                        ]
                      : widget.dataObject.news
                          .map<Widget>((feed) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: Ink(
                                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                                  decoration: widget.dataObject.news.first['news'].first == feed
                                      ? CustomDecoration(widget.dataObject.theme).topWidgetDecoration
                                      : CustomDecoration(widget.dataObject.theme).baseContainerDecoration,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                        child: Text(feed['name'],
                                            style: CustomTextStyles(
                                                    widget.dataObject.theme, widget.dataObject.context)
                                                .holdingValueStyle
                                                .copyWith(
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        UserThemes(widget.dataObject.theme).blueVarient_2)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
                                        child: CustomDivider(dataObject: widget.dataObject),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: feed['news']
                                              .getRange(0, 4)
                                              .toList()
                                              .map<Widget>(
                                                (result) => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    NewsCard(
                                                      dataObject: widget.dataObject,
                                                      feed: result,
                                                    ),
                                                    feed['news'].getRange(0, 4).toList().last != result
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(horizontal: 10.0),
                                                            child: CustomDivider(
                                                              dataObject: widget.dataObject,
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding: EdgeInsets.only(top: 10.0),
                                                            child: InkWell(
                                                              borderRadius: BorderRadius.circular(
                                                                  Units().circularRadius),
                                                              onTap: () async => await Navigator.push(
                                                                  context,
                                                                  CustomPageRouteSlideTransition(
                                                                      direction: AxisDirection.left,
                                                                      child: NewsList(
                                                                        dataObject: widget.dataObject,
                                                                        news: feed,
                                                                      ))),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.only(left: 10.0),
                                                                    child: Text(
                                                                        'More News on ${feed['symbol']}',
                                                                        style: CustomTextStyles(
                                                                                widget.dataObject.theme,
                                                                                widget.dataObject.context)
                                                                            .holdingValueStyle
                                                                            .copyWith(
                                                                                fontWeight: FontWeight.w900,
                                                                                color: UserThemes(widget
                                                                                        .dataObject.theme)
                                                                                    .blueVarient)),
                                                                  ),
                                                                  Icon(
                                                                    Icons.chevron_right,
                                                                    size: Units().calenderIconSize,
                                                                    color: UserThemes(widget.dataObject.theme)
                                                                        .blueVarient,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                ));
          } else {
            return Center(
              child: Container(
                color: UserThemes(widget.dataObject.theme).summaryColour,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(
                      isbgColourActive: true,
                      theme: widget.dataObject.theme,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
