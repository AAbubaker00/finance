import 'package:flutter/material.dart';

class CustomPageRouteSlideTransition extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;

  CustomPageRouteSlideTransition({required this.child, required this.direction, RouteSettings settings})
      : super(
            transitionDuration: Duration(milliseconds: 200),
            reverseTransitionDuration: Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) => child,
            settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: getBeingOffset(), end: Offset.zero).animate(animation),
        child: child,
      );

  getBeingOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
    }
  }
}

class CustomPageRouteFadeTransition extends StatefulWidget {
  CustomPageRouteFadeTransition({Key key}) : super(key: key);

  @override
  State<CustomPageRouteFadeTransition> createState() => _CustomPageRouteFadeTransitionState();
}

class _CustomPageRouteFadeTransitionState extends State<CustomPageRouteFadeTransition>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _animationControl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationControl = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animationControl.forward();
  }

  AnimationController _animationControl;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
