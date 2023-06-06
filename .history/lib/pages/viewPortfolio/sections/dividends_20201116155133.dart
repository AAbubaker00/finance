import 'package:flutter/material.dart';

class Dividends extends StatefulWidget {
  Dividends(List stocks) {
    _DividendsState().stocks = stocks;
  }

  @override
  _DividendsState createState() => _DividendsState();
}

class _DividendsState extends State<Dividends> {
  List<Map> months = [
    {
      'id': "January",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "February",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "March",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "April",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "May",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "June",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "July",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "August",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "September",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "October",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "November",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    },
    {
      'id': "December",
      'stocks': [],
      'status': 'na',
      'upcoming': 'yes',
      'totalPayment': '0'
    }
  ];

  List upcomingDividendStocks = [];
  List stocks = [];

  ScrollController _divScrollViewController = ScrollController();

  bool isSelectedMonth = false;
  bool isSectorSort = false;
  bool isPriceSort = false;
  bool isBuyDateSort = false;
  bool isNameSort = false;
  bool isValueSort = false;
  bool isInitialize = false;
  bool isAnalysisTab = false;

  Map selectedMonth = {};
  Map upComingDividends = {};
  Map data = {};

  Color fas = Colors.black;
  @override
  Widget build(BuildContext context) {
    for (var month in months) {
      _monthDataRest(month: month);

      for (var stock in stocks) {
        try {
          String exSectorivMonth =
              stock['marketData']['calanderEvents']['dividendDate']['fmt'];
          DateTime parexSectorivDate = DateTime.parse(exSectorivMonth);
          // print(parexSectorivDate.month);
          // print(
          //     stock['marketData']['defaultKeyStatistics']['lastDividendValue']['raw']);

          if ((months.indexOf(month) + 1) < DateTime.now().month) {
            month['upcoming'] = 'no';
          }

          if (parexSectorivDate.month == (months.indexOf(month) + 1)) {
            month['status'] = 'active';

            month['stocks'].add(stock);

            month['totalPayment'] =
                double.parse(month['totalPayment'].toString()) +
                    (double.parse(stock['marketData']['defaultKeyStatistics']
                                ['lastDividendValue']['raw']
                            .toString()) *
                        double.parse(stock['shares'].toString()));

            // print(month['totalPayment']);

            if (upComingDividends.isEmpty &&
                (months.indexOf(month) + 1) >= DateTime.now().month) {
              upComingDividends = (month);
              upcomingDividendStocks = month['stocks'];
              // print(month);
            }

            // print(month);
          }
        } catch (e) {}
      }
    }

    return Container(
      color: fas,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        controller: _divScrollViewController,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 1000), // **THIS is the important part**
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // print("$index saddsad");
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: Colors.red[900], width: 0.5))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    '${months[(DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).month) - 1]['id']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                Text(
                                  '${DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).day}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '${DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).year}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: DecoratedBox(
                            decoration: BoxDecoration(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${upcomingDividendStocks[index]['marketData']['quote']['symbol']} ',
                                          style: TextStyle(
                                              color: Color(0xFFF5F6F8),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            '${upcomingDividendStocks[index]['marketData']['quote']['longName']}',
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                      ],
                                    ),
                                    Text(
                                        'Shares: ${upcomingDividendStocks[index]['shares']}',
                                        style: TextStyle(color: Colors.white)),
                                    Text(
                                        'EXDATE: ${upcomingDividendStocks[index]['marketData']['calanderEvents']['exDividendDate']['fmt']}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Announced: ${upcomingDividendStocks[index]['marketData']['defaultKeyStatistics']['lastDividendValue']['raw']}',
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${(double.parse(upcomingDividendStocks[index]['marketData']['defaultKeyStatistics']['lastDividendValue']['raw'].toString()) * double.parse(upcomingDividendStocks[index]['shares'].toString()))}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            '${upcomingDividendStocks[index]['marketData']['quote']['currency']}',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 10)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: upcomingDividendStocks.length,
            ),
          ),
        ],
      ),
    );
  }

  _monthDataRest({Map month}) {
    month['stocks'].clear();
    month['totalPayment'] = 0.0;
  }

  _dividends() {
    for (var month in months) {
      _monthDataRest(month: month);

      for (var stock in stocks) {
        try {
          String exSectorivMonth =
              stock['marketData']['calanderEvents']['dividendDate']['fmt'];
          DateTime parexSectorivDate = DateTime.parse(exSectorivMonth);
          // print(parexSectorivDate.month);
          // print(
          //     stock['marketData']['defaultKeyStatistics']['lastDividendValue']['raw']);

          if ((months.indexOf(month) + 1) < DateTime.now().month) {
            month['upcoming'] = 'no';
          }

          if (parexSectorivDate.month == (months.indexOf(month) + 1)) {
            month['status'] = 'active';

            month['stocks'].add(stock);

            month['totalPayment'] =
                double.parse(month['totalPayment'].toString()) +
                    (double.parse(stock['marketData']['defaultKeyStatistics']
                                ['lastDividendValue']['raw']
                            .toString()) *
                        double.parse(stock['shares'].toString()));

            // print(month['totalPayment']);

            if (upComingDividends.isEmpty &&
                (months.indexOf(month) + 1) >= DateTime.now().month) {
              upComingDividends = (month);
              upcomingDividendStocks = month['stocks'];
              // print(month);
            }

            // print(month);
          }
        } catch (e) {}
      }
    }

    return Container(
      color: fas,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        controller: _divScrollViewController,
        children: <Widget>[
          // Container(
          //   child: ExpansionTile(
          //     title: Text(
          //       'Months',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     children: [
          //       Container(
          //           padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          //           height:
          //               MediaQuery.of(context).copyWith().size.height * 0.28,
          //           width: MediaQuery.of(context).copyWith().size.width,
          //           child: GridView.count(
          //             physics: BouncingScrollPhysics(),
          //             padding: EdgeInsets.all(5),
          //             crossAxisCount: 4,
          //             crossAxisSpacing: 5,
          //             mainAxisSpacing: 10,
          //             childAspectRatio: 1.5,
          //             children: months.map((month) {
          //               return InkWell(
          //                 onTap: () {
          //                   selectedMonth = month;
          //                   isSelectedMonth = true;
          //                   // print(month);
          //                 },
          //                 child: Card(
          //                   color: (month['upcoming'].toString() == 'yes')
          //                       ? Colors.white
          //                       : Colors.grey[850],
          //                   child: Stack(
          //                     children: [
          //                       Center(child: Text(month['id'])),
          //                       Align(
          //                         alignment: Alignment.bottomRight,
          //                         child: Icon(
          //                           Icons.brightness_1,
          //                           color: (month['status'] == 'active')
          //                               ? Colors.red
          //                               : Colors.transparent,
          //                           size: 5,
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             }).toList(),
          //           )),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Next Dividends', style: TextStyle(color: Colors.white)),
          //       Text('Month Total: ${upComingDividends['totalPayment']}',
          //           style: TextStyle(color: Colors.white))
          //     ],
          //   ),
          // ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 1000), // **THIS is the important part**
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // print("$index saddsad");
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: Colors.red[900], width: 0.5))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    '${months[(DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).month) - 1]['id']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                Text(
                                  '${DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).day}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '${DateTime.parse(upcomingDividendStocks[index]['marketData']['calanderEvents']['dividendDate']['fmt']).year}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: DecoratedBox(
                            decoration: BoxDecoration(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${upcomingDividendStocks[index]['marketData']['quote']['symbol']} ',
                                          style: TextStyle(
                                              color: Color(0xFFF5F6F8),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            '${upcomingDividendStocks[index]['marketData']['quote']['longName']}',
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                      ],
                                    ),
                                    Text(
                                        'Shares: ${upcomingDividendStocks[index]['shares']}',
                                        style: TextStyle(color: Colors.white)),
                                    Text(
                                        'EXDATE: ${upcomingDividendStocks[index]['marketData']['calanderEvents']['exDividendDate']['fmt']}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Announced: ${upcomingDividendStocks[index]['marketData']['defaultKeyStatistics']['lastDividendValue']['raw']}',
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${(double.parse(upcomingDividendStocks[index]['marketData']['defaultKeyStatistics']['lastDividendValue']['raw'].toString()) * double.parse(upcomingDividendStocks[index]['shares'].toString()))}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            '${upcomingDividendStocks[index]['marketData']['quote']['currency']}',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 10)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: upcomingDividendStocks.length,
            ),
          ),
        ],
      ),
    );
  }
}
