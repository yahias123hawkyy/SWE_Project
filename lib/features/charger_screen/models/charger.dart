class Charger{
  int id ;
  int  energy;
  int battery;
  DateTime time;
  double costpertime;

  Charger(
    {required this.id,required this.energy,required this.battery,required this.costpertime,required this.time}
  );
}


class Dummychargerinfo{

  static List dummychargerinfo =[

    Charger(id:1,energy: 16, battery: 40 , costpertime: 10 , time: DateTime.now()),
    Charger(id:2,energy: 20, battery: 32 , costpertime: 10 , time: DateTime.now()),
    Charger(id:3, energy:32, battery: 18 , costpertime: 10 , time: DateTime.now()),
    // Charger(energy: 16, battery: 60 , costpertime: 10 , time: DateTime.now())

  ];
}


