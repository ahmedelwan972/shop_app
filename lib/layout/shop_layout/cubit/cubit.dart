import 'dart:math';

import 'package:ayop01/layout/shop_layout/cubit/states.dart';
import 'package:ayop01/models/shop_login_models/categories_models.dart';
import 'package:ayop01/models/shop_login_models/change_fav_models.dart';
import 'package:ayop01/models/shop_login_models/fav_models.dart';
import 'package:ayop01/models/shop_login_models/shop_data_models.dart';
import 'package:ayop01/models/shop_login_models/shop_user_models.dart';
import 'package:ayop01/modules/shop_app/favorites/favorites.dart';
import 'package:ayop01/modules/shop_app/shop_cateogries/cateogries.dart';
import 'package:ayop01/modules/shop_app/shop_products/products.dart';
import 'package:ayop01/modules/shop_app/shop_settings/settings.dart';
import 'package:ayop01/shared/components/constants.dart';
import 'package:ayop01/shared/network/end_point.dart';
import 'package:ayop01/shared/network/remote/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  changeBotNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorites = {};

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.in_favorites!,
        });
      });
     // print(favorites);
     // print(homeModel!.data!.products![1]);
      emit(ShopSuccessDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorDataState(e.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(categoriesModel!.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorCategoriesState(e.toString()));
    });
  }


ChangeFavModel? changeFavModel;

  void changeFav(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id' : productId,
      },
      token: token,
    ).then((value)
    {
      changeFavModel = ChangeFavModel.fromJson(value.data);
     // print(changeFavModel);

      if(!changeFavModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavState(changeFavModel!));
    }).catchError((e)
    {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavState(e));
    });
  }

  FavModels? favModels;

  void getFavorites()
  {
    emit(ShopLoadingFavState());

    DioHelper.getData(
        url: FAVORITES,
        token: token,
    ).then((value)
    {
      favModels = FavModels.fromJson(value.data);
      printFullText(favModels!.data!.data.toString());
      emit(ShopSuccessGetFavState());

    }).catchError((e)
    {
      print(e.toString());
      emit(ShopErrorGetFavState(e.toString()));
    });
  }

  ShopLoginModel? userData;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userData = ShopLoginModel.fromJson(value.data);
      print(userData!.data!.phone.toString());
      emit(ShopSuccessUserDataState());

    }).catchError((e)
    {
      print(e.toString());
      emit(ShopErrorUserDataState(e.toString()));
    });
  }

  void updateUserData
      (
      String name,
      String email,
      String phone,
      )
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name' : name,
        'email': email,
        'phone':phone,
      }
    ).then((value)
    {
      userData = ShopLoginModel.fromJson(value.data);
      print(userData!.data!.phone.toString());
      emit(ShopSuccessUpdateUserState());

    }).catchError((e)
    {
      print(e.toString());
      emit(ShopErrorUpdateUserState(e.toString()));
    });
  }

}
