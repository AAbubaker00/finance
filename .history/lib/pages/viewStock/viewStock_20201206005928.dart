import 'package:flutter/material.dart';

class ViewStock extends StatefulWidget {
  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  List<Map> timeFrame = [
    {'time': '1D', 'selected': false},
    {'time': '1W', 'selected': false},
    {'time': '1MO', 'selected': false},
    {'time': '3MO', 'selected': false},
    {'time': '1Y', 'selected': false},
    {'time': 'MAX', 'selected': true},
  ];

  TextStyle headerStyle = TextStyle();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              title: Text('Apple inc'),
              centerTitle: true,
            ),
          ),
          body: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('AAPL  '), Text('STOCK  '), Text('NASDAQ')],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Container(
                  color: Colors.grey[300],
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('price'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('2342342 '), Text('USD')],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('+0.3 '), Text('+6% '), Text('TODAY')],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  color: Colors.grey[200],
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 6,
                  childAspectRatio: 2,
                  // scrollDirection: Axis.horizontal,
                  children: timeFrame.map((time) {
                    return InkWell(
                      child: Card(
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            time['time'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              // color: Colors.grey[850],
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(child: Text('SELL')),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            // color: Colors.grey[850],
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text('BUY')),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Stats'),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Market Cap',
                          style: TextStyle,
                        ),
                        Text('23423424')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Sector'), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('P/E Ratio'), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('REVENUE'), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('EPS'), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('BETA'), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('VOLUME'), Text('23423424')],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
