import 'package:ayop01/layout/shop_layout/cubit/cubit.dart';
import 'package:ayop01/layout/shop_layout/cubit/states.dart';
import 'package:ayop01/models/shop_login_models/categories_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context , index)=>buildCate(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context , index)=> Container(height: 1, width: 1, color: Colors.grey,),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  buildCate(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(
          '${model.image}',
        ),
          width: 120, height: 120, fit: BoxFit.cover,),
        SizedBox(width: 15,),
        Text('${model.name}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );

}
