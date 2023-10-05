import 'package:flutter/material.dart';
import 'constant.dart';
import 'input_text_field.dart';
import 'url_function.dart';
import 'list.dart';
import 'read_only_text_field.dart';

class CurrencyConvertor extends StatefulWidget {
  const CurrencyConvertor({Key? key}) : super(key: key);

  @override
  State<CurrencyConvertor> createState() => _CurrencyConvertorState();
}

class _CurrencyConvertorState extends State<CurrencyConvertor> {
  URL url = URL();
  Length listLength = Length();
  TextEditingController controller = TextEditingController();
  double recentValue = 0.0;
  double conversionRate = 3.75;
  String selectedCurrency = 'AED';

  void updateCurrency() async {
    double dollars = double.tryParse(controller.text) ?? 0.0;
    double currencyTypeInput = await url.fetchExchangeRates(selectedCurrency);
    setState(() {
      recentValue = dollars * currencyTypeInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   '${recentValue.toStringAsFixed(2)} $selectedCurrency',
            //   style: const TextStyle(
            //     fontSize: 60,
            //     fontWeight: FontWeight.bold,
            //     color: kTextColor,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputTextField(controller: controller),
            ),
            DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCurrency = newValue!;
                });
              },
              items: listLength
                  .getCurrenciesList()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black87),
                  ),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: updateCurrency,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kSecondPrimaryColor,
                ),
              ),
              child: const Text(
                "Convert",
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyReadOnlyTextField(
                recentValue: recentValue,
                selectedCurrency: selectedCurrency,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
