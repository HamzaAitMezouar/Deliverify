import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  FadeRoute({required this.child})
      : super(
          fullscreenDialog: true,
          transitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget child;
  ScaleRoute({required this.child})
      : super(
          fullscreenDialog: true,
          transitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
