import 'package:flutter/material.dart';

/// A customizable InkWell widget with text and an arrow icon.
class InkwellWidget extends StatelessWidget {
  /// The text widget to display inside the InkWell.
  final Text? textWidget;

  /// The callback function to execute on tap.
  final VoidCallback? ontap;

  /// The background color of the container.
  final Color? bg;

  /// Creates an InkwellWidget.
  const InkwellWidget({
    super.key,
    this.textWidget,
    this.ontap,
    this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (MediaQuery.sizeOf(context).width - 40) * 0.6,
              child: textWidget,
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
