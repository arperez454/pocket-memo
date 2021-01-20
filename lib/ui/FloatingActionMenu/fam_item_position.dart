import 'dart:math';

import 'package:cubaros/ui/FloatingActionMenu/utils/fam_aligns.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OptionPosition extends StatelessWidget {
  final double radius;
  final double angle;
  final WidgetAlignment alignment;
  final Widget child;

  const OptionPosition({
    Key key,
    this.radius,
    this.angle,
    this.child,
    this.alignment = WidgetAlignment.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final x = cos(alignment.value - angle) * radius;
    final y = sin(alignment.value - angle) * radius;
    return Transform(
      transform: Matrix4.translationValues(x, y, 0.0),
      child: child,
    );
  }
}
