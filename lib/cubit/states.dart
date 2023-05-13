import 'package:shop_app/Models/HomeModel.dart';

import '../Models/LoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginonchangeState extends ShopLoginStates{}
class ShopLoginshowpasswordState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  final LoginModel loginModel ;
  ShopLoginSuccessState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates{
  final String error ;
  ShopLoginErrorState(this.error);

}

//Register States

class ShopRegisterLoadingState extends ShopLoginStates{}

class ShopRegisterSuccessState extends ShopLoginStates
{
  final LoginModel registerModel ;
  ShopRegisterSuccessState(this.registerModel);

}

class ShopRegisterErrorState extends ShopLoginStates{
  final String error ;
  ShopRegisterErrorState(this.error);

}





















//SQFLITE DataBASE

class createdatabaseState extends ShopLoginStates{}
class insertdatabaseState extends ShopLoginStates{}
class getdatabaseState extends ShopLoginStates{}