class LoginModel {
  bool? status;

  String? message;

  LoginUserData? data;

  LoginModel.fromJson(Map<String, dynamic> Json) {
    status = Json['status'];
    message = Json['message'];
    data = Json['data'] != null ? LoginUserData.fromJson(Json['data']) : null;
  }
}

class LoginUserData {
  int? id;

  String? name;

  String? email;

  String? phone;

  String? image;

  int? points;

  int? credit;

  String? token;

//   LoginUserData(
//   {
//     this.id ,
//     this.name ,
//     this.email ,
//     this.phone ,
//     this.image ,
//     this.points ,
//     this.credit ,
//     this.token ,
// }
//       );

  //Named Constructor

  LoginUserData.fromJson(Map<String, dynamic> Json) {
    id = Json['id'];
    name = Json['name'];
    email = Json['email'];
    phone = Json['phone'];
    image = Json['image'];
    token = Json['token'];
  }
}
