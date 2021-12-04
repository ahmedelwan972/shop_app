import 'package:ayop01/modules/shop_app/search/cubit/cubit.dart';
import 'package:ayop01/modules/shop_app/search/cubit/states.dart';
import 'package:ayop01/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var forKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: forKey,
              child: Padding(
                padding: const EdgeInsets.all(10.4),
                child: Column(
                  children: [
                    defaultTextField(
                      label: 'Search',
                      type: TextInputType.text,
                      onChange: (s){},
                      onTapUp: (s){},
                      controller: searchController,
                      onSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      prefix: Icons.search,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Search must not be empty';
                        }
                      },
                    ),
                    SizedBox(height: 15,),

                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(height: 15,),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>    buildListItem(
                            SearchCubit.get(context).searchModels!.data!.data[index], context , isOldPrice: false),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          width: 1,
                          color: Colors.grey,
                        ),
                        itemCount: SearchCubit.get(context).searchModels!.data!.data.length,
                    ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
