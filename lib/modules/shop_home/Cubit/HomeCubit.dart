import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/SearchModel.dart';
import 'package:shop_app/const.dart';

import '../../../Models/CategoryModel.dart';
import '../../../Models/ChangeFavoriteModel.dart';
import '../../../Models/FavoriteDataModel.dart';
import '../../../Models/HomeModel.dart';
import '../../../Models/LoginModel.dart';
import '../../../Network/endpoint.dart';
import '../../../Network/remote/Dio_Helper.dart';
import 'HomeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorite = {};

  void getDataFromHomeModel() {
    DioHelper.GetData(
      url: HOME,
    ).then((value) {
      emit(ShopHomeLoadingState());
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel);
      // print(homeModel!.status);
      // print(homeModel!.data!.products[1].image);

      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id!: element.inFavorites!});
      });
      // print(favorite.toString());
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      ShopHomeErrorState(error.toString());
      print(error.toString());
    });
  }

  CategoryModel? categoryModel;

  void getDataFromCategoryModel() {
    DioHelper.GetData(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel!.status);
    }).catchError((error) {
      emit(ShopCategoriesErrorState(error));
      print("Error Occured From CategoryCubit ${error.toString()}");
    });
  }

  ChangeFavoriteModel? changeFavorIteModel;

  void changeFavoriteItem(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ShopFavoriteChangeState());

    DioHelper.PostData(
        url: FAVORITE,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavorIteModel = ChangeFavoriteModel.fromJson(value.data);
      // print(value.data);

      if (!changeFavorIteModel!.status!) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavoriteData();
      }

      emit(ShopFavoriteSuccessState(changeFavorIteModel!));
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;
      emit(ShopFavoriteErrorState(error));
    });
  }

  FavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(ShopFavoriteLoadingState());
    DioHelper.GetData(url: FAVORITE, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      // print(favoriteModel!.data!.data[0].favoriteProductDataModel!.image);

      emit(ShopFavoriteModelSuccessState());
    }).catchError((error) {
      print("FavoriteModel Occured An Error : ${error.toString()}");
      emit(ShopFavoriteModelErrorState(error));
    });
  }

  LoginModel? profilemodel;

  void getProfileData() {
    emit(ShopProfileLoadingState());
    DioHelper.GetData(url: PROFILE, token: token).then((value) {
      profilemodel = LoginModel.fromJson(value.data);

      emit(ShopProfileSuccessState());
    }).catchError((error) {
      print("Error From Profile Model ${error.toString()}");
      // emit(ShopProfileErrorState() );
    });
  }

  void updateProfileData(
      {required String name, required String email, required String phone}) {
    emit(ShopProfileLoadingState());

    DioHelper.PutData(
        url: UPDATE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      profilemodel = LoginModel.fromJson(value.data);

      emit(ShopUpdateProfileSuccessState(profilemodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileErrorState());
    });
  }

  SearchModel? searchModel;

  void searchInProductData({required String text}) {
    emit(ShopSearchLoadingState());
    DioHelper.PostData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      // print(searchModel!.data!.data[0].name);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopSearchErrorState());
    });
  }
}
