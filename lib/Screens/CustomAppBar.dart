import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:32.0),
      child: Container(
        height: preferredSize.height,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}