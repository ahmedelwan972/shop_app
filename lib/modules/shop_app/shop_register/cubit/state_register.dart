import 'package:ayop01/models/shop_login_models/shop_user_models.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitState extends ShopRegisterStates {}

class ShopRegisterChangeVisiState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
   String error;

   ShopRegisterErrorState(this.error);
}
