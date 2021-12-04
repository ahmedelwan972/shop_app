import 'package:ayop01/models/shop_login_models/shop_user_models.dart';
import 'package:ayop01/modules/shop_app/shop_login/cubit/state_login.dart';
import 'package:ayop01/modules/shop_app/shop_register/cubit/state_register.dart';
import 'package:ayop01/shared/network/end_point.dart';
import 'package:ayop01/shared/network/remote/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{


  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get (context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  bool isPassword = true;




  void changeVisi()
  {
    isPassword = !isPassword;
    emit(ShopRegisterChangeVisiState());
  }

  void postData
      (
      String name,
      String email,
      String password,
      String phone
      )
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
    {
      'name':name,
      'email': email,
      'password': password,
      'phone': phone,
    },).then((value)
    {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}