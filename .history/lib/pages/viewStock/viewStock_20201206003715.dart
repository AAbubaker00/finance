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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
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
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width*0.4,

                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text('SELL'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
