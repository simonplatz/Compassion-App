import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
 final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final ShapeBorder? shape;

  const StyledCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(4.0),
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(30.0),
          ),
      elevation: elevation ?? 4.0,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(7.0),
        child: child,
      ),
    );
  }
}