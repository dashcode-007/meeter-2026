import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meter_app/res/app_assets/app_image.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({
    super.key,
    this.onPressed,
    this.size = 56,
    this.iconPadding = 10,
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.black12,
    this.blurRadius = 10,
    this.shadowOffset = const Offset(0, 4),
    this.child,
  });

  final VoidCallback? onPressed;
  final double size;
  final double iconPadding;
  final Color backgroundColor;
  final Color shadowColor;
  final double blurRadius;
  final Offset shadowOffset;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            offset: shadowOffset,
          ),
        ],
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: FloatingActionButton(
          onPressed: onPressed ??
              () {
                log('Support button pressed');
              },
          backgroundColor: backgroundColor,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(iconPadding),
            child: Image.asset(AppImage.floatIcon),
          ),
        ),
      ),
    );
  }
}
