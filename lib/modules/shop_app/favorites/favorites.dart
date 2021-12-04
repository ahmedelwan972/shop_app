import 'package:ayop01/layout/shop_layout/cubit/cubit.dart';
import 'package:ayop01/layout/shop_layout/cubit/states.dart';
import 'package:ayop01/models/shop_login_models/fav_models.dart';
import 'package:ayop01/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favModels!.data?.data.length !=0 ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>    buildListItem(
              ShopCubit.get(context).favModels!.data!.data[index].product, context),
          separatorBuilder: (context, index) => Container(
            height: 1,
            width: 1,
            color: Colors.grey,
          ),
          itemCount: ShopCubit.get(context).favModels!.data!.data.length,
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_outlined,
                size: 100.0,
                color: Colors.grey,),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sorry not Favorites yet please add some favorites',
              ),

            ],
          ),
        );
      },
    );
  }

}
