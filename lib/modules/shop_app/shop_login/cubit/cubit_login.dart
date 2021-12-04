import 'package:ayop01/models/shop_login_models/shop_user_models.dart';
import 'package:ayop01/modules/shop_app/shop_login/cubit/state_login.dart';
import 'package:ayop01/shared/network/end_point.dart';
import 'package:ayop01/shared/network/remote/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{


  ShopLoginCubit() : super(ShopLoginInitState());

  static ShopLoginCubit get (context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  bool isPassword = true;




  void changeVisi()
  {
    isPassword = !isPassword;
    emit(ShopLoginChangeVisiState());
  }

  void postData
      (String email,
      String password,)
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data:
    {
      'email':email,
      'password': password,
    },).then((value)
    {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}