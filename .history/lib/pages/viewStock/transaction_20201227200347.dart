import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  Transaction({Key key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  DateTime _selectedDate = DateTime.now();

  List<String> portfolios = ['Dividend', 'Assets', 'Long Term Investments'];
  List<String> options = [''];
  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    surface: Colors.transparent,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child,
              );
            },
            context: context,
            initialDate: _selectedDate,
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime.now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 0.7),
            child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text('Transaction'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Text(
                  'Purchase Date',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (txt) => txt.isEmpty ? 'Enter Name*' : null,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                            helperStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                            helperText: 'Maket Price: 334',
                            labelText: '*Purchase Price',
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey[600],
                            )),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (txt) => txt.isEmpty ? 'Enter Name*' : null,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                            helperStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                            helperText: 'default: 1',
                            labelText: '*Quantity',
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey[600],
                            )),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            _pickDateDialog();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.045,
                                width: MediaQuery.of(context).size.width,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey[600])),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, bottom: 20),
                                  child: Text(
                                    'Purchase Date',
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  'Select Portfolio',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: portfolios.map((p) {
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey[600])),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  p,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.08,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[300])),
                child: Center(
                  child: Text(
                    'Submit Order',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
