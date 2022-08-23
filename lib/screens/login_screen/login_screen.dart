import 'package:bee/screens/drawer/drawer.dart';
import 'package:bee/screens/register_screen/register_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/network/local/cash_helper.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late var emailController = TextEditingController();
    late var passwordController = TextEditingController();
    late var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, LoginState state) {
        if (state is UserLoginSucsessState) {
          if (state.userModel.status) {
            token = state.userModel.userData!.token.toString();
            CashHelper.saveData(
                    key: 'token',
                    value: state.userModel.userData!.token.toString())
                .then((value) {
              AppCubit.get(context)
                ..getHome()
                ..getFavorites()
                ..getCart()
                ..getOrdars();
              navegatTo(context, DrawerScreenWidget());
            });

            myToast(mas: state.userModel.massage, color: Colors.green);
          } else {
            myToast(mas: state.userModel.massage, color: Colors.red);
          }
        }
      }, builder: (context, state) {
        var c = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: double.infinity,
                          child: Image(
                            image: AssetImage('assets/image/Sign in.png'),
                          ))),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Welcome Back ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          myFormField(
                              controller: emailController,
                              label: 'Email',
                              type: TextInputType.emailAddress,
                              prefix: IconBroken.Message,
                              validate: (String? val) {
                                Pattern pattern =
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?)*$";
                                RegExp reg = RegExp(pattern.toString());
                                if (!reg.hasMatch(val!)) {
                                  return 'Enter a valid email address';
                                }
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          myFormField(
                            controller: passwordController,
                            label: 'Password',
                            prefix: IconBroken.Lock,
                            suffix: c.suffix,
                            isPassword: c.isPassword,
                            validate: (String? val) {
                              if (val!.length < 6) {
                                return 'can\'t be less than 6';
                              }
                            },
                            suffixOnPressed: () {
                              c.changeLoginEye();
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                      color: defColor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ConditionalBuilder(
                            condition: state is! UserLoginLoadinState,
                            builder: (context) {
                              return defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      c.login(
                                          userEmail: emailController.text,
                                          password: passwordController.text);
                                      fromLogin = true;
                                    }
                                  },
                                  text: 'Login Now');
                            },
                            fallback: (BuildContext context) =>
                                const CircularProgressIndicator(
                              color: defColor,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t Have Account ? '),
                              TextButton(
                                  onPressed: () {
                                    navegatTo(context, RegisterScreen());
                                  },
                                  child: const Text(
                                    'Register Now',
                                    style: TextStyle(
                                        color: defColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}
