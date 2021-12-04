import 'package:ayop01/layout/news_app/cubit/cubit.dart';
import 'package:ayop01/layout/news_app/news_app.dart';
import 'package:ayop01/layout/shop_layout/cubit/cubit.dart';
import 'package:ayop01/layout/shop_layout/shop_layout.dart';
import 'package:ayop01/layout/todo!app/cubit.dart';
import 'package:ayop01/layout/todo!app/states.dart';
import 'package:ayop01/modules/shop_app/shop_login/cubit/cubit_login.dart';
import 'package:ayop01/modules/shop_app/shop_login/shop_login.dart';
import 'package:ayop01/modules/shop_app/shop_on_boarding/on_boarding.dart';
import 'package:ayop01/shared/components/constants.dart';
import 'package:ayop01/shared/network/local/cacheHelper.dart';
import 'package:ayop01/shared/network/remote/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/shop_layout/cubit/states.dart';
import 'shared/bloc_observer.dart';

void main() async {
  BlocOverrides.runZoned(
    () {
      ShopLoginCubit();
      ShopCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init1();

  //bool? isDarkk = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    //isDark:isDarkk! ,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //final bool isDark;
  final Widget startWidget;
  MyApp({
    // required this.isDark,
    required this.startWidget,
  });
//a
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        //..changeMode(issDark: isDark)
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),

        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
      ],
      child: BlocConsumer<AppCubit, AppStateCubit>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode
              .light, //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: startWidget,
        ),
      ),
    );
  }
}
