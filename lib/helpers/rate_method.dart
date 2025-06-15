import 'package:flutter/material.dart';

Widget rateMethod(double rate) {
  if (0 <= rate && rate < 1) {
    return const Row(
      children: [
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
      ],
    );
  } else if (1 <= rate && rate < 2) {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 16),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
      ],
    );
  } else if (2 <= rate && rate < 3) {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
      ],
    );
  } else if (3 <= rate && rate < 4) {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, size: 15),
        Icon(Icons.star, size: 15),
      ],
    );
  } else if (4 <= rate && rate < 5) {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, size: 15),
      ],
    );
  } else if (rate == 5) {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
        Icon(Icons.star, color: Colors.yellow, size: 15),
      ],
    );
  } else {
    return const SizedBox();
  }
}
