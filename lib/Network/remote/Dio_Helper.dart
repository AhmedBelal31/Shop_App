import 'package:dio/dio.dart';
import 'package:shop_app/const.dart';

class DioHelper
{
  static Dio? dio ;
  static init()
  {
    dio = Dio(
     BaseOptions(
       baseUrl: 'https://student.valuxapps.com/api/' ,
       receiveDataWhenStatusError: true ,
       // headers: {
       //   "Content-Type" : "application/json" ,
       //   "lang" : "en" ,
       //   "Authorization" : token,
       // }
     )
    );
  }

  static Future<Response> GetData(
      {
        required String url ,
         Map<String , dynamic>? query ,
        String? token
      }
      ) async

  {
    dio!.options.headers =
    {
      "Content-Type" : "application/json" ,
      "lang" : "en" ,
      "Authorization" : token??'',

    };
  return await  dio!.get(url , queryParameters:query  ) ;
  }

  static Future<Response> PostData(
  {
    required String url ,
    Map<String,dynamic>? query ,
    required Map<String ,dynamic> data ,
    String? token
}
      ) async

  {
    dio!.options.headers =
      {
        "Content-Type" : "application/json" ,
        "lang" : "en" ,
        "Authorization" : token??'',

    };
   return await dio!.post(url , queryParameters: query , data: data);
  }

  static Future<Response> PutData(
      {
        required String url ,
        Map<String,dynamic>? query ,
        required Map<String ,dynamic> data ,
        String? token
      }
      ) async

  {
    dio!.options.headers =
    {
      "Content-Type" : "application/json" ,
      "lang" : "en" ,
      "Authorization" : token??'',

    };
    return await dio!.put(url , queryParameters: query , data: data);
  }



}
