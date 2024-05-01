import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/features/station/views/available_chargers.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/user_area/views/user_area_screen.dart';
import 'package:iparkmobileapplication/features/qr_scanner/qr_scanner_view.dart';
import 'package:iparkmobileapplication/features/wallet/views/wallet_screen.dart';

class BottomNavBar extends StatelessWidget {
 

  
  @override
  Widget build(BuildContext context) {

    final double pageSize = MediaQuery.of(context).size.height;

    return Expanded(
      child: BottomNavigationBar(
        onTap: (value) => shiftpage(value, context),
        selectedItemColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          navBarItem("Search", Icon(size: pageSize * 0.04, Icons.home)),
          navBarItem("Wallet",
              Icon(size: pageSize * 0.04, Icons.calendar_today_sharp)),
          navBarItem("QR", Icon(size: pageSize * 0.04, Icons.qr_code)),
          navBarItem(
              "Stations", Icon(size: pageSize * 0.04, Icons.local_gas_station)),
          navBarItem("Account", Icon(size: pageSize * 0.04, Icons.person))
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );

  }
}
BottomNavigationBarItem navBarItem(String label, Icon icon) {
  return BottomNavigationBarItem(label: label, icon: icon,  );
}



 shiftpage (value,BuildContext context)
{

        if (value == 0){
          Navigator.pushNamed(context,MainScreenView.routeName);
        } 
        if (value == 1){
          Navigator.pushNamed(context,PaymentCardsScreen.nameRoute);
        }  
        if (value == 2){
          Navigator.pushNamed(context,QRCodeScannerScreen.nameRoute);
        } 
        // if (value == 3){
        //   Navigator.pushNamed(context,AvailableChargers.routeName);
        // } 
        if (value == 4){
          Navigator.pushNamed(context,ProfileScreen.nameRoute);
        } 

}