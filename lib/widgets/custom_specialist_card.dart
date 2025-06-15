import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mummy_guide/models/consultant_model.dart';

class ConsultantCard extends StatelessWidget {
  final ConsultantModel consultant;
  const ConsultantCard({super.key, required this.consultant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffFFCBD4), width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: (0.2 * 255)),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min, // مهم لتقليل مساحة العمود
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.star_border),
                Icon(FontAwesomeIcons.ellipsis),
              ],
            ),

            const SizedBox(height: 10),

            // صورة الدكتور
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(consultant.image),
            ),

            const SizedBox(height: 10),

            // اسم الدكتور
            Text(
              consultant.name,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),

            // التخصص
            Text(
              consultant.description,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // زر المراسلة
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffFF8EA2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // مهم ليتناسب داخل Column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consultant.address,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.phone, color: Colors.white),
                      Text(
                        consultant.phoneNumber,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
