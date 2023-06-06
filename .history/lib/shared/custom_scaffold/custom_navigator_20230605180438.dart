import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/custom_scaffold/custom_scaffold.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatefulWidget {
  /// The [Scaffold] provided by the Flutter SDK
  ///
  /// [Scaffold] `body` will be ignored and replaced by `children.first`
  final Scaffold scaffold;
  final DataObject dataObject;

  /// The pages that will be shown by every click
  ///
  /// They should placed in order such as:
  /// `page 0` will be presented when `item 0` in the [BottomNavigationBar] clicked.
  final List<Widget> children;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget handles your page navigation by default,
  /// so no need to keep track of the index
  final Function(int) onItemTap;

  CustomScaffold(
      // Can't be constant because of assertions :(
      {Key? key,
      required this.scaffold,
      required this.children,
      required this.dataObject,
      required this.onItemTap})
      : assert(scaffold != null),
        assert(children != null),
        assert(scaffold.bottomNavigationBar != null),
        assert(scaffold.bottomNavigationBar is BottomNavigationBar,
            '[CustomScaffold] require an instance of [BottomNavigationBar]'),
        assert((scaffold.bottomNavigationBar as BottomNavigationBar).items.length == children.length,
            '[BottomNavigationBar] and `children` should be the same size'),
        super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffold.key,
      appBar: widget.scaffold.appBar,
      bottomNavigationBar: _bottomNavBar(),
      backgroundColor: widget.scaffold.backgroundColor,
      bottomSheet: widget.scaffold.bottomSheet,
      body: CustomNavigator(
        navigatorKey: _key,
        home: widget.children[_index],
        pageRoute: PageRoutes.materialPageRoute,
      ),
      drawer: widget.scaffold.drawer,
      drawerDragStartBehavior: widget.scaffold.drawerDragStartBehavior,
      drawerScrimColor: widget.scaffold.drawerScrimColor,
      endDrawer: widget.scaffold.endDrawer,
      extendBody: widget.scaffold.extendBody,
      floatingActionButton: widget.scaffold.floatingActionButton,
      floatingActionButtonAnimator: widget.scaffold.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.scaffold.floatingActionButtonLocation,
      persistentFooterButtons: widget.scaffold.persistentFooterButtons,
      primary: widget.scaffold.primary,
      resizeToAvoidBottomInset: widget.scaffold.resizeToAvoidBottomInset,
    );
  }

  _bottomNavBar() {
    assert(widget.scaffold.bottomNavigationBar != null);

    widget.dataObject.key = _key;
    widget.dataObject.changePage = changepage;

    BottomNavigationBar? b = widget.scaffold.bottomNavigationBar as BottomNavigationBar?;
    return Ink(
      decoration: BoxDecoration(
        color: summaryColour,
        border: Border(
            top: BorderSide(
          color: seperator.withOpacity(.8),
        )),
      ),
      padding: const EdgeInsets.only(top: 5.0),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          key: b!.key,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Image.asset('assets/icons/pie.png',
                      width: navIconSize,
                      height: navIconSize,
                      color: _index == 0 ? blueVarient : navIconColour),
                  Column(children: [
                    SizedBox(height: 5),
                    Text('Home', style: CustomTextStyles(context, isChange: (_index == 0)).deleteTextStyle)
                  ])
                ]),
                label: 'Home'),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Image.asset('assets/icons/cal.png',
                      width: navIconSize,
                      height: navIconSize,
                      color: _index == 1 ? blueVarient : navIconColour),
                  Column(children: [
                    SizedBox(height: 5),
                    Text('Calender',
                        style: CustomTextStyles(context, isChange: (_index == 1)).deleteTextStyle)
                  ])
                ]),
                label: 'Events'),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Image.asset('assets/icons/search.png',
                      width: navIconSize,
                      height: navIconSize,
                      color: _index == 2 ? blueVarient : navIconColour),
                  Column(children: [
                    SizedBox(height: 5),
                    Text('Search', style: CustomTextStyles(context, isChange: (_index == 2)).deleteTextStyle)
                  ])
                ]),
                label: 'Search'),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Image.asset('assets/icons/menu.png',
                      width: navIconSize,
                      height: navIconSize,
                      color: _index == 4 ? blueVarient : navIconColour),
                  Column(children: [
                    SizedBox(height: 5),
                    Text('More', style: CustomTextStyles(context, isChange: (_index == 4)).deleteTextStyle)
                  ])
                ]),
                label: 'More'),
          ],
          currentIndex: _index,
          onTap: (index) => changepage(index),
          backgroundColor: b.backgroundColor,
          elevation: b.elevation,
          fixedColor: b.selectedItemColor == null ? b.fixedColor : null,
          iconSize: b.iconSize,
          selectedFontSize: b.selectedFontSize,
          selectedIconTheme: b.selectedIconTheme,
          // selectedItemColor: b.selectedItemColor,
          selectedLabelStyle: b.selectedLabelStyle,
          showSelectedLabels: b.showSelectedLabels,
          showUnselectedLabels: b.showUnselectedLabels,
          type: b.type,
          unselectedFontSize: b.unselectedFontSize,
          unselectedIconTheme: b.unselectedIconTheme,
          unselectedItemColor: b.unselectedItemColor,
          unselectedLabelStyle: b.unselectedLabelStyle,
        ),
      ),
    );
  }

  changepage(var index) {
    setState(() {
      widget.dataObject.pageindex = index;
      _index = widget.dataObject.pageindex;
    });

    _key.currentState!.popUntil((route) => route.isFirst == true);
    widget.onItemTap(index);
  }
}
