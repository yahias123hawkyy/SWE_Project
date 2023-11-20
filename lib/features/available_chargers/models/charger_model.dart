

class ChargerModel{


 final int id;
 final bool available;
 final String chargerName;
 final int costPerUnit;

 ChargerModel({required this.id,required this.available,required this.chargerName,required this.costPerUnit});


//  factory ChargerModel.fromJson(Map<String, dynamic> json) {
//     return ChargerModel(
//       available: json['available'] ?? false,
//       chargerName: json['chargerName'] ?? '',
//       costPerUnit: json['costPerUnit'] ?? 0,
//     );


    
}

class DummyCharger {


 static List  dummyChargers=[
 ChargerModel(id: 1,available: false,chargerName: "Charger 1", costPerUnit: 23),
 ChargerModel(id: 2,available: false,chargerName: "Charger 2", costPerUnit: 23),
 ChargerModel(id: 3,available: false,chargerName: "Charger 3", costPerUnit: 23),
 ChargerModel(id: 4,available: false,chargerName: "Charger 4", costPerUnit: 23),
];



}
 