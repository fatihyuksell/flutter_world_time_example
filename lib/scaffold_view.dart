import 'package:flutter/material.dart';

class ScaffoldView extends StatefulWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool resizeToAvoidBottomInset;
  final void Function()? onBackButtonPressed;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final bool drawerEnableOpenDragGesture;
  final void Function(bool isChanged)? onDrawerChanged;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  const ScaffoldView({
    required this.body,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.onBackButtonPressed,
    this.drawer,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.floatingActionButtonAnimator,
    this.bottomNavigationBar,
    this.drawerEnableOpenDragGesture = false,
    this.onDrawerChanged,
    super.key,
  });

  @override
  State<ScaffoldView> createState() => _ScaffoldViewState();
}

class _ScaffoldViewState extends State<ScaffoldView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.appBar,
      onDrawerChanged: widget.onDrawerChanged,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: widget.body,
    );
  }
}
