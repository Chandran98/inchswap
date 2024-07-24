import 'package:flutter/material.dart';
import 'package:fusion_swap_sdk/fusion_swap_sdk.dart';
import 'package:swap/swapApi.dart';

class SwapScreen extends StatefulWidget {
  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final TextEditingController fromTokenController = TextEditingController();
  final TextEditingController toTokenController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
final _fusionSDK = FusionSDK(chainId: 56, authKey: '2EQIam7nYCvCeAUIDYKD7G8qELgkmngn');

  void reverseTokens() {
    final fromToken = fromTokenController.text;
    final toToken = toTokenController.text;
    fromTokenController.text = toToken;
    toTokenController.text = fromToken;
  }
final SwapApi swapApi=SwapApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swap Tokens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: fromTokenController,
              decoration: InputDecoration(labelText: 'From Token'),
            ),
            TextField(
              controller: toTokenController,
              decoration: InputDecoration(labelText: 'To Token'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: reverseTokens,
                  tooltip: 'Reverse Tokens',
                ),
              ],
            ),
            // TextField(
            //   controller: amountController,
            //   decoration: InputDecoration(labelText: 'Amount'),
            //   keyboardType: TextInputType.number,
            // ),
            SizedBox(height: 20),
            ElevatedButton(
                  onPressed: () async{
                    // final quote = await _fusionSDK.getQuote(fromTokenAddress: "0x111111111117dc0aa78b770fa6a738034120c302", toTokenAddress: "0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3", amount: "100000000000000000");

                    // final fromToken = fromTokenController.text;
                    // final toToken = toTokenController.text;
                    // final amount = double.parse(amountController.text);
                    swapApi.swap();

                    print("fromTokenController.text ${fromTokenController.text} toTokenController.text ${toTokenController.text} ");
                    // context.read<SwapBloc>().add(SwapRequested(
                    //   fromToken: fromToken,
                    //   toToken: toToken,
                    //   amount: amount,
                    // ));
                  },
                  child: Text('Swap'),
            )
              
            // BlocConsumer<SwapBloc, SwapState>(
            //   listener: (context, state) {
            //     if (state is SwapSuccess) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Swap successful: ${state.transactionHash}')),
            //       );
            //     } else if (state is SwapFailure) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Swap failed: ${state.error}')),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is SwapLoading) {
            //       return CircularProgressIndicator();
            //     }

            //     return ElevatedButton(
            //       onPressed: () {
            //         final fromToken = fromTokenController.text;
            //         final toToken = toTokenController.text;
            //         final amount = double.parse(amountController.text);
            //         context.read<SwapBloc>().add(SwapRequested(
            //           fromToken: fromToken,
            //           toToken: toToken,
            //           amount: amount,
            //         ));
            //       },
            //       child: Text('Swap'),
            //     );
            //   },
            // ),
     
          ],
        ),
      ),
    );
  }
}
