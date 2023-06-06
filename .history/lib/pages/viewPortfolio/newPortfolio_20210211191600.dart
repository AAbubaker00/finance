import 'package:flutter/material.dart';
import 'package:finance/shared/themes.dart';

class NewPortfolio extends StatefulWidget {
  @override
  _NewPortfolioState createState() => _NewPortfolioState();
}

class _NewPortfolioState extends State<NewPortfolio> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String baseCurrency = 'GBP';
  String description = '';
  String name = '';

  Map data = {}, initData = {};
  List portfolios = [];
  List editedPortfolios = [];
  bool isLoaded = false;

  setData() {
    if (isLoaded == false) {
      setState(() {
        portfolios = data['data']['portfolios'];
      });

      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    // print(data['data']);
    setData();

    return Container(
      color: DarkTheme().backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.pushReplacementNamed(context, '/search', arguments: {
                  'data': data['data'],
                  'portfolios': portfolios,
                  'change': [
                    {
                      'isSelected': false,
                      'totalStocks': "0",
                      'totalShares': "0",
                      'name': name,
                      'baseCurrency': baseCurrency,
                      'stocks': [],
                    }
                  ]
                });
              }
            },
            mini: true,
            child: Icon(
              Icons.arrow_forward_ios,
              color: DarkTheme().greenVarient,
              size: 35,
            ),
            backgroundColor: DarkTheme().backgroundColour,
            elevation: 5,
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * .7),
            child: AppBar(
              backgroundColor: DarkTheme().backgroundColour,
              title: Text(
                'New Portfolio',
              ),
              centerTitle: true,
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: DarkTheme().summaryColour, //Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: DarkTheme().summaryColour,
                    width: 0.2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: Text(
                            'Name',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w200),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70),
                              child: TextFormField(
                                validator: (value) => value.isEmpty ? 'Enetr a name' : null,
                                // focusNode: focusNode_0,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w300),
                                  hintText: 'Portfolio Name',
                                  focusedBorder:
                                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[600])),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (txt) {
                                  setState(() => name = txt);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: DarkTheme().iconColour,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Text(
                            'Base Currency',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w200),
                          ),
                        ),
                        Stack(
                          // alignment:  Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: DropdownButton<String>(
                                // dropdownColor: Colors.transparent,
                                icon: Text(
                                  baseCurrency,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                ),

                                autofocus: true,
                                onChanged: (String option) {
                                  setState(() {});
                                },
                                isDense: true,
                                isExpanded: false,

                                items: <String>[
                                  'USD',
                                  'EUR',
                                  'JPY',
                                  'GBP',
                                  'AUD',
                                  'CAD',
                                  'CHF',
                                  'CNY',
                                  'HKD',
                                  'NZD',
                                ].map<DropdownMenuItem<String>>((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    onTap: () {
                                      setState(() => baseCurrency = option);
                                    },
                                    child: Text(
                                      option,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: DarkTheme().iconColour,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: Text(
                            'Description',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w200),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w300),
                                  // hintText: data['portfolio']['brooker'],
                                  focusedBorder:
                                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[600])),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (txt) {
                                  setState(() => description = txt);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: DarkTheme().iconColour,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
