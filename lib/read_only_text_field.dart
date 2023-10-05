import 'package:flutter/material.dart';
import 'constant.dart';

class MyReadOnlyTextField extends StatelessWidget {
  final double recentValue;
  final String selectedCurrency;
  MyReadOnlyTextField(
      {required this.recentValue, required this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    String readOnlyText = '${recentValue.toStringAsFixed(2)} $selectedCurrency';

    return TextField(
      readOnly: true,
      style: const TextStyle(
        color: kPrimaryColor,
      ),
      decoration: const InputDecoration(
        labelText: 'Total Value',
        filled: true,
        fillColor: kSecondPrimaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
      controller: TextEditingController(text: readOnlyText),
    );
  }
}
