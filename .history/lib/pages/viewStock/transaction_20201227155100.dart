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
       child: SafeArea(
         child: Scaffold(
           appBar: PreferredSize(
             preferredSize: Size.fromHeight(kToolbarHeight*0.7),
             child: AppBar(
               centerTitle: true,
               title: Text('Transaction'),
             ),
           ),
           body: Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register"),
                    TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Enter Name*' : null,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Name*',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          icon: Icon(Icons.person)),
                      onChanged: (txt) {
                        setState(() => _name = txt);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (txt) => txt.isEmpty ? 'Enter Number' : null,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Number',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          icon: Icon(Icons.call)),
                      onChanged: (txt) {
                        setState(() => _number = txt);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: 'Email*',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          icon: Icon(Icons.mail)),
                      onChanged: (txt) {
                        setState(() => _email = txt);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (txt) => txt.length < 6
                          ? 'Passowrd Must be at least 6 characters Long'
                          : null,
                      style: TextStyle(fontSize: 20),
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password*',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          icon: Icon(Icons.lock_outline)),
                      onChanged: (txt) {
                        setState(() => _password = txt);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password*',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          icon: Icon(Icons.lock_outline)),
                      onChanged: (txt) {},
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: isAccepted,
                            onChanged: (bool value) {
                              setState(() {
                                isAccepted = value;
                              });
                            }),
                        Text('I agree to the Terms & Conditions')
                      ],
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