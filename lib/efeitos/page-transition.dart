import 'package:flutter/material.dart';

class CustomTransitionBuilder extends PageTransitionsBuilder {
  const CustomTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final tween = Tween(begin: 1.5, end: 1.0).chain(
      CurveTween(
        curve: Curves.easeInOut,
      ),
    );

    return ScaleTransition(
      scale: animation.drive(tween),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
