import 'package:flutter/material.dart';
import '../read_only_text_field.dart';

class PaddingTotalValue extends StatelessWidget {
  const PaddingTotalValue({
    super.key,
    required this.recentValue,
    required this.selectedCurrency,
  });

  final double recentValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyReadOnlyTextField(
        recentValue: recentValue,
        selectedCurrency: selectedCurrency,
      ),
    );
  }
}
