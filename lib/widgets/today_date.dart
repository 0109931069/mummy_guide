import 'package:flutter/material.dart';

class TodayDate extends StatelessWidget {
  const TodayDate({super.key, required this.todayDate});

  final String todayDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.date_range_outlined),
        ),
        Text(todayDate, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
