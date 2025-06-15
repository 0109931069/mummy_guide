import 'package:flutter/material.dart';

List<Widget> buildHighlights(List<String> highlights) {
  return highlights.map((text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ), // رمز القائمة
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }).toList();
}
