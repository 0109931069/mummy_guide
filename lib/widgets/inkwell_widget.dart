import 'package:flutter/material.dart';
import 'package:mummy_guide/utils/globals.dart';

class InkwellWidget extends StatelessWidget {
  InkwellWidget({super.key, this.textWidget, this.ontap, this.bg});
  final Text? textWidget;
  final VoidCallback? ontap;
  Color? bg = Globals.btncolor.withValues(
    alpha: 0.5,
  );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15,
          ),
          color:bg
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
