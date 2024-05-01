// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iparkmobileapplication/features/wallet/models/paymet_card_model.dart';
// import 'package:iparkmobileapplication/features/wallet/provider/cards_api.dart';
// import 'package:iparkmobileapplication/features/wallet/provider/payment_card_provider.dart';
// import 'package:iparkmobileapplication/features/vehicle/providers/api.dart';
// import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PaymentCardWidget extends StatefulWidget {
//   const PaymentCardWidget({super.key});

//   @override
//   State<PaymentCardWidget> createState() => _PaymentCardWidgetState();
// }

// class _PaymentCardWidgetState extends State<PaymentCardWidget> {
//   Future<List<PaymentCardModel>> wrapper() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     List<PaymentCardModel> cards =
//         await PaymentCardsApi.fetchPaymentCardsByUserId(
//             prefs.getString("userId")!);

//     return cards;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     wrapper();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<PaymentCardModel>>(
//         future: wrapper(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: MainColors.backgroundColor,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text("Error");
//           } else if (snapshot.data!.length == 0) {
//             return Text("Ypu do not have any saved cards");
//           } else {
//             print(snapshot.data);
//             return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     margin: EdgeInsets.all(10.w),
//                     child: ExpansionTile(
//                       shape:
//                           const RoundedRectangleBorder(side: BorderSide.none),
//                       backgroundColor: MainColors.backgroundColor,
//                       title: Text(snapshot.data![index].cardholderName),
//                       subtitle: Text(snapshot.data![index].cardholderName),
//                       children: [
//                         Container(
//                             padding: EdgeInsets.all(13.w),
//                             alignment: Alignment.topLeft,
//                             color: MainColors.backgroundColor,
//                             child: Text(
//                                 style: TextStyle(color: Colors.black),
//                                 "card number ending with:${snapshot.data![index].cardholderName.substring(1,4)}"))
//                       ],
//                       // child: Container(
//                       //   margin: EdgeInsets.all(10),
//                       //   decoration: BoxDecoration(
//                       //       border: Border.all(width: 0.1),
//                       //       borderRadius: BorderRadius.circular(12)),
//                       //   child: ListTile(
//                       //     leading: Text(DummyCards.cards[index].fullName),
//                       //     title: Text(DummyCards.cards[index].cardNumber.toString()),
//                       //   ),
//                       // ),
//                     ),
//                   );
//                 });
//           }
//         });
//   }
// }
