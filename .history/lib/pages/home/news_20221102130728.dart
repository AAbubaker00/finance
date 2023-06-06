import 'package:Valuid/services/marketbeat/marketbeat.dart';
import 'package:Valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:Valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:Valuid/shared/Custome_Widgets/botomSheet/custome_Bottom_Sheet.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:Valuid/shared/Custome_Widgets/portfolioCard/portfolioCard.dart';
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
import 'package:Valuid/shared/update/initialise.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Valuid/extensions/stringExt.dart';
import 'package:intl/intl.dart';

class News extends StatefulWidget {
  final DataObject dataObject;

  const News({Key key, @required this.dataObject}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Future<bool> getNews() async {
    Initialise().updateOnHoldings(widget.dataObject);

    // print(widget.dataObject.onPortfolio['news'].length);

    // print(widget.dataObject.news.indexOf((pNews) => pNews['name'] == widget.dataObject.onPortfolio['name']));

    // print(widget.dataObject.news.length);

    if (widget.dataObject.news.isEmpty ||
        widget.dataObject.news.firstWhere((pNews) => pNews['name'] == widget.dataObject.onPortfolio['name'],
                orElse: () => -1) ==
            -1 ||
        refresh == true) {
      yahooNews.clear();

      // for (var holding in widget.dataObject.stocks) {
      //   var result = selectedProvider == 'Yahoo'
      //       ? await YahooApiService().getNews(holding)
      //       : selectedProvider == 'Marketbeat'
      //           ? await Marketbeat().getNews(holding)
      //           : null;
      //   // var marketbeatResult = [];
      //   //await Marketbeat().getNews(holding);

      //   // print(marketbeatResult.length);

      //   if (result.isNotEmpty) {
      //     // print(yahooResult.length);

      //     yahooNews.add({
      //       'icon': holding['marketData']['logo'],
      //       'symbol': holding['symbol'],
      //       'name': (holding['marketData']['quote'].containsKey('longName')
      //           ? holding['marketData']['quote']['longName'].toString().removeStr()
      //           : holding['marketData']['quote']['shortName'].toString().removeStr()),
      //       'news': []
      //         ..addAll(result)
      //         ..shuffle()
      //     });

      //     if (widget.dataObject.news.isEmpty) {
      //       // print('object');

      //       widget.dataObject.news.add({'name': widget.dataObject.onPortfolio['name'], 'news': yahooNews});

      //       // print(widget.dataObject.news.length);
      //     } else {
      //       var portfolioNews = widget.dataObject.news.firstWhere(
      //           (pNews) => pNews['name'] == widget.dataObject.onPortfolio['name'],
      //           orElse: () => false);

      //       if (portfolioNews != false) {
      //         portfolioNews['news'] = yahooNews;
      //       } else {
      //         widget.dataObject.news.add({'name': widget.dataObject.onPortfolio['name'], 'news': yahooNews});
      //       }
      //     }
      //   }
      // }

      if (selectedProvider == 'Yahoo') {
        for (var holding in widget.dataObject.cryptos) {
          var yahooResult = await YahooApiService().getNews(holding);

          // print(yahooResult);

          if (yahooResult.isNotEmpty) {
            yahooNews.add({
              'icon': holding['marketData']['logo'],
              'symbol': holding['symbol'],
              'name': holding['marketData']['name'],
              'news': yahooResult
            });

            if (widget.dataObject.news.isEmpty) {
              print('object');
              widget.dataObject.news.add({'name': widget.dataObject.onPortfolio['name'], 'news': yahooNews});
            } else {
              var portfolioNews = widget.dataObject.news.firstWhere(
                  (pNews) => pNews['name'] == widget.dataObject.onPortfolio['name'],
                  orElse: () => false);

              if (portfolioNews != false) {
                portfolioNews['news'] = yahooNews;
              } else {
                widget.dataObject.news
                    .add({'name': widget.dataObject.onPortfolio['name'], 'news': yahooNews});
              }
            }
          }
        }
      }

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
  String selectedFilter = 'Stocks';

  List newsProviders = [
    'Yahoo',
    'Marketbeat',
  ];

  List newsOptions = ['Stocks', 'Commodities', 'Cryptocurrency'];

  List yahooNews = [], marketbeatNews = [], investingComNews = [];

  String selectedProvider = 'Yahoo';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.dataObject.portfolios.length > 0 && widget.dataObject.onPortfolio == null) {
      widget.dataObject.onPortfolio = widget.dataObject.portfolios[1];
      Initialise().updateOnHoldings(widget.dataObject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: isNewsLoaded ? Future.value(true) : getNews(),
        builder: (context, snapshot) {
          // print( widget.dataObject.news
          //             .firstWhere((pNews) => pNews['name'] == widget.dataObject.onPortfolio['name']));

          if (isNewsLoaded) {
            return CWScaffold(
                dataObject: widget.dataObject,
                appbarColourOption: 2,
                bottomAppBarBorderColour: true,
                preferredSizeValue: 2,
                appBarTitleWidget: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'News',
                        style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                            .appBarTitleStyle,
                      ),
                      InkWell(
                          onTap: () => setState(() {
                                refresh = true;
                                isNewsLoaded = false;
                              }),
                          child: ClipRRect(
                              child: Image.asset(
                            'assets/icons/update.png',
                            width: 20,
                            height: 20,
                            color: UserThemes(widget.dataObject.theme).iconColour,
                          )))
                    ],
                  ),
                ),
                body: CWListView(
                  // physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 5),

                  centerWidget: widget.dataObject.onStockHoldings.length < 1
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
                              'Add instruments to view yahooNews',
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
                      : widget.dataObject.news.first['news']
                          .map<Widget>((feed) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0, top: 15, right: 15, left: 5),
                                      child: Text(
                                        feed['name'],
                                        style: CustomTextStyles(
                                                widget.dataObject.theme, widget.dataObject.context)
                                            .holdingValueStyle
                                            .copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: feed['news']
                                          .getRange(0, 3)
                                          .toList()
                                          .map<Widget>(
                                            (result) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                NewsCard(
                                                  index: widget.dataObject.news.first['news'].indexOf(feed),
                                                  dataObject: widget.dataObject,
                                                  feed: result,
                                                ),
                                                feed['news'].getRange(0, 3).toList().last != result
                                                    ? SizedBox(height: 10)
                                                    : Padding(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius.circular(Units().circularRadius),
                                                          onTap: () async => await Navigator.push(
                                                              context,
                                                              CustomPageRouteSlideTransition(
                                                                  direction: AxisDirection.left,
                                                                  child: NewsList(
                                                                    index: widget
                                                                        .dataObject.news.first['news']
                                                                        .indexOf(feed),
                                                                    dataObject: widget.dataObject,
                                                                    news: feed,
                                                                  ))),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 10.0),
                                                                child: Text(
                                                                    'More News on ${feed['symbol']}',
                                                                    style: CustomTextStyles(
                                                                            widget.dataObject.theme,
                                                                            widget.dataObject.context)
                                                                        .holdingValueStyle
                                                                        .copyWith(
                                                                            fontWeight: FontWeight.w400,
                                                                            color: UserThemes(
                                                                                    widget.dataObject.theme)
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
                                  ],
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
