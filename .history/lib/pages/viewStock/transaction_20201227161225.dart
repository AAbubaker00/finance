import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  Transaction({Key key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
          body: Container(
            padding: EdgeInsets.only(left: 50, right: 50),
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
                      helperStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                      helperText: 'sadas',
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
                    validator: (txt) => txt.isEmpty ? 'Enter Number' : null,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Number',
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        icon: Icon(Icons.call)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        labelText: 'Email*',
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        icon: Icon(Icons.mail)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (txt) => txt.length < 6 ? 'Passowrd Must be at least 6 characters Long' : null,
                    style: TextStyle(fontSize: 20),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password*',
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        icon: Icon(Icons.lock_outline)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password*',
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        icon: Icon(Icons.lock_outline)),
                    onChanged: (txt) {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
