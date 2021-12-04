import 'package:ayop01/models/shop_login_models/shop_user_models.dart';

abstract class ShopLoginStates{}

class ShopLoginInitState extends ShopLoginStates {}

class ShopLoginChangeVisiState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates
{
  ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
   String error;

   ShopLoginErrorState(this.error);
}
