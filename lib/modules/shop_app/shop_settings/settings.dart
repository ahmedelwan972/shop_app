import 'package:ayop01/layout/shop_layout/cubit/cubit.dart';
import 'package:ayop01/layout/shop_layout/cubit/states.dart';
import 'package:ayop01/modules/shop_app/shop_login/shop_login.dart';
import 'package:ayop01/shared/components/components.dart';
import 'package:ayop01/shared/network/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context).userData!;
          nameController.text = cubit.data!.name!;
          emailController.text = cubit.data!.email!;
          phoneController.text = cubit.data!.phone!;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextField(
                        label: '${cubit.data!.name!}',
                        radius: 15,
                        onChange: (s) {},
                        onTapUp: () {},
                        onSubmitted: (s) {},
                        type: TextInputType.name,
                        controller: nameController,
                        prefix: Icons.person,
                        validate: (value) {
                          if (value.isEmpty) {
                            'name must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        label: '${cubit.data!.email!}',
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        radius: 15,
                        onChange: (s) {},
                        onTapUp: () {},
                        onSubmitted: (s) {},
                        prefix: Icons.email,
                        validate: (value) {
                          if (value.isEmpty) {
                            'email must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        label: '${cubit.data!.phone!}',
                        type: TextInputType.phone,
                        controller: phoneController,
                        radius: 15,
                        onChange: (s) {},
                        onTapUp: () {},
                        onSubmitted: (s) {},
                        prefix: Icons.phone,
                        validate: (value) {
                          if (value.isEmpty) {
                            'phone must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                            );
                          }
                        },
                        text: 'Update',
                        radius: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          CacheHelper.removeData('token').then((value) {
                            if(value)
                              navigateAndFinish(context, ShopLogin());
                          });
                        },
                        text: 'Logout',
                        radius: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
