import 'package:flutter/material.dart';

extension MediaQuerySizeExtension on BuildContext {
  double sizeWidth(double w) {
    return MediaQuery.sizeOf(this).width * w;
  }

  double sizeHeight(double h) {
    return MediaQuery.sizeOf(this).height * h;
  }

  Offset center(Offset f) {
    return MediaQuery.sizeOf(this).center(f);
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}