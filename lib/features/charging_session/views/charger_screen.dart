import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/charging_session/models/chargingSession_model.dart';
import 'package:iparkmobileapplication/features/charging_session/providers/charging_session_api.dart';
import 'package:iparkmobileapplication/features/charging_session/providers/charger_provider.dart';
import 'package:iparkmobileapplication/features/payment_history/models/payment_model.dart';
import 'package:iparkmobileapplication/features/payment_history/providers/api_payments.dart';
import 'package:iparkmobileapplication/features/payment_history/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChargerScreen extends StatefulWidget {
  const ChargerScreen({super.key});

  static String nameRoute = "charger_screen";

  @override
  State<ChargerScreen> createState() => _ChargerScreenState();
}

class _ChargerScreenState extends State<ChargerScreen> {
  String? sessionID;
  ChargingSession? status;

  Timer? _timer;
  var connstarted;

  ChargingSession? connectionStarted;

  bool showPaymentButton = false;

  int statusofCharging = 0;

  bool payNow = false;

  bool chargingStarted = false;

  bool chargingDone = false;

  @override
  void initState() {
    super.initState();
    func();
  }

  func() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        print("wwhtfdfdf");
        final args = ModalRoute.of(context)!.settings.arguments as Map;
        sessionID = await ChargingSessionApi.createSession({
          "userId": prefs.getString("userId"),
          "chargerId": args["args"]["ID"],
          "stationName": args["args"]["stationName"]
        });

        print("dkfhddjsfhfdlkfhd fhvdnshfiodsfhndsifhgh");
        print(sessionID);

        connectionStarted = await ChargingSessionApi.simulateConnection(
            {"sessionId": sessionID});

        setState(() {
          connstarted = connectionStarted;
          statusofCharging = 1;
        });
        print(connectionStarted);
        print("fdfdfdfdfdfdfd");
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  void showPayButton() {
    setState(() {
      chargingDone = true;
    });
  }

  void timersHandlers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double currentMoney = double.parse(prefs.getString("money")!);
    ChargingSession statuss = await ChargingSessionApi.getSession(sessionID!);
    const interval = Duration(seconds: 1);
    _timer = Timer.periodic(interval, (Timer t) async {
      ChargingSession statuss = await ChargingSessionApi.getSession(sessionID!);
      setState(() {
        status = statuss;
      });

      if (statuss == true || status!.cost - 4 >= currentMoney) {
        _timer?.cancel();
        // Navigator.pushNamed()
        statusofCharging = 3;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        double currentMoney = double.parse(prefs.getString("money")!);
        prefs.setString("money", (currentMoney - status!.cost).toString());
        PaymentsApiManager.addPayment(PaymentModel(
            amount: status!.cost.toInt(),
            userId: prefs.getString("userId")!,
            stationName: status!.stationName,
            chargerId: int.parse(status!.chargerId)));
        Navigator.pushNamed(context, PaymentHistoryScreen.nameRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments as Map?;

    // final widget = Container(
    //   margin: EdgeInsets.only(top: 10),
    //   child: Image.asset(
    //     "assets/images/checked.png",

    //     width: MediaQuery.of(context).size.width * 0.5,
    //     height: MediaQuery.of(context).size.width * 0.1,
    //   ),
    // );

    Size mediaQuery = MediaQuery.of(context).size;

    // StripeHandlers stripeHandlers = StripeHandlers();

    return Scaffold(
      backgroundColor: MainColors.backgroundColor,
      appBar: ApplicationBar.appbar(
        args["args"]["ID"],
        const Icon(Icons.arrow_back_ios_new),
        () => Navigator.pop(context),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<ChargerProvider>(builder: (context, provider, child) {
              return Container(
                  width: mediaQuery.width * 0.8,
                  child: connstarted == null
                      ? const Text(
                          "The Charger is still not connected to the vehichlle, Please connect it !",
                          style: TextStyle(color: Colors.red),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Charger now is connected, please start \ncharging when you ready.",
                              style: TextStyle(
                                  color: MainColors.mainLightThemeColor),
                            )
                          ],
                        ));
            }),
            Container(
              margin: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.1),
              height: mediaQuery.height * 0.2,
              width: mediaQuery.width * 0.5,
              // alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/images/electricity-svgrepo-com.svg",
                colorFilter: ColorFilter.mode(
                    MainColors.mainLightThemeColor, BlendMode.srcIn),
              ),
            ),
            Container(
              padding: EdgeInsets.all(mediaQuery.width * 0.04),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              height: mediaQuery.height * 0.21,
              width: mediaQuery.width * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Energy",
                            style: testStyleHandler(context, mediaQuery),
                          ),
                          status == null
                              ? Text("0 watt",
                                  style: TextStyle(
                                      color: MainColors.mainLightThemeColor))
                              : Text(" ${status!.powerWat} watt",
                                  style: TextStyle(
                                      color: MainColors.mainLightThemeColor))
                        ]),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 0.6,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time",
                            style: testStyleHandler(context, mediaQuery),
                          ),
                          status == null
                              ? Text("0 sec",
                                  style: TextStyle(
                                      color: MainColors.mainLightThemeColor))
                              : Text(
                                  " ${status!.duration.toString().substring(0, 1)} sec",
                                  style: TextStyle(
                                      color: MainColors.mainLightThemeColor))
                        ]),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 0.6,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: testStyleHandler(context, mediaQuery),
                          ),
                          status == null
                              ? Text("0 EUR",
                                  style: TextStyle(
                                      color: MainColors.mainLightThemeColor))
                              : Text(
                                  " ${(status!.cost).toString().substring(0, 5)} EUR",
                                  style: TextStyle(
                                      color: MainColors.mainLightThemeColor))
                        ]),
                  ],
                ),
              ),
            ),
            Container(
                // color: black,
                width: mediaQuery.width * 0.6,
                alignment: Alignment.center,
                child: Consumer<ChargerProvider>(
                  builder: (context, value, child) {
                    if (statusofCharging == 1) {
                      return ElevatedButton(
                          onPressed: () async {
                            print(sessionID);
                            print("fdfkndfdf");
                            dynamic returnedSessionId =
                                await ChargingSessionApi.startChargingSession(
                                    {"sessionId": sessionID});
                            setState(() {
                              statusofCharging = 2;
                            });
                            if (returnedSessionId == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Charging started successfully with session ID: $returnedSessionId"),
                              ));
                            } else {
                              timersHandlers();
                              setState(() {
                                chargingDone = false;
                                statusofCharging = 2;
                              });
                            }
                          },
                          child: const Text(
                            "Start Charging",
                            style: TextStyle(color: Colors.white),
                          ));
                    } else if (statusofCharging == 2) {
                      return Container(
                          width: mediaQuery.width * 0.6,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            child: const Text(
                              "Stop Charging",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              dynamic returnedMessage =
                                  await ChargingSessionApi.stopChargingSession(
                                      {"sessionId": sessionID});

                              if (returnedMessage == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: const Text(
                                      "Charging did not stop for some technical problems "),
                                ));
                              } else {
                                setState(() {
                                  statusofCharging = 3;
                                  _timer?.cancel();

                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0)), // Rounded corners
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Done!',
                                                  style: TextStyle(
                                                      color: MainColors
                                                          .mainLightThemeColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              // SizedBox(height: 20),
                                              const Text(
                                                  'Charging session is done successfuly and the payment is deducted',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  double currentMoney =
                                                      double.parse(prefs
                                                          .getString("money")!);
                                                  prefs.setString(
                                                      "money",
                                                      (currentMoney -
                                                              status!.cost)
                                                          .toString());
                                                  PaymentsApiManager.addPayment(
                                                      PaymentModel(
                                                          amount: status!.cost
                                                              .toInt(),
                                                          userId:
                                                              prefs.getString(
                                                                  "userId")!,
                                                          stationName: status!
                                                              .stationName,
                                                          chargerId: int.parse(
                                                              status!
                                                                  .chargerId)));
                                                  Navigator.pushNamed(
                                                      context,
                                                      PaymentHistoryScreen
                                                          .nameRoute);
                                                },
                                                child: const Text(
                                                  'Close',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                              }
                            },
                          ));
                    } else if (statusofCharging == 3) {
                      return Container(
                          width: mediaQuery.width * 0.6,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () => null,
                              child: const Text(
                                "charging stopped",
                                style: TextStyle(color: Colors.white),
                              )));
                    } else {
                      return const Text("");
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}

TextStyle testStyleHandler(BuildContext context, Size mediaQuery) {
  TextStyle textStyle = TextStyle(
      fontSize: mediaQuery.width * 0.05, color: MainColors.mainLightThemeColor);

  return textStyle;
}
