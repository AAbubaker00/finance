import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

enum BgTheme { DARK, LIGHT }

class CWScaffold extends StatelessWidget {
  final String? appBarTitle;

  final int? appbarColourOption;

  final List<Widget>? appBarActions;

  final Widget? body;
  final Widget? appBarWidget;
  final Widget? customFloatinfActionButtonWidget;
  final Widget? appBarTitleWidget;
  final dynamic appBarBottomWidget;

  final bool? isCenter;
  final bool isAppBarOnlineBlur;
  final bool showFloatingBtn;
  final bool bottomAppBarBorderColour;
  final bool customFloatingActionButton;
  final bool resizeToAvoidBottomInset;

  final scaffoldBgColour;

  final FloatingActionButtonLocation? floatingActionButttonLocation;

  final Function? floatingBtnFunction;

  final double preferredSizeValue;

  const CWScaffold(
      {Key? key,
       this.appBarTitle,
       this.appBarActions,
       this.body,
       this.appBarWidget,
       this.isCenter,
      this.showFloatingBtn = false,
       this.floatingBtnFunction,
       this.appBarTitleWidget,
      this.bottomAppBarBorderColour = true,
      this.appbarColourOption = 1,
      this.customFloatingActionButton = false,
       this.customFloatinfActionButtonWidget,
       this.floatingActionButttonLocation,
      this.scaffoldBgColour = BgTheme.DARK,
       this.appBarBottomWidget,
      this.preferredSizeValue = 2,
      this.isAppBarOnlineBlur = false,
      this.resizeToAvoidBottomInset = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(a)
    appBarActions!.add(SizedBox(
      width: 15,
    ));

    return Container(
      color: appbarColourOption == 1 ? summaryColour : backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: scaffoldBgColour == BgTheme.DARK ? backgroundColour : summaryColour,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          floatingActionButtonLocation: floatingActionButttonLocation == null
              ? FloatingActionButtonLocation.centerFloat
              : floatingActionButttonLocation,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: showFloatingBtn
              ? customFloatingActionButton
                  ? customFloatinfActionButtonWidget
                  : Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CWApplyButton(
                        customTextColour: Colors.white,
                        function: floatingBtnFunction, borderRadius: null, customBorder: null, customColour: null, customTextStyle: null, icon: null,
                      ))
              : Container(),
          appBar: appBarTitleWidget == null &&
                  appBarTitle == null &&
                  appBarWidget == null &&
                  appBarBottomWidget == null
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(
                      appBarBottomWidget == null ? kToolbarHeight : kToolbarHeight * preferredSizeValue),
                  child: Container(
                    decoration: CustomDecoration(
                      appbarBottomBorderColour: bottomAppBarBorderColour,
                      appBarColourOption: appbarColourOption,
                    ).appBarContainerDecoration,
                    child: appBarWidget == null
                        ? AppBar(
                            bottom: appBarBottomWidget != null
                                ? appBarBottomWidget
                                : PreferredSize(preferredSize: Size.fromHeight(0), child: Container()),
                            titleSpacing: 0,
                            elevation: 0,
                            iconTheme: IconThemeData(
                              color: backColour, //change your color here
                            ),
                            backgroundColor: appbarColourOption == 1 ? summaryColour : backgroundColour,
                            title: appBarTitleWidget == null
                                ? appBarTitle == null
                                    ? null
                                    : Padding(
                                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                                        child: Text(
                                          appBarTitle!,
                                          style: CustomTextStyles(context).appBarTitleStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                : appBarTitleWidget,
                            centerTitle: isCenter,
                            actions: appBarActions,
                          )
                        : appBarWidget,
                  ),
                ),
          body: body,
        ),
      ),
    );
  }
}
