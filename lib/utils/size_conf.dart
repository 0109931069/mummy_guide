import 'package:flutter/material.dart';

/// Utility class for managing screen size and orientation configuration.
class SizeConfig {
  /// Screen width in logical pixels.
  static double? screenWidth;

  /// Screen height in logical pixels.
  static double? screenHeight;

  /// Default size used for scaling UI elements.
  static double? defaultSize;

  /// Current screen orientation.
  static Orientation? orientation;

  /// Initializes the size configuration based on the given context.
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * .024
        : screenWidth! * .024;
    // Removed debug print statement for production code.
  }
}
