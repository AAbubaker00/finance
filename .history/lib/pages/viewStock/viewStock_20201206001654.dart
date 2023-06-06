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
              Row(children: [
                Text('AAPL'),
                Text('STOCK')

              ],)

            ],
          ),
        ),
      ),
    );
  }
}
