import 'package:flutter/material.dart';
import 'constant.dart';
import 'input_text_field.dart';
import 'url_function.dart';
import 'list.dart';
import 'Padding/padding_total_value.dart';

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
  String searchText = '';
  List<String> filteredCurrencies = [];

  // ...

  @override
  void initState() {
    super.initState();

    // Initialize the filtered list with all currencies initially
    filteredCurrencies = listLength.getCurrenciesList();
    // ...
  }

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a currency...',
                    hintStyle: TextStyle(color: kPrimaryColor),
                    filled: true,
                    fillColor: kSecondPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                      // Filter the currency list based on the search text
                      filteredCurrencies =
                          listLength.getCurrenciesList().where((currency) {
                        return currency.toLowerCase().contains(searchText);
                      }).toList();
                    });
                  },
                ),
              ),
              // Display the filtered currency list
              SizedBox(
                height: 100, // Set the desired height
                child: ListView.builder(
                  itemCount: filteredCurrencies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredCurrencies[index],
                        style: const TextStyle(color: kListTileTextColors),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCurrency = filteredCurrencies[index];
                        });
                      },
                    );
                  },
                ),
              ),
              PaddingEnterAmount(controller: controller),
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
              PaddingTotalValue(
                  recentValue: recentValue, selectedCurrency: selectedCurrency),
            ],
          ),
        ),
      ),
    );
  }
}

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

// DropdownButton<String>(
//   value: selectedCurrency,
//   onChanged: (String? newValue) {
//     setState(() {
//       selectedCurrency = newValue!;
//     });
//   },
//   items: listLength
//       .getCurrenciesList()
//       .map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(
//         value,
//         style: const TextStyle(color: Colors.black87),
//       ),
//     );
//   }).toList(),
// ),

// TextField(
//   decoration: const InputDecoration(
//     labelText: 'Search Currency',
//     hintText: 'Enter a currency...',
//   ),
//   onChanged: (value) {
//     setState(() {
//       searchText = value.toLowerCase();
//       // Filter the currency list based on the search text
//       filteredCurrencies =
//           listLength.getCurrenciesList().where((currency) {
//         return currency.toLowerCase().contains(searchText);
//       }).toList();
//     });
//   },
// ),
// Display the filtered currency list

// Container(
// padding: EdgeInsets.only(left: 300),
// child: IconButton(
// icon: Icon(Icons.search),
// onPressed: () {
// openSearchDialog(context);
// },
// ),
// ),

// void openSearchDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Search Currency'),
//         content: TextField(
//           decoration: const InputDecoration(
//             hintText: 'Enter a currency...',
//           ),
//           onChanged: (value) {
//             setState(() {
//               searchText = value.toLowerCase();
//               // Filter the currency list based on the search text
//               filteredCurrencies =
//                   listLength.getCurrenciesList().where((currency) {
//                 return currency.toLowerCase().contains(searchText);
//               }).toList();
//             });
//           },
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       );
//     },
//   );
// }
