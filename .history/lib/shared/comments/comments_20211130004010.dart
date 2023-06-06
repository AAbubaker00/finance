  // Align(
                                            //   alignment: Alignment.center,
                                            //   child: DropdownButton<Map>(
                                            //     dropdownColor: UserThemes(isDark).insideColour,
                                            //     // icon: Text(
                                            //     //   currency,
                                            //     //   style: TextStyle(
                                            //     //       fontSize: prefixIconSize, color: UserThemes(isDark).textColor, fontWeight: FontWeight.w400),
                                            //     // ),
                                            //     autofocus: true,
                                            //     icon: Text(currency),
                                            //     underline: Container(
                                            //       color: Colors.transparent,
                                            //     ),
                                            //     onTap: (){},
                                            //     onChanged: (Map option) {
                                            //       setState(() {
                                            //         selectedCurrency = option;
                                            //         currency = selectedCurrency['short'];
                                            //       });
                                            //     },

                                            //     isDense: true,
                                            //     items: MarketUpdate('').currencySymbols.map<DropdownMenuItem<Map>>((option) {
                                            //       return DropdownMenuItem<Map>(
                                            //         value: option,
                                            //         onTap: () {
                                            //           setState(() {
                                            //             selectedCurrency = option;
                                            //             currency = selectedCurrency['short'];

                                            //             // isSortLoaded = false;
                                            //           });
                                            //         },
                                            //         child: Text(
                                            //           '${option['short']} - ${option['name']} (${option['symbol']})',
                                            //           style: TextStyle(
                                            //               color: selectedCurrency['short'] == option['short']
                                            //                   ? UserThemes(isDark).goldVarient
                                            //                   : UserThemes(isDark).textColor),
                                            //         ),
                                            //       );
                                            //     }).toList(),
                                            //   ),
                                            // ),





                  //                             Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         color: UserThemes(isDark).summaryColour,
                  //         border: Border.symmetric(
                  //             horizontal: BorderSide(color: UserThemes(isDark).border, width: 1))),
                  //     child: Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 10),
                  //           child: Row(
                  //             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               InkWell(
                  //                   onTap: () => setState(() => isSector = true),
                  //                   child: Container(
                  //                       padding: EdgeInsets.only(bottom: 5),
                  //                       child: Text('SECTORS', style: sectionHeader))),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text('/', style: sectionHeader),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               InkWell(
                  //                   onTap: () => setState(() => isSector = false),
                  //                   child: Container(
                  //                       padding: EdgeInsets.only(bottom: 5),
                  //                       child: Text('INDUSTRIES', style: sectionHeader))),
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.only(bottom: 20.0),
                  //           child: RichText(
                  //               text: TextSpan(children: <TextSpan>[
                  //             TextSpan(text: 'Sectors - ', style: disclaimerHeader),
                  //             TextSpan(
                  //                 text:
                  //                     'Represent a grouping of companies with similar business activities and are operating in a specific district of the economy.',
                  //                 style: disclaimerSub)
                  //           ])),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.only(bottom: 20.0),
                  //           child: RichText(
                  //               text: TextSpan(children: <TextSpan>[
                  //             TextSpan(text: 'Industries - ', style: disclaimerHeader),
                  //             TextSpan(
                  //                 text:
                  //                     'Represent a grouping of companies with similar business activities and are operating in a specific district of a Sector.',
                  //                 style: disclaimerSub)
                  //           ])),
                  //         ),
                  //         Container(
                  //           padding: EdgeInsets.only(right: 40, left: 10, top: 10, bottom: 10),
                  //           color: UserThemes(isDark).border,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 width: _width * .4,
                  //                 child: Row(
                  //                   children: [
                  //                     Flexible(
                  //                       child: Text(
                  //                         'Sector',
                  //                         style: headerStyle,
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               Text(
                  //                 'Invested',
                  //                 style: headerStyle,
                  //               ),
                  //               Text(
                  //                 'Return',
                  //                 style: headerStyle,
                  //               ),
                  //               Text(
                  //                 'Qty',
                  //                 style: headerStyle,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: sectorCDT
                  //                 .map((sector) => ExpansionTile(
                  //                       backgroundColor: sectorCDT.indexOf(sector).isEven
                  //                           ? Colors.transparent
                  //                           : UserThemes(isDark).border,
                  //                       collapsedBackgroundColor: sectorCDT.indexOf(sector).isEven
                  //                           ? Colors.transparent
                  //                           : UserThemes(isDark).border,
                  //                       iconColor: UserThemes(isDark).blueVarient.withOpacity(.7),
                  //                       collapsedIconColor: UserThemes(isDark).iconColour,
                  //                       title: Container(
                  //                         padding: EdgeInsets.only(left: 10),
                  //                         child: Row(
                  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Container(
                  //                               width: _width * .4,
                  //                               child: Row(
                  //                                 children: [
                  //                                   Flexible(
                  //                                     child: Text(
                  //                                       sector.name,
                  //                                       style: sublineStyle.copyWith(
                  //                                           fontWeight: FontWeight.w400),
                  //                                       overflow: TextOverflow.ellipsis,
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             Text(
                  //                               sector.value.toStringAsFixed(2).addCommas(),
                  //                               style: sublineStyle,
                  //                             ),
                  //                             Text(
                  //                                 sector.turn.isNegative
                  //                                     ? '-$currencySymbol${(sector.turn * -1).toStringAsFixed(2).addCommas()}'
                  //                                     : '+$currencySymbol${sector.turn.toStringAsFixed(2).addCommas()}',
                  //                                 style: sublineStyle.copyWith(
                  //                                     color: sector.turn.isNegative
                  //                                         ? UserThemes(isDark).redVarient
                  //                                         : UserThemes(isDark).greenVarient,
                  //                                     fontWeight: FontWeight.w500)),
                  //                             Text(
                  //                               sector.assetLength.toString(),
                  //                               style: sublineStyle,
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       childrenPadding: EdgeInsets.all(10),
                  //                       tilePadding: EdgeInsets.all(0),
                  //                       expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  //                       children: [
                  //                         DataTable(
                  //                             columnSpacing: 10,
                  //                             horizontalMargin: 5,
                  //                             showBottomBorder: false,
                  //                             headingRowColor:
                  //                                 MaterialStateProperty.resolveWith<Color>((states) {
                  //                               return UserThemes(isDark).backgroundColour;
                  //                             }),
                  //                             headingRowHeight: 30,
                  //                             headingTextStyle: headerStyle,
                  //                             dataRowHeight: 35,
                  //                             dividerThickness: 0,
                  //                             dataTextStyle: TextStyle(),
                  //                             columns: <DataColumn>[
                  //                               DataColumn(
                  //                                 label: Text(
                  //                                   'Industry (${sector.subAssets.length.toString()})',
                  //                                 ),
                  //                               ),
                  //                               DataColumn(
                  //                                 label: Text(
                  //                                   'Invested',
                  //                                 ),
                  //                               ),
                  //                               DataColumn(
                  //                                 label: Text(
                  //                                   'Return',
                  //                                 ),
                  //                               ),
                  //                               DataColumn(
                  //                                 label: Text(
                  //                                   'Qty',
                  //                                 ),
                  //                               )
                  //                             ],
                  //                             rows: (sector.subAssets).map((s) {
                  //                               return DataRow(
                  //                                   color: MaterialStateProperty.resolveWith<Color>(
                  //                                     (states) {
                  //                                       if ((sector.subAssets).indexOf(s).isOdd) {
                  //                                         return UserThemes(isDark).backgroundColour;
                  //                                       } else {
                  //                                         return null;
                  //                                       }
                  //                                     },
                  //                                   ),
                  //                                   cells: [
                  //                                     DataCell(
                  //                                         Container(
                  //                                           width: _width * .4,
                  //                                           child: Row(
                  //                                             children: [
                  //                                               Flexible(
                  //                                                 child: Text(
                  //                                                   s.name,
                  //                                                   style: sublineStyle,
                  //                                                   overflow: TextOverflow.ellipsis,
                  //                                                 ),
                  //                                               ),
                  //                                             ],
                  //                                           ),
                  //                                         ), onTap: () {
                  //                                       // print(s.assetList);
                  //                                     }),
                  //                                     DataCell(
                  //                                       Text('$currencySymbol${s.value.toStringAsFixed(2).addCommas()}',
                  //                                           style: sublineStyle),
                  //                                     ),
                  //                                     DataCell(Text(
                  //                                         s.turn.isNegative
                  //                                             ? '-$currencySymbol${(s.turn * -1).toStringAsFixed(2).addCommas()}'
                  //                                             : '+$currencySymbol${s.turn.toStringAsFixed(2).addCommas()}',
                  //                                         style: sublineStyle.copyWith(
                  //                                             color: s.turn.isNegative
                  //                                                 ? UserThemes(isDark).redVarient
                  //                                                 : UserThemes(isDark).greenVarient,
                  //                                             fontWeight: FontWeight.w500))),
                  //                                     DataCell(Center(
                  //                                         child: Text(s.assetLength.toString(),
                  //                                             style: sublineStyle))),
                  //                                   ]);
                  //                             }).toList()),
                  //                       ],
                  //                     ))
                  //                 .toList()),
                  //       ],
                  //     ),
                  //   ),
                  // ),







































                   // Padding(
                    //   padding: EdgeInsets.only(bottom: 20, top: 20),
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(5),
                    //     child: Ink(
                    //       decoration: BoxDecoration(
                    //           color: UserThemes(themeMode).summaryColour,
                    //           borderRadius: BorderRadius.circular(Units().circularRadius),
                    //           border: Border.all(color: UserThemes(themeMode).border, width: 1)),
                    //       padding: EdgeInsets.all(10),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: 5,
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(userName, style: CustomTextStyles(themeMode).portfolioNameStyle),
                    //               Row(
                    //                 children: [
                    //                   FittedBox(
                    //                     fit: BoxFit.fitWidth,
                    //                     child: Text('$baseCurrency',
                    //                         style: TextStyle(
                    //                             color: UserThemes(themeMode).textColorVarient,
                    //                             fontsize: Units().iconSize,
                    //                             fontWeight: FontWeight.w300)),
                    //                   ),
                    //                   Text(
                    //                     '${overallValue.toStringAsFixed(2).addCommas()}',
                    //                     style: TextStyle(
                    //                       color: UserThemes(themeMode).textColor,
                    //                       fontWeight: FontWeight.w600,
                    //                       fontSize: 27,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(top: 15.0),
                    //             child: Row(
                    //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Flexible(
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Row(
                    //                         crossAxisAlignment: CrossAxisAlignment.center,
                    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                         children: [
                    //                           FittedBox(
                    //                               fit: BoxFit.fitWidth,
                    //                               child: Text('EARNINGS', style: assetHeaderStyle)),
                    //                           FittedBox(
                    //                             fit: BoxFit.fitWidth,
                    //                             child: Text(
                    //                               overallReturn > 1000000
                    //                                   ? '+$baseCurrency${NumberFormat.compact().format(overallReturn)}'
                    //                                   : (double.parse(overallReturn.toString())) >= 0
                    //                                       ? '+$baseCurrency${overallReturn.toStringAsFixed(2).addCommas()} (${(double.parse(overallReturnPercent.toString())).toStringAsFixed(2).addCommas()}%)'
                    //                                       : '-$baseCurrency${(overallReturn * -1).toStringAsFixed(2).addCommas()} (${(double.parse(overallReturnPercent.toString())).toStringAsFixed(2).addCommas()}%)',
                    //                               style: TextStyle(
                    //                                   fontSize: 17,
                    //                                   fontWeight: FontWeight.w500,
                    //                                   color: (double.parse(overallReturn.toString()) >= 0
                    //                                       ? UserThemes(themeMode).greenVarient //Colors.green
                    //                                       : UserThemes(themeMode).redVarient)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       SizedBox(
                    //                         height: 5,
                    //                       ),
                    //                       Row(
                    //                         crossAxisAlignment: CrossAxisAlignment.center,
                    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                         children: [
                    //                           FittedBox(
                    //                               fit: BoxFit.fitWidth,
                    //                               child: Text('DAILY', style: assetHeaderStyle)),
                    //                           FittedBox(
                    //                             fit: BoxFit.fitWidth,
                    //                             child: Text(
                    //                               (double.parse(overallDailyReturn.toString())) >= 0
                    //                                   ? '+$baseCurrency${overallDailyReturn.toStringAsFixed(2).addCommas()} (${(double.parse(overallDailyReturnPercent.toString())).toStringAsFixed(2).addCommas()}%)'
                    //                                   : '-$baseCurrency${(overallDailyReturn * -1).toStringAsFixed(2).addCommas()} (${(double.parse(overallDailyReturnPercent.toString())).toStringAsFixed(2).addCommas()}%)',
                    //                               style: TextStyle(
                    //                                   fontSize: 17,
                    //                                   fontWeight: FontWeight.w500,
                    //                                   color: (double.parse(overallDailyReturn.toString()) >= 0
                    //                                       ? UserThemes(themeMode).greenVarient //Colors.green
                    //                                       : UserThemes(themeMode).redVarient)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       SizedBox(
                    //                         height: 5,
                    //                       ),
                    //                       Row(
                    //                         crossAxisAlignment: CrossAxisAlignment.center,
                    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                         children: [
                    //                           FittedBox(
                    //                               fit: BoxFit.fitWidth,
                    //                               child: Text('INVESTED', style: assetHeaderStyle)),
                    //                           SizedBox(width: 20),
                    //                           FittedBox(
                    //                             fit: BoxFit.fitWidth,
                    //                             child: Text(
                    //                                 '$baseCurrency${overallInvestment.toStringAsFixed(2).addCommas()}', //${p['baseCurrency']}
                    //                                 style: TextStyle(
                    //                                     fontSize: 17,
                    //                                     color: UserThemes(themeMode).textColorVarient,
                    //                                     fontWeight: FontWeight.w500)),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 5,
                    //           ),

                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

              