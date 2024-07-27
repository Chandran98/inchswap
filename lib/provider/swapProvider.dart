
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swap/model/coinListModel.dart';
import "package:http/http.dart" as http;
import 'package:swap/utils/utils.dart';

// models/token.dart
class Token {
  final String symbol;
  final String name;
  final String address;
  final String logoURI;

  Token({required this.symbol, required this.name, required this.address, required this.logoURI});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      symbol: json['symbol'],
      name: json['name'],
      address: json['address'],
      logoURI: json['logoURI'],
    );
  }
}


class SwapProvider extends ChangeNotifier {
  List _coinList = [];
  List get coinList => _coinList;
List<Token> _tokens = [];

  List<Token> get tokens => _tokens;
  // List<Token> _filteredTokens = [];

  // List<Token> get tokens => _filteredTokens;

  bool _loading = false;
  get loading => _loading;
  setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  getCoinList() async {
    const apiUrl = "https://api.1inch.dev/token/v1.2/137/";
    // final body = {'voucher': voucher, "pin": pin};
    final Map<String, String> headers = {
      "Authorization": "Bearer 2EQIam7nYCvCeAUIDYKD7G8qELgkmngn",
      "accept": "application/json"
    };
    setLoading(true);
    print(apiUrl);
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      print("apiUrl${response.statusCode}");
      print("apiUrl${response.body}");
      if (response.statusCode == 200) {
      
       final data = json.decode(response.body) as Map<String, dynamic>;
       print("data$data asdfadf");
      _tokens = data.entries.map((entry) => Token.fromJson(entry.value)).toList();
             print("_tokens${_tokens.map((e) => e.address)} _tokens");
        setLoading(false);
      notifyListeners();
      } else {
        setLoading(false);
        Utils.snackbar('Failed - Please try again ', false);
      }
    } catch (e) {
      setLoading(false);
      // Utils.toastMessage('Failed to connect to server: $e');
      print('Failed to connect to server ${e}');
    }
  }

  // void filterTokens(String query) {
  //   if (query.isEmpty) {
  //     _filteredTokens = _tokens;
  //   } else {
  //     _filteredTokens = _tokens
  //         .where((token) =>
  //             token.name.toLowerCase().contains(query.toLowerCase()) ||
  //             token.symbol.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   notifyListeners();
  // }
}
