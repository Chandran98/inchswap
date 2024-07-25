import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class SwapApi {
  static const chainId = 137; // Chain ID for Binance Smart Chain (BSC)
  static const web3RpcUrl = "https://polygon-rpc.com/";
  // "https://bsc-dataseed.binance.org"; // URL for BSC node

  // final String _endPoint = 'https://api.1inch.io/v4.0/';

  final String _endPoint = 'https://api.1inch.dev/swap/v6.0/';

  final Map<String, String> _headers = {
    "Authorization": "Bearer 2EQIam7nYCvCeAUIDYKD7G8qELgkmngn",
    "content-type": "application/json"
  };
  // var pvtKey="5fbf0c975bae4025b5956aaa612e8047b7d959c84c46d81e0fc647442f47cf47";
  var credentials =
      EthPrivateKey.fromHex("0x7a66CDc2AfaB3540847048Eb7d4CfbDBCe05659e");

  swap() async {
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
    double quantity = 1;

    print("obdaadaject${(quantity * pow(10, 18)).toInt().toString()}");
    Map<String, dynamic> result = {};
    final queryParameters = {
      'src': "0xc2132D05D31c914a87C6611C10748AEb04B58e8F",
      'dst': "0xBbba073C31bF03b8ACf7c28EF0738DeCF3695683",
      'amount': (quantity * pow(10, 18)).toInt().toString(),
      'from': "0xF567C0CE34F85D3a3aFb0a4d47C5a350448a151F",
      'slippage': '1',
      'includeTokensInfo': 'true',
      'disableEstimate': 'true',
    };
    print("object $result ");

    Uri uri = Uri.parse('$_endPoint$chainId/swap')
        .replace(queryParameters: queryParameters);

    print("urri####$uri");

    try {
      print("queryParameters#$queryParameters");
      http.Response response = await http.get(uri, headers: _headers);

      print("response123${response.statusCode}");

      print("response.body${response.body}");
      if (response.statusCode == 200) {
        dynamic jsonTx = json.decode(response.body)['tx'];
        print("jsonTx $jsonTx");

        Web3Client web3client = Web3Client(web3RpcUrl, Client());

        final gasPrice = await web3client.getGasPrice();
        var transaction = Transaction(
          from: EthereumAddress.fromHex(jsonTx['from']),
          to: EthereumAddress.fromHex(jsonTx['to']),
          value: EtherAmount.fromUnitAndValue(
              EtherUnit.wei, int.parse(jsonTx['value'])),
          data: hexToBytes(jsonTx['data']),
          // gasPrice: EtherAmount.fromUnitAndValue(
          //     EtherUnit.wei, int.parse(jsonTx['gasPrice'])),
          gasPrice: gasPrice,
          maxGas: 100000,
        );
        print("transactionobject$transaction $gasPrice");

        try {
          final dataKey = await web3client
              .sendTransaction(credentials, transaction, chainId: chainId);

          print("dataKey$dataKey");
        } catch (e) {
          print("Error msg $e");
        }
        // );
        // await broadCastRawTransaction(transaction, walletNetwork);
        // result.addAll({'transaction': transaction});
      } else {
        debugPrint('ErrCode: ${response.statusCode} - err: ${response.body}');
        result.addAll({'error': json.decode(response.body).toString()});
        throw Exception('1Inch swap error');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('error call 1Inch swap');
      result.addAll({'error': e.toString()});
    }
    return result;
  }



  // Future<void> broadCastRawTransaction(String rawTransaction, WalletNetwork walletNetwork) async {
  //   http.Response response = await http.post(
  //     Uri.parse('https://api.1inch.dev/tx-gateway/v1.1/${walletNetwork.chainID}/broadcast'),
  //     headers: _headers,
  //     body: json.encode({'rawTransaction': rawTransaction}),
  //   );
  //   if (response.statusCode == 200) {
  //     debugPrint(response.body);
  //   } else {
  //     debugPrint('Broadcast Error: ${response.statusCode} - ${response.body}');
  //   }
  // }
}
