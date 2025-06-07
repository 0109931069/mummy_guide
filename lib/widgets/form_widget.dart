// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    this.controller,
    this.text,
    this.keyboard,
    this.obsecure
  });
  final TextEditingController? controller;
  final String? text;
  final TextInputType? keyboard; 
  final bool? obsecure ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label for the email inpu
        // TextField for email input

        TextField(
          controller: controller,
          keyboardType: keyboard,
          obscureText: obsecure == null ? false : true,
          decoration: InputDecoration(
            hintText: text!,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
