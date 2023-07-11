import 'package:flutter/material.dart';

class TripleResponsiveLayoutBuilder extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  const TripleResponsiveLayoutBuilder({
    Key? key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if (constraints.maxWidth < 512) {
            return mobileLayout;
          } else if (constraints.maxWidth < 1024) {
            return tabletLayout;
          } else if (constraints.maxWidth >= 1024) {
            return desktopLayout;
          } else {
            return desktopLayout;
          }
        }
    );
  }
}

class DoubleResponsiveLayoutBuilder700px extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const DoubleResponsiveLayoutBuilder700px({
    Key? key,
    required this.mobileLayout,
    required this.desktopLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 700) {
            return mobileLayout;
          } else {
            return desktopLayout;
          }
        }
    );
  }
}

class DoubleResponsiveLayoutBuilder1024px extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const DoubleResponsiveLayoutBuilder1024px({
    Key? key,
    required this.mobileLayout,
    required this.desktopLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 1024) {
            return mobileLayout;
          } else {
            return desktopLayout;
          }
        }
    );
  }
}