import 'package:ayop01/layout/shop_layout/shop_layout.dart';
import 'package:ayop01/modules/shop_app/shop_login/cubit/cubit_login.dart';
import 'package:ayop01/modules/shop_app/shop_login/cubit/state_login.dart';
import 'package:ayop01/modules/shop_app/shop_register/shop_register_screen.dart';
import 'package:ayop01/shared/components/components.dart';
import 'package:ayop01/shared/network/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ayop01/shared/components/constants.dart';


class ShopLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
              {
                navigateAndFinish(context, ShopLayout(),);
                token = state.loginModel.data!.token!;

              }).catchError((e){print(e.toString());});
            } else
              {
                Fluttertoast.showToast(
                    msg: state.loginModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to our app for good things',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          onSubmitted: (s) {},
                          onTapUp: () {},
                          onChange: (s) {},
                          radius: 15,
                          prefix: Icons.email,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'email must be not empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextField(
                          label: 'Password',
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          onSubmitted: (s)
                          {
                            if(formKey.currentState!.validate())
                            {
                              cubit.postData(emailController.text, passwordController.text);
                              Center(child: CircularProgressIndicator());
                            }
                          },
                          onTapUp: () {},
                          onChange: (s) {},
                          radius: 15,
                          prefix: Icons.lock,
                          obscureText: cubit.isPassword,
                          suffix: cubit.isPassword? Icons.visibility_outlined : Icons.visibility_off,
                          suffixPressed: ()
                          {
                            cubit.changeVisi();
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'password is to short';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        state is ShopLoginLoadingState ? Center(child: CircularProgressIndicator()) : defaultButton(
                            function: () {
                              if(formKey.currentState!.validate())
                              {
                                cubit.postData(emailController.text, passwordController.text);
                              }
                            },
                            text: 'Login',
                            radius: 15),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegister());
                              },
                              child: Text('RegisterNow'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
