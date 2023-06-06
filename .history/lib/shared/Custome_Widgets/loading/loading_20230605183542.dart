import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final bool isbgColourActive;

  Loading({Key? key, this.isbgColourActive = true}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  AnimationController _controller;
  Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.isbgColourActive ? summaryColour : Colors.transparent,
        child: FadeTransition(
          opacity: _animation,
          child: ClipRRect(
              child: Image.asset(
            'assets/icons/onvestingLoadLogo.png',
            scale: 10,
          )),
        ));
  }
}
