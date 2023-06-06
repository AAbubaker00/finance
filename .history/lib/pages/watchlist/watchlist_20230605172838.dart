import 'dart:async';

import 'package:valuid/models/watchlist/watchlist.dart';
import 'package:valuid/services/Network/network.dart';
import 'package:valuid/services/yahooapi/yahoo_api_provider.dart';
import 'package:valuid/shared/Custome_Widgets/loading/loading.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/pageLoaders/offline.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/themes/themes.dart';

class WatchList extends StatefulWidget {
  final DataObject dataObject;

  const WatchList({required this.dataObject});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  void dispose() {
    updateFrequency.cancel();
    super.dispose();
  }

  getMarketQuotes() async {
    updateState = true;
    isOnline = true;

    try {
      widget.dataObject.watchlist = await YahooApiService().getYahooQuoteList(widget.dataObject.watchlist);
    } catch (e) {
      print(e.toString());
    }

    updateState = false;
    priceUpdateStream.add([true]);
  }

  Future<bool> initalise() async {
    print(doc['watchlist']);
    print('ere');

    if (doc != null) {
      print(widget.dataObject.watchlist);
      widget.dataObject.watchlist = WatchlistObject().docFromMap(doc['watchlist']);
      await getMarketQuotes();
    } else {
      setState(() {});
    }

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    priceUpdateStream = new StreamController.broadcast();

    updateFrequency = Timer.periodic(Duration(seconds: 5), (timer) async {
      await Network().getConnectionStatus()
          ? updateState == false
              ? await getMarketQuotes()
              : print('waiting')
          : setState(() => isOnline = false);
    });
  }

  late DocumentSnapshot doc;
  late Timer updateFrequency;
  late StreamController<List> priceUpdateStream;
  bool updateState = false, isOnline = true;

  @override
  Widget build(BuildContext context) {
    doc = Provider.of<DocumentSnapshot>(context);

    return FutureBuilder<bool>(
      future: initalise(),
      builder: (context, snapshot) {
        return CWScaffold(
          scaffoldBgColour: BgTheme.LIGHT,
          appBarTitleWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watchlist',
                  style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(buttonRadius),
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/icons/add.png',
                      width: iconSize,
                      height: iconSize,
                      color: iconColour,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: snapshot.data == true
              ? isOnline
                  ? StreamBuilder(
                      stream: priceUpdateStream.stream,
                      builder: (context, snapshot) => ListView(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                        children: widget.dataObject.watchlist
                            .map((item) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(circularRadius),
                                      color: backgroundColour),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item.name, style: CustomTextStyles(context).appBarTitleStyle),
                                        Text(item.currency + ' ' + item.regularMarketPrice.toStringAsFixed(2),
                                            style: CustomTextStyles(context).sectionHeader),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item.exchange,
                                              style: CustomTextStyles(widget.dataObject.context)
                                                  .portfolioNameStyle
                                                  .copyWith(
                                                    color: textColor.withOpacity(.5),
                                                  )),
                                          Text(item.regularMarketChangePercent.toStringAsFixed(2) + '%',
                                              style: CustomTextStyles(context).holdingValueStyle.copyWith(
                                                  color: (item.regularMarketChangePercent > 0)
                                                      ? greenVarient
                                                      : redVarient)),
                                        ],
                                      ),
                                    )
                                  ]),
                                ))
                            .toList(),
                      ),
                    )
                  : Offline()
              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Loading(),
                    ],
                  ),
                ]),
        );
      },
    );
  }
}
