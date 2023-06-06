import 'dart:convert';

import 'package:finance/services/yahooapi/yahoo_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoaded = false;

  List data = [];
  List displayedData = [];
  Map selectedStock = {};

  List<Map<String, dynamic>> availableExchanges = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadStockList();
  }

  @override
  Widget build(BuildContext context) {
    void _showSelectedStockPanel(Map stock) {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _stockPanel(stock);
          });
    }

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //     color: Colors.grey[300], width: 0.2)
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.82,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    // contentPadding: EdgeInsets.only(
                                    //   left: 0,
                                    //   bottom: 10,
                                    //   top: 15,
                                    // ),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    labelStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    hintText: "Search",
                                    suffixIcon: Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.grey.withOpacity(0.5),
                                    )),
                                onChanged: (txt) {
                                  txt = txt.toLowerCase();
                                  setState(() {
                                    displayedData = data.where((stock) {
                                      var quoteName =
                                          stock['name'].toLowerCase();
                                      return quoteName.contains(txt);
                                    }).toList();
                                  });
                                },
                              ),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Container(
                    child: ListView.builder(
                        itemCount: availableExchanges.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (availableExchanges[index]['isSelected'] ==
                                    true) {
                                  availableExchanges[index]['isSelected'] =
                                      false;
                                } else {
                                  availableExchanges[index]['isSelected'] =
                                      true;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: (availableExchanges[index]
                                                    ['isSelected'] ==
                                                true)
                                            ? Colors.green
                                            : Colors.grey[600]
                                                .withOpacity(0.6)),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(),
                                    child: Center(
                                      child: Text(
                                        availableExchanges[index]['name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: displayedData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              selectedStock = await YahooApiService()
                                  .getAllStockData(
                                      symbol: displayedData[index]['symbol'],
                                      exchange: displayedData[index]
                                          ['exchange']);

                              setState(() {
                                selectedStock = selectedStock;
                              });

                              print(selectedStock);
                              _showSelectedStockPanel(selectedStock);

                              // print(selectedStock);
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[900]),
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                "${displayedData[index]['name']}",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            Text(
                                                "${displayedData[index]['symbol']}, ${displayedData[index]['exchange']}",
                                                style: TextStyle(
                                                    color: Colors.grey[600])),
                                          ],
                                        ),
                                        IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.grey[600]
                                                  .withOpacity(0.5),
                                            ))
                                      ],
                                    ))),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _stockPanel(Map stock) {
    return Column(
      children: [
        Expanded(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height*0.7,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${stock['quote']['symbol'].toString()} ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                stock['quote']['longName'].toString(),
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${stock['quote']['regularMarketPrice'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                  Text(
                                    stock['quote']['currency'].toString(),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${stock['quote']['regularMarketChange'].toStringAsFixed(2)} ",
                                    style: TextStyle(
                                        color: (double.parse(stock['quote']
                                                        ['regularMarketChange']
                                                    .toString()) <
                                                0
                                            ? Colors.red
                                            : Colors.green)),
                                  ),
                                  Text(
                                    "(${stock['quote']['regularMarketChangePercent'].toStringAsFixed(2)})",
                                    style: TextStyle(
                                        color: (double.parse(stock['quote']
                                                        ['regularMarketChange']
                                                    .toString()) <
                                                0
                                            ? Colors.red
                                            : Colors.green)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('H'),
                          Text(
                              "${stock['quote']['regularMarketDayHigh'].toString()}"),
                          Text('L '),
                          Text(
                              "L ${stock['quote']['regularMarketDayLow'].toString()}"),
                          Text(''),

                          Text(
                              "Vol ${stock['quote']['regularMarketVolume'].toString()}"),
                          Text(''),

                          Text(
                              "Market Cap ${stock['quote']['marketCap'].toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<String> _loadFromAssets() async {
    return await rootBundle.loadString("assets/stocks/stocks.json");
  }

  Future loadStockList() async {
    String jsonString = await _loadFromAssets();
    final jsonResponse = jsonDecode(jsonString);

    for (var stock in jsonResponse) {
      if (availableExchanges.isEmpty) {
        availableExchanges.add({
          'name': stock['exchange'],
          'isSelected': false,
        });
      } else {
        var exExist = availableExchanges.firstWhere(
            (ex) => stock['exchange'].toString() == ex['name'],
            orElse: () => null);

        if (exExist == null) {
          availableExchanges.add({
            'name': stock['exchange'],
            'isSelected': false,
          });
        }
      }

      data.add(stock);
    }

    // print(availableExchanges);
    setState(() {
      displayedData = data;
    });
  }
}
