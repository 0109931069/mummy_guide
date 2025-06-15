

import 'package:flutter/material.dart';

/// A customizable text widget with optional styling and alignment.
class TextWidget extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The style to apply to the text.
  final TextStyle? style;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// Creates a TextWidget.
  const TextWidget({
    super.key,
    required this.text,
    this.style,
    this.overflow,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? const TextStyle(),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
