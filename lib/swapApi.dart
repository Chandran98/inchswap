import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class SwapApi {
  static const chainId = 56; // Chain ID for Binance Smart Chain (BSC)
  static const web3RpcUrl =
      "https://bsc-dataseed.binance.org"; // URL for BSC node

  // final String _endPoint = 'https://api.1inch.io/v4.0/';

  final String _endPoint = 'https://api.1inch.dev/swap/v6.0/';

  final Map<String, String> _headers = {
    "Authorization": "Bearer 2EQIam7nYCvCeAUIDYKD7G8qELgkmngn",
    "accept": "application/json"
  };

  Future<Map<String, dynamic>> swap(
      // {
      // required appUser,
      // required fromWallet,
      // required walletNetwork,
      // required startToken,
      // required endToken,
      // required double quantity,
      // }
      ) async {
    Map<String, dynamic> result = {};
    final queryParameters = {
      'src': "0x111111111117dc0aa78b770fa6a738034120c302",
      'dst': "0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3",
      'amount': "100000000000000000",
      'from': "0xBa7E6a23a824B958592dcdaFD54400fEFA19e5D4",
      'slippage': '1',
      'includeTokensInfo': 'true',
      'disableEstimate': 'true',
    };

    Uri uri = Uri.parse('$_endPoint${chainId}/swap')
        .replace(queryParameters: queryParameters);

    try {
      print(queryParameters);
      http.Response response = await http.get(uri, headers: _headers);

      print("response123${response.statusCode}");

      print("response.body${response.body}");
      if (response.statusCode == 200) {
        dynamic jsonTx = json.decode(response.body)['tx'];
        print("jsonTx $jsonTx");
        // String transaction = await signAndSendTransaction(
        //   appUser: appUser,
        //   senderLocalWallet: fromWallet,
        transaction:
        Transaction(
          from: EthereumAddress.fromHex(jsonTx['from']),
          to: EthereumAddress.fromHex(jsonTx['to']),
          value: EtherAmount.fromUnitAndValue(
              EtherUnit.wei, int.parse(jsonTx['value'])),
          data: Uint8List.fromList(utf8.encode(jsonTx['data'])),
          gasPrice: EtherAmount.fromUnitAndValue(
              EtherUnit.wei, int.parse(jsonTx['gasPrice'])),
          maxGas: 100000,
        );
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

  // Future<String> signAndSendTransaction({
  //   required AppUser appUser,
  //   required LocalWallet senderLocalWallet,
  //   required Transaction transaction,
  // }) async {
  //   WalletNetwork network = getWalletNetworkFromName(appUser, senderLocalWallet.network);
  //   Web3Client web3client = Web3Client('${network.rpc}$ankr', Client());
  //   EthPrivateKey credentials = EthPrivateKey.fromHex(senderLocalWallet.privateKey);

  //   String response;
  //   try {
  //     response = await web3client.sendTransaction(credentials, transaction, chainId: network.chainID);
  //   } catch (e) {
  //     response = e.toString();
  //   }

  //   web3client.dispose();
  //   debugPrint('SignAndSendTransactionResponse: $response');
  //   return response;
  // }

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
