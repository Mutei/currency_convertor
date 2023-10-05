import 'package:flutter/material.dart';
import 'constant.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      style: const TextStyle(
        color: kHintStyleColor,
      ),
      decoration: const InputDecoration(
        hintText: "Enter your amount in USD",
        hintStyle: TextStyle(
          color: kHintStyleColor,
        ),
        prefixIcon: Icon(
          Icons.attach_money,
          color: kHintStyleColor,
        ),
        filled: true,
        fillColor: kFilledColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
    );
  }
}