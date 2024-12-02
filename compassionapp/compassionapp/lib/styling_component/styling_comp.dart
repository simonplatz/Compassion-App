import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final ShapeBorder? shape;
  final Color? color;

  const StyledCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.shape,
    this.color,
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
      color: color ?? Colors.teal[50], // Use the color property or default to teal[50]
      child: Padding(
        padding: padding ?? const EdgeInsets.all(7.0),
        child: child,
      ),
    );
  }
}