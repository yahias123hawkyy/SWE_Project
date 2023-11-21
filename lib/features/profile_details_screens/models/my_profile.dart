class MyProfile{


  final String firstName;
  final int userID;
  final String lastName;
  final String email;
  final String userName;

  MyProfile({
    required this.email,required this.firstName,required this.lastName,required this.userID, required this.userName 
  });
}


abstract class DummyMYprofile{

  static List list =[
    MyProfile(email: "yahiashawky@gmail.com",firstName: "Yahia",lastName: "Ahmed",userID: 1,userName: "yahiaahmed"),
    MyProfile(email: "yahia@gmail.com",firstName: "Yahia",lastName: "Ahmed",userID: 2,userName: "yahiaahmed"),
    MyProfile(email: "yahia@gmail.com",firstName: "Yahia",lastName: "Ahmed",userID: 3,userName: "yahiaahmed"),
    MyProfile(email: "ymoab@gmail.com",firstName: "Yahia",lastName: "Ahmed",userID: 4,userName: "yahiaahmed"),
  ] ;
}