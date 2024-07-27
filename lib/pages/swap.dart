import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swap/service/swapApi.dart';
import 'package:swap/provider/swapProvider.dart';
import 'package:swap/utils/utils.dart';

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
    Provider.of<SwapProvider>(context, listen: false).getCoinList();
  }

  Token? _selectedToken;
  Token? _selectedToken2;

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
    var cta = Provider.of<SwapProvider>(context);
// print("coinData.length ${coinData.length}");
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(image: AssetImage("assets/images/bg.png"),fit: BoxFit.fitHeight)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // spacer30Height,
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/matic.png",
                    scale: 1.5,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Polygon network",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: DropdownButton<Token>(
                          underline: Container(color: Colors.transparent),
                          hint: const Text('Select a Token'),
                          value: _selectedToken,
                          onChanged: (Token? newValue) {
                            setState(() {
                              _selectedToken = newValue;
                            });
                          },
                          items: cta.tokens
                              .map<DropdownMenuItem<Token>>((Token token) {
                            return DropdownMenuItem<Token>(
                              value: token,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.network(
                                      token.logoURI,
                                      width: 24,
                                      height: 24,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(
                                          Icons.error,
                                          color: redColor,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Text(token.symbol),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: fromTokenController,
                       decoration: const InputDecoration(
                                label: Text("Amount"),
                                hintText: 'Enter Amount',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: DropdownButton<Token>(
                          underline: Container(color: Colors.transparent),
                          hint: const Text('Select a Token'),
                          value: _selectedToken2,
                          onChanged: (Token? newValue) {
                            setState(() {
                              _selectedToken2 = newValue;
                            });
                          },
                          items: cta.tokens
                              .map<DropdownMenuItem<Token>>((Token token) {
                            return DropdownMenuItem<Token>(
                              value: token,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.network(
                                      token.logoURI,
                                      width: 24,
                                      height: 24,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(
                                          Icons.error,
                                          color: redColor,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Text(token.symbol),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                         decoration: const InputDecoration(
                                label: Text("Amount"),
                                hintText: 'Enter Amount',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                              ),
                      controller: toTokenController,
                      // decoration: const InputDecoration(labelText: 'To Token'),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //       icon: const Icon(Icons.swap_horiz),
              //       onPressed: reverseTokens,
              //       tooltip: 'Reverse Tokens',
              //     ),
              //   ],
              // ),
              // TextField(
              //   controller: amountController,
              //   decoration: InputDecoration(labelText: 'Amount'),
              //   keyboardType: TextInputType.number,
              // ),
              const SizedBox(height: 50),
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  swapApi.swap();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffFD4504),
                    // color: appColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Swap",
                      style: GoogleFonts.roboto(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        //: 'NunitoSans',
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
