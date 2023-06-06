import 'package:flutter/material.dart';

class ViewStock extends StatefulWidget {
  @override
  _ViewStockState createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
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
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
