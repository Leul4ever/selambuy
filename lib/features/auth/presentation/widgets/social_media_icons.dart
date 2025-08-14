import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleIcon extends StatelessWidget {
  final double size;
  final Color? backgroundColor;

  const GoogleIcon({
    super.key,
    this.size = 24.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/icons/google_icon.svg',
        width: size * 0.8,
        height: size * 0.8,
        fit: BoxFit.contain,
      ),
    );
  }
}

class XIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const XIcon({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/x_icon.svg',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
