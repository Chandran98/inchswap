
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';


class SwapApi {
  static const chainId = 137; // Chain ID for Polygon (Matic)
  static const web3RpcUrl = "https://polygon-rpc.com/";

  final String _endPoint = 'https://api.1inch.dev/swap/v6.0/';
  final broadcastApiUrl =
      "https://api.1inch.dev/tx-gateway/v1.1/$chainId/broadcast";

  final Map<String, String> _headers = {
    "Authorization": "Bearer 2EQIam7nYCvCeAUIDYKD7G8qELgkmngn",
    "content-type": "application/json"
  };

  var credentials = EthPrivateKey.fromHex(
      "6a6e2beab51bc2fcf871862be43ffc515ed9a5627660898ca97bcecfc2c5624c");

  Uint8List hexToBytes(String hexString) {
    hexString = hexString.substring(2);
    var bytes = <int>[];
    for (var i = 0; i < hexString.length; i += 2) {
      var hexChar = hexString.substring(i, i + 2);
      var byte = int.parse(hexChar, radix: 16);
      bytes.add(byte);
    }
    return Uint8List.fromList(bytes);
  }

  Future<Map<String, dynamic>> swap() async {
    double quantity = 1;
    Map<String, dynamic> result = {};

    final queryParameters = {
      'src': "0x255707b70bf90aa112006e1b07b9aea6de021424",
      'dst': "0x2760e46d9bb43dafcbecaad1f64b93207f9f0ed7",
      'amount': (quantity * pow(10, 18)).toInt().toString(),
      'from': "0xF567C0CE34F85D3a3aFb0a4d47C5a350448a151F",
      'slippage': '1',
      'includeTokensInfo': 'true',
      'disableEstimate': 'true',
    };

    broadCastRawTransaction(tx) async {
      print("jsonEncode(tx)${jsonEncode(tx)}");
      try {
        var response = await http.post(Uri.parse(broadcastApiUrl),
            body: json.encode({'rawTransaction': tx}), headers: _headers);
            print("broadCastRawTransaction ${response.body}");
            // print("response.body${response.statusCode}");
      } catch (e) {
        print("broadCastRawTransaction$e");
      }
    }

    Uri uri = Uri.parse('$_endPoint$chainId/swap')
        .replace(queryParameters: queryParameters);

    try {
      http.Response response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200) {
        dynamic jsonTx = json.decode(response.body)['tx'];

        Web3Client web3client = Web3Client(web3RpcUrl, Client());

        final gasPrice = await web3client.getGasPrice();

        final balance = await web3client.getBalance(credentials.address);

        print(
            "Wallet balance: ${balance.getValueInUnit(EtherUnit.ether)} MATIC");

        EtherAmount estimatedGasCost = EtherAmount.fromUnitAndValue(
            EtherUnit.wei,
            (gasPrice.getValueInUnit(EtherUnit.wei) * 100000).toInt());

        if (balance.getInEther < estimatedGasCost.getInEther) {
          throw Exception("Insufficient funds for gas");
        }

        var transaction = Transaction(
          from: EthereumAddress.fromHex(jsonTx['from']),
          to: EthereumAddress.fromHex(jsonTx['to']),
          value: EtherAmount.fromUnitAndValue(
              EtherUnit.wei, int.parse(jsonTx['value'])),
          data: hexToBytes(jsonTx['data']),
          gasPrice: gasPrice,
          maxGas: 100000,
        );

        try {
          final dataKey = await web3client
              .sendTransaction(credentials, transaction, chainId: chainId);
          result.addAll({'transaction': dataKey});
          print("Transaction Id‹: ${dataKey}");
          broadCastRawTransaction(dataKey);
        } catch (e) {
          if (e.toString().contains('SafeTransferFromFailed')) {
            print("SafeTransferFromFailed error: Check allowance and balance.");
          } else {
            print("Error msg $e");
          }
        }
      } else {
        debugPrint('ErrCode: ${response.statusCode} - err: ${response.body}');
        result.addAll({'error': json.decode(response.body).toString()});
        throw Exception('1Inch swap error');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Error in calling 1Inch swap');
      result.addAll({'error': e.toString()});
    }
    return result;
  }
}
