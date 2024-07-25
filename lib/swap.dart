import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:swap/swapApi.dart';
import 'package:swap/swapProvider.dart';

class SwapScreen extends StatefulWidget {
  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final TextEditingController fromTokenController = TextEditingController();
  final TextEditingController toTokenController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void reverseTokens() {
    final fromToken = fromTokenController.text;
    final toToken = toTokenController.text;
    fromTokenController.text = toToken;
    toTokenController.text = fromToken;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SwapProvider>(context,listen: false).getCoinList();
  }

  var titleValue;

  final SwapApi swapApi = SwapApi();

  List titleList = [
    ["AS", "ASSAM"],
    ["BR", "BIHAR & JHARKHAND"],
    ["KO", "KOLKATA"],
    ["OR", "ODISHA"],
    ["NE", "NORTH EAST"],
    ["WB", "WEST BENGAL"],
    ["MH", "MAHARASHTRA & GOA"],
    ["MP", "MP & CHHATTISGARH"],
    ["MU", "MUMBAI"],
    ["GJ", "GUJARAT"],
    ["PB", "PUNJAB"],
    ["RJ", "RAJASTHAN"],
    ["UE", "UP (EAST)"],
    ["UW", "UP (WEST) & UTTARAKHAND"],
    ["HR", "HARYANA"],
    ["JK", "JAMMU & KASHMIR"],
    ["DL", "DELHI - NCR"],
    ["AP", "AP & TELANGANA"],
    ["CH", "CHENNAI"],
    ["KL", "KERALA"],
    ["KA", "KARNATAKA"],
    ["TN", "TAMIL NADU"],
  ];
  @override
  Widget build(BuildContext context) {
var coinData= Provider.of<SwapProvider>(context).coinList;
print("coinData.length ${coinData.length}");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton(
                  style: GoogleFonts.inter(
                      // color: theme.darkTheme ? white : black
                      ),
                  underline: Container(color: Colors.transparent),
                  value: titleValue,
                  icon: const Icon(Icons.keyboard_arrow_down, color: black),
                  items: titleList.map((items) {
                    return DropdownMenuItem(
                      value: items[0],
                      child: Text(
                        items[1],
                        style: GoogleFonts.inter(
                            color:
                                // theme.darkTheme
                                //     ? white
                                //     :
                                black),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      titleValue = newValue;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: fromTokenController,
                    decoration: const InputDecoration(labelText: 'From Token'),
                  ),
                ),
              ],
            ),
            TextField(
              controller: toTokenController,
              decoration: const InputDecoration(labelText: 'To Token'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // final quote = await _fusionSDK.getQuote(fromTokenAddress: "0x111111111117dc0aa78b770fa6a738034120c302", toTokenAddress: "0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3", amount: "100000000000000000");

                // final fromToken = fromTokenController.text;
                // final toToken = toTokenController.text;
                // final amount = double.parse(amountController.text);
                swapApi.swap();

                print(
                    "fromTokenController.text ${fromTokenController.text} toTokenController.text ${toTokenController.text} ");
                // context.read<SwapBloc>().add(SwapRequested(
                //   fromToken: fromToken,
                //   toToken: toToken,
                //   amount: amount,
                // ));
              },
              child: const Text('Swap'),
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
