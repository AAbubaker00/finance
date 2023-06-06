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

  TextStyle headerStyle = TextStyle(fontSize: 20, color: Colors.white38);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 0.6),
            child: AppBar(
              backgroundColor: Colors.transparent,
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
                  // color: Colors.grey[300],
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'price',
                        style: TextStyle(color: Colors.white38, fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('2342342 ', style: TextStyle(color: Colors.white, fontSize: 40)),
                          Text('USD')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('+0.3 ', style: TextStyle(color: Colors.white38, fontSize: 20)),
                          Text('+6% ', style: TextStyle(color: Colors.white38, fontSize: 20)),
                          Text('TODAY', style: TextStyle(color: Colors.white38))
                        ],
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
                              border: Border.all(color: Colors.white38),
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
                            border: Border.all(color: Colors.white38),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          'BUY',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Key Ratios',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.))
                        ),
                                              child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Market Cap',
                              style: headerStyle,
                            ),
                            Text('23423424')
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Sector', style: headerStyle), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('P/E Ratio', style: headerStyle), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('REVENUE', style: headerStyle), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('EPS', style: headerStyle), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('BETA', style: headerStyle), Text('23423424')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('VOLUME', style: headerStyle), Text('23423424')],
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
