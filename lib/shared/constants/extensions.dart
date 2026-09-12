import 'package:flutter/material.dart';

extension MediaQuerySizeExtension on BuildContext {
  double sizeWidth(double w) {
    return MediaQuery.sizeOf(this).width * w;
  }

  double sizeHeight(double h) {
    return MediaQuery.sizeOf(this).height * h;
  }


// Get the proportionate height as per screen size
  double dynamicScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * MediaQuery.sizeOf(this).height;
  }

// Get the proportionate height as per screen size
  double dynamicScreenWidth(double inputWidth) {
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * MediaQuery.sizeOf(this).width;
  }

  Offset center(Offset f) {
    return MediaQuery.sizeOf(this).center(f);
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}