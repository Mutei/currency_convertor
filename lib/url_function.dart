import 'dart:convert';

import 'package:http/http.dart' as http;

class URL {
  Future<double> fetchExchangeRates(String selectedCurrency) async {
    double num;
    try {
      const apiKey = 'e0892b10c3dc40b46971e6a98f5ef516';
      String uriString =
          'http://api.exchangerate.host/live?access_key=$apiKey&base=USD&symbols=$selectedCurrency'; // Modify URL
      final response = await http.get(
        Uri.parse(uriString),
      );

      print("API Request URL: $uriString"); // Log the API request URL

      if (response.statusCode == 200) {
        var data = response.body;
        print("API Response: $data"); // Log the API response
        print("This is the ${response.statusCode}");
        var decodedInfo = jsonDecode(data);
        print("Decoded Info: $decodedInfo"); // Log the decoded JSON data

        num = decodedInfo['quotes']['USD$selectedCurrency'];
        print(
            "Exchange Rate for $selectedCurrency: $num"); // Log the exchange rate
        return num;
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print("This is the problem $e");
      return 0;
    }
  }
}
