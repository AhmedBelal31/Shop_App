import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/Network/remote/Dio_Helper.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/HomeModel.dart';
import '../Models/HomeModel.dart';
import '../Models/LoginModel.dart';
import '../Network/endpoint.dart';
import '../const.dart';
import '../style/color.dart';
import '../style/constant.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{

  ShopLoginCubit() : super (ShopLoginInitialState()) ;

  static ShopLoginCubit get(context) => BlocProvider.of(context) ;

  bool isPassword =true ;
  IconData Suffix =Icons.visibility ;
  void showpassword ()
  {
    isPassword = !isPassword ;
    Suffix = isPassword ? Icons.visibility : Icons.visibility_off ;
    emit(ShopLoginshowpasswordState ());
  }

  //UserModel

// void userModel(
//   {
//    required String email ,
//    required String password,
//   }
//     )
//     {
//       DioHelper.PostData(
//           url: LOGIN ,
//           data: {
//             'email' :email  ,
//             'password' : password,
//           }
//       ).then((value) {
//         print(value.data);
//         emit(ShopLoginSuccessState());
//       }).catchError((error){
//         print("Error Occured !${error.toString()}");
//         emit(ShopLoginErrorState(error.toString()));
//       });
//     }



//Final UserModel


void userModel ({required String email , required String password })
{
  LoginModel LoginModelObj;
  DioHelper.PostData(
      url:LOGIN ,
      data: {
        "email" : email ,
        "password" : password
      }
  ).then((value) {
   LoginModelObj = LoginModel.fromJson(value.data);
   // print("Message From My Model ${ LoginModelObj!.message}");
   //  print(value.data);

    emit(ShopLoginSuccessState(LoginModelObj!));


  }).catchError((error){
    print("Error Occured !${error.toString()}");
    emit(ShopLoginErrorState(error.toString()));

  });
}

LoginModel? registerModel ;
void registerUser(
  {
    required String name ,
    required String email ,
    required String password ,
    required String phone ,
}
    )
{
  emit(ShopRegisterLoadingState());
  DioHelper.PostData(
      url: REGISTER,
      data: {
      'name' : name ,
      'email' :email  ,
      'password' : password ,
      'phone' :phone  ,
      }
  ).then((value) {
    registerModel = LoginModel.fromJson(value.data);
    emit(ShopRegisterSuccessState(registerModel!));
    
  }).catchError((error){
    print("Error From Register ${error.toString()}");
    emit(ShopRegisterErrorState(error));

  });
}



























  //Create Database
 // Database? database ;
 //  void createDatabase() async
 //  {
 //   database = await openDatabase(
 //      'database ' ,
 //      version:  1 ,
 //       onCreate:(database , version)
 //        {
 //          database.execute('CREATE TABLE shop (id INTEGER PRIMARY KEY , username TEXT , email TEXT ,password TEXT ,phone TEXT )').then(
 //                  (value) {
 //                   print("DataBase CREATED");
 //                  }).catchError((error){
 //                    print("Error Occured! ${error}");
 //          });
 //        },
 //        onOpen: (database)
 //    {
 //
 //      getDatabase(database);
 //      print("Database Onpened");
 //    }
 //    )  ;
 //
 //  }
  // insertIntoDataBase(
  //     {required String username,
  //     required String email,
  //     required String password,
  //     required String phone}) async
  // {
  //   return await database!.transaction((txn) async{
  //     await txn.rawInsert('INSERT INTO shop(username ,email ,password , phone ) Values("$username","$email","$password" , "$phone")').then((value){
  //       print("${value} Row Inserted Successfuly ");
  //       emit(insertdatabaseState());
  //       getDatabase(database);
  //       print(email);
  //     }).catchError((error){
  //       print("Error Happened ${error.toString()}");
  //     });
  //
  //   });
  // }

// List<dynamic> email =[];
// List<dynamic> password =[];
 // getDatabase (database)
 //  {
 //    emit(getdatabaseState());
 //     database!.rawQuery('SELECT * FROM shop ').then( (value)
 //         {
 //           value.forEach((element) {
 //
 //             email.add(element['email']);
 //             password.add(element['password']);
 //
 //          });
 //           print(email);
 //           print(password);
 //           emit(getdatabaseState());
 //         }
 //
 //     );
 //
 //    emit(getdatabaseState());
 //  }


}