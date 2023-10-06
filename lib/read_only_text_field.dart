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
        color: kSearchDialogueTextColors,
      ),
      decoration: const InputDecoration(
        filled: true,
        fillColor: kSecondPrimaryColor,
      ),
      controller: TextEditingController(text: readOnlyText),
    );
  }
}
