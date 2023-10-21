import 'package:flutter/material.dart';
import 'constant.dart';
import 'Padding/padding_enter_amount.dart';
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

  void openSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          title: const Text(
            'Enter a Currency',
            style: TextStyle(
              color: kSearchDialogueTextColors,
            ),
          ),
          content: TextField(
            decoration: const InputDecoration(
              hintText: 'Ex: (SAR or Saudi Riyals) ',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            style: const TextStyle(
              color: kSearchDialogueTextColors,
            ),
            onChanged: (value) {
              setState(() {
                searchText = value.toLowerCase();

                filteredCurrencies =
                    listLength.getCurrenciesList().where((currency) {
                  return currency.toLowerCase().contains(searchText) ||
                      listLength
                          .getFullCurrencyName(currency)
                          .toLowerCase()
                          .contains(searchText);
                }).toList();
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Update the selected currency here
                if (filteredCurrencies.isNotEmpty) {
                  setState(() {
                    selectedCurrency = filteredCurrencies[
                        0]; // Update with the first item in the filtered list
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Search'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: kSearchDialogueTextColors,
            ),
            onPressed: () {
              openSearchDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag:
                      'uniqueTag', // Make sure this tag matches the one in SplashScreen
                  child: Image.asset(
                    'images/logo.png',
                    width: 200,
                    height: 200,
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
                            style: const TextStyle(
                                color: kSearchDialogueTextColors),
                          ),
                          onTap: () {
                            setState(() {
                              // Check if the selected currency is a full name, and find its shortcut
                              selectedCurrency = listLength
                                  .getCurrenciesList()
                                  .firstWhere(
                                    (currency) =>
                                        currency.toLowerCase() ==
                                            filteredCurrencies[index]
                                                .toLowerCase() ||
                                        listLength
                                                .getFullCurrencyName(currency)
                                                .toLowerCase() ==
                                            filteredCurrencies[index]
                                                .toLowerCase(),
                                    orElse: () =>
                                        selectedCurrency, // Use the current selection if not found
                                  );
                            });
                          });
                    },
                  ),
                ),

                PaddingEnterAmount(controller: controller),

                PaddingTotalValue(
                    recentValue: recentValue,
                    selectedCurrency: selectedCurrency),
                ElevatedButton(
                  onPressed: updateCurrency,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      kSearchDialogueTextColors,
                    ),
                  ),
                  child: const Text(
                    "Convert",
                    style: TextStyle(color: kSecondPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
