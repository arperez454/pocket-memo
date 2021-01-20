import 'dart:math';

class WidgetAlignment {
  final double value;

  const WidgetAlignment(this.value) : assert(value != null);

  static const WidgetAlignment right = WidgetAlignment(0);
  static const WidgetAlignment top = WidgetAlignment(3 * pi / 2);
  static const WidgetAlignment bottom = WidgetAlignment(pi / 2);
  static const WidgetAlignment left = WidgetAlignment(pi);
}
