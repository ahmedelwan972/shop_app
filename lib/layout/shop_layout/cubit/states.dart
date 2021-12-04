import 'package:ayop01/models/shop_login_models/change_fav_models.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingDataState extends ShopStates {}

class ShopSuccessDataState extends ShopStates {}

class ShopErrorDataState extends ShopStates {
  String e;
  ShopErrorDataState(this.e);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  String e;
  ShopErrorCategoriesState(this.e);
}

class ShopChangeFavState extends ShopStates {}

class ShopSuccessChangeFavState extends ShopStates {
  ChangeFavModel model;
  ShopSuccessChangeFavState(this.model);
}

class ShopErrorChangeFavState extends ShopStates {
  String e;
  ShopErrorChangeFavState(this.e);
}


class ShopLoadingFavState extends ShopStates {}

class ShopSuccessGetFavState extends ShopStates {}

class ShopErrorGetFavState extends ShopStates {
  String e;
  ShopErrorGetFavState(this.e);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  String e;
  ShopErrorUserDataState(this.e);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  String e;
  ShopErrorUpdateUserState(this.e);
}