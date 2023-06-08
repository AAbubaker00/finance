import 'package:valuid/shared/TextStyle/customTextStyles.dart';
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

  late AnimationController _controller;
  late Animation<double> _animation;

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

class MainLoading extends StatefulWidget {
  final bool isbgColourActive;

  MainLoading({Key? key, this.isbgColourActive = true}) : super(key: key);

  @override
  State<MainLoading> createState() => _MainLoadingState();
}

class _MainLoadingState extends State<MainLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: summaryColour,
      child: Stack(
        children: [
          Center(
              child: Container(
                  color: widget.isbgColourActive ? summaryColour : Colors.transparent,
                  child: ClipRRect(child: Image.asset('assets/icons/onvestingLoadLogo.png', scale: 10)))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                    child: Text(
                      'Connecting',
                    ),
                    style:
                        CustomTextStyles(context).portfolioNameStyle.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      backgroundColor: backgroundColourVarient,
                      color: blueVarient,
                      minHeight: 6,     
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
