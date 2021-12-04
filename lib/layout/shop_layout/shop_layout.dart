
import 'package:ayop01/layout/shop_layout/cubit/cubit.dart';
import 'package:ayop01/layout/shop_layout/cubit/states.dart';
import 'package:ayop01/modules/shop_app/favorites/favorites.dart';
import 'package:ayop01/modules/shop_app/search/search.dart';
import 'package:ayop01/modules/shop_app/shop_cateogries/cateogries.dart';
import 'package:ayop01/modules/shop_app/shop_login/shop_login.dart';
import 'package:ayop01/modules/shop_app/shop_products/products.dart';
import 'package:ayop01/modules/shop_app/shop_settings/settings.dart';
import 'package:ayop01/shared/components/components.dart';
import 'package:ayop01/shared/network/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Talabatk'),
            actions: [
              IconButton(onPressed: (){ navigateTo(context, SearchScreen());}, icon: Icon(Icons.search),),
            ],
          ),
          //a
          body:cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex:cubit.currentIndex ,
              showSelectedLabels: true,
              type: BottomNavigationBarType.fixed,
              onTap: (index)
              {
                cubit.changeBotNav(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Cateogries'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
        );
      },

    );
  }
}
















// CacheHelper.removeData('token').then((value)
// {
// navigateAndFinish(context, ShopLogin(),);
//
// });
