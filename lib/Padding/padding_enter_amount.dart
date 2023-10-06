import 'package:flutter/material.dart';
import '../input_text_field.dart';

class PaddingEnterAmount extends StatelessWidget {
  const PaddingEnterAmount({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextField(controller: controller),
    );
  }
}
