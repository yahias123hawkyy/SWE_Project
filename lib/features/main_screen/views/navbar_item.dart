import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/features/available_chargers/views/available_charger.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/notifications_page.dart';

class BottomNavBarItem extends StatelessWidget {
 

  
  @override
  Widget build(BuildContext context) {

    final double page_size = MediaQuery.of(context).size.height;

    return Expanded(
      child: BottomNavigationBar(
        onTap: (value)=> shiftpage(value,context) ,
        selectedItemColor: Theme.of(context).primaryColor,items:  <BottomNavigationBarItem>[
        navBarItem("", Icon(size:page_size * 0.04,Icons.home)),
        navBarItem("", Icon(size:page_size * 0.04,Icons.calendar_today_sharp)),
        navBarItem("", Icon(size:page_size * 0.04,Icons.qr_code)),
        navBarItem("", Icon(size:page_size * 0.04,Icons.local_gas_station))
      , navBarItem("", Icon(size:page_size * 0.04,Icons.person))
      ],type:BottomNavigationBarType.fixed,),
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
          Navigator.pushNamed(context,NotificationScreen.routeName);
        }  
        if (value == 2){
          Navigator.pushNamed(context,MainScreenView.routeName);
        } 
        if (value == 3){
          Navigator.pushNamed(context,AvailableChargers.routeName);
        } 

}