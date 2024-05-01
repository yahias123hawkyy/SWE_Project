import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/wallet/models/paymet_card_model.dart';
import 'package:iparkmobileapplication/features/wallet/provider/cards_api.dart';
import 'package:iparkmobileapplication/features/wallet/provider/payment_card_provider.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentCardsScreen extends StatefulWidget {
  const PaymentCardsScreen({super.key});

  static const nameRoute = "payment_cards_screen";

  @override
  State<PaymentCardsScreen> createState() => _PaymentCardsScreenState();
}

class _PaymentCardsScreenState extends State<PaymentCardsScreen> {
  @override
  void initState() {
    super.initState();

    wrapper();
    wrapper2();
  }

    double? money;


  void _showBottomSheet(BuildContext context) async {
    final formKey = GlobalKey<FormState>();

  
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = '';
    int ccv = 0;
    int cardNUmber = 0;
    String expiryDate = "";

   

    showModalBottomSheet(
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 100,
      context: context,
      builder: (BuildContext context) {
        return Consumer<PaymentCardsProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Container(
                height: 550.h,
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Fill out the form',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: MainColors.mainLightThemeColor),
                      ),
                      const SizedBox(height: 16.0),
                      // Your form fields go here
                      TextFormField(
                          decoration: const InputDecoration(labelText: 'Name'),
                          onChanged: (value) => name = value),
                      TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Card Number'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => cardNUmber = int.parse(value)),
                      TextFormField(
                          decoration: const InputDecoration(labelText: 'CCV'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => ccv = int.parse(value)),
                      TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Expiry Date'),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) => expiryDate = value),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Close the bottom sheet
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState != null &&
                                  formKey.currentState!.validate()) {
                                setState(() {
                                  PaymentCardsApi.addPaymentCard(
                                      cardNumber: cardNUmber.toString(),
                                      expirationDate: expiryDate,
                                      cardholderName: name,
                                      cvv: ccv.toString(),
                                      userId: prefs.getString("userId")!);
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  String? _selectedCard;

     List<PaymentCardModel>? cards;

    final TextEditingController _amountController = TextEditingController();

 void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Card and Deduct Money'),
            content: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _selectedCard,
                    // hint: const Text("Select a card"),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCard = newValue;
                      });
                    },
                    items: cards!.map<DropdownMenuItem<String>>((PaymentCardModel value) {
                      return DropdownMenuItem<String>(
                        value: value.cardholderName,
                        child: Text(value.cardholderName),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount to Deduct',
                      hintText: 'Enter amount',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              );}
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Deduct'),
                onPressed: () async{
                  // Here you would typically handle the deduction logic
                  print(
                      'Selected Card: $_selectedCard, Amount: ${_amountController.text}');
                  Navigator.of(context).pop();
                  SharedPreferences prefs =await  SharedPreferences.getInstance();

                    setState(() {
                      money = money! + int.parse(_amountController.text);
                    });
                     prefs.setString("money",money.toString());

                },
              ),
            ],
          );
        },
      );
    }
 
 
 
 
 
 
 
  Future<List<PaymentCardModel>> wrapper() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<PaymentCardModel> cards =
        await PaymentCardsApi.fetchPaymentCardsByUserId(
            prefs.getString("userId")!);
    return cards;
  }

  wrapper2()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();   
     double moneyInterior =  double.parse(prefs.getString("money")?? "0");
  setState(() {
    money = moneyInterior;
    
  });
  }

  @override
  Widget build(BuildContext context) {

    // SharedPreferences prefs =await  SharedPreferences.getInstance();

    // int money = prefs.getString("money");

    return Scaffold(
      appBar: ApplicationBar.appbar(
          "",
          const Icon(Icons.arrow_back_ios_new_outlined),
          () => Navigator.pop(context)),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: const Color(0xff9F69B2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Balance", style: commonTextStyleforwallettext),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(

                            
                            money ==null? "0 EUR" : money.toString().substring(0,3)+" EUR",
                            style: commonTextStyleforwallettext,
                          )),
                      GestureDetector(
                          onTap: () => null,
                          child: TextButton(
                              onPressed: () {
                                _showDialog();
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    "Add balance",
                                    style: commonTextStyleforwallettext,
                                  ),
                                ],
                              )))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your cards :",
                    style: TextStyle(
                        color: MainColors.mainLightThemeColor, fontSize: 16),
                  ),
                  GestureDetector(
                      onTap: () => null,
                      child: TextButton(
                          onPressed: () => _showBottomSheet(context),
                          child: Row(
                            children: [
                              Icon(Icons.add,
                                  size: 16,
                                  color: MainColors.mainLightThemeColor),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                "Add a new card",
                                style: TextStyle(
                                    color: MainColors.mainLightThemeColor,
                                    fontSize: 16),
                              ),
                            ],
                          )))
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<List<PaymentCardModel>>(
                    future: wrapper(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MainColors.backgroundColor,
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Text("Error");
                      } else if (snapshot.data!.length == 0) {
                        return const Text("Ypu do not have any saved cards");
                      } else {
                        print(snapshot.data);

                          cards = snapshot.data!;
                      
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: EdgeInsets.all(10.w),
                                child: ExpansionTile(
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide.none),
                                  backgroundColor: MainColors.backgroundColor,
                                  title: Text(
                                      snapshot.data![index].cardholderName),
                                  subtitle: Text(
                                      snapshot.data![index].expirationDate),
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(13.w),
                                        alignment: Alignment.topLeft,
                                        color: MainColors.backgroundColor,
                                        child: Text(
                                            style:
                                                const TextStyle(color: Colors.black),
                                            "card number statrting with:${snapshot.data![index].cardNumber.substring(0,3)}"))
                                  ],
                                  // child: Container(
                                  //   margin: EdgeInsets.all(10),
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(width: 0.1),
                                  //       borderRadius: BorderRadius.circular(12)),
                                  //   child: ListTile(
                                  //     leading: Text(DummyCards.cards[index].fullName),
                                  //     title: Text(DummyCards.cards[index].cardNumber.toString()),
                                  //   ),
                                  // ),
                                ),
                              );
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }

  // Future<List<PaymentCardModel>> wrapper() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  List<PaymentCardModel>cards = await PaymentCardsApi.fetchPaymentCardsByUserId(prefs.getString("userId")!);

  //   return cards;

  // }
}

TextStyle commonTextStyleforwallettext =
    const TextStyle(color: Colors.white, fontSize: 16);

TextStyle commonTextstyleforotherelemnets =
    TextStyle(color: MainColors.mainLightThemeColor, fontSize: 16);
