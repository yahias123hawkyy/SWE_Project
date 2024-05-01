import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/vehicle/models/vehichle.dart';
import 'package:iparkmobileapplication/features/vehicle/providers/api.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehichleCard extends StatefulWidget {
  const VehichleCard({super.key});


  @override
  State<VehichleCard> createState() => _VehichleCardState();
}

class _VehichleCardState extends State<VehichleCard> {
  Future<List<VehichleModel>> wrapper() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<VehichleModel> cars =
        await CarsApi.fetchCarsByUserId("6602dd93d1d70c9e9ed5c3d8");

    return cars;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wrapper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: wrapper(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MainColors.backgroundColor,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Error");
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.all(10.w),
                    child: ExpansionTile(
                      shape:
                          const RoundedRectangleBorder(side: BorderSide.none),
                      backgroundColor: MainColors.backgroundColor,
                      title: Text(snapshot.data![index]!.carType),
                      subtitle: Text(snapshot.data![index]!.model),
                      children: [
                        Container(
                            padding: EdgeInsets.all(13.w),
                            alignment: Alignment.topLeft,
                            color: MainColors.backgroundColor,
                            child: Text(
                              snapshot.data![index]!.year.toString(),
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  );
                });
          }
        });
  }
}
