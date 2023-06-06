import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class NoSearchResults extends StatelessWidget {
  const NoSearchResults();

  @override
  Widget build(BuildContext context) {
    return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      child: Image.asset(
                                    'assets/icons/no_result.png',
                                    width: 100,
                                    height: 100,
                                    color: chartTextColour,
                                  )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(
                                      'No results :(',
                                      style: CustomTextStyles(context)
                                          .portfolioNameStyle
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: chartTextColour,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Check for spelling errors or Try different ',
                                    style: CustomTextStyles(widget.dataObject.context)
                                        .portfolioNameStyle
                                        .copyWith(
                                          color: chartTextColour,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'keywords ',
                                    style: CustomTextStyles(widget.dataObject.context)
                                        .portfolioNameStyle
                                        .copyWith(
                                          color: chartTextColour,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          )
                       ;
  }
}
