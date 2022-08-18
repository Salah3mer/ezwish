import 'package:bee/screens/login_screen/login_screen.dart';
import 'package:bee/screens/register_screen/cubit/register_cubit.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/const.dart';
import '../../shared/style/style.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var rePasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = RegisterCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Image(
                            image: AssetImage('assets/image/register.png'),
                            width: double.infinity,
                          )),
                      Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text('Register Now To Get Our Hot Offers',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: myFormField(
                                          controller: nameController,
                                          label: 'name',
                                          prefix: IconBroken.Profile,
                                          validate: (String? val) {
                                            if (val!.isEmpty) {
                                              return 'Enter Your Name';
                                            }
                                            return null;
                                          }),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          c.pickImage().then((value) {
                                            print(base64Image);
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundColor:Colors.blueAccent,
                                              backgroundImage: c.imageFile!=null? FileImage(c.imageFile!):null,

                                            ),
                                            Positioned(
                                              right: 10,
                                              bottom: 0,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  child: const Icon(
                                                    IconBroken.Camera,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
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
                                      return null;
                                    }),
                                myFormField(
                                  controller: phoneController,
                                  label: 'phone',
                                  type: TextInputType.phone,
                                  prefix: IconBroken.Call,
                                  maxleanth: 11,
                                  validate: (String? val) {
                                    if (val!.length < 11) {
                                      return 'can\'t be less than 11';
                                    }
                                  },
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
                                    c.changeRegisterEye();
                                  },
                                ),
                                myFormField(
                                  controller: rePasswordController,
                                  label: 'Re Password',
                                  prefix: IconBroken.Lock,
                                  suffix: c.suffix,
                                  isPassword: c.isPassword,
                                  validate: (String? val) {
                                    if (passwordController.text != val) {
                                      return 'not Correct';
                                    }
                                  },
                                  suffixOnPressed: () {
                                    c.changeRegisterEye();
                                  },
                                ),
                                const SizedBox(height: 10,),
                                ConditionalBuilder(
                                  condition:state is !CreateUserLoadingState,
                                  fallback:(context)=>const CircularProgressIndicator(color: defColor,) ,
                                  builder: (context) {
                                    return defaultButton(
                                      text: 'Register Now',
                                      function: (){
                                        if(formKey.currentState!.validate()){
                                          if(base64Image.isNotEmpty){
                                            c.createUser(name: nameController.text, email: emailController.text, password: passwordController.text, phone: phoneController.text,image: base64Image.toString());
                                            myToast(mas: c.userModel!.massage, color:  c.userModel!.status ?Colors.green:Colors.red);
                                          }else {
                                            c.createUser(name: nameController.text, email: emailController.text, password: passwordController.text, phone: phoneController.text,image: '');
                                            myToast(mas: c.userModel!.massage, color:  c.userModel!.status ?Colors.green:Colors.red);
                                          }

                                        }
                                      }
                                    );
                                  }
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Already Have Account ? '),
                                    TextButton(
                                        onPressed: () {
                                          navegatTo(context, LoginScreen());
                                        },
                                        child: const Text(
                                          'Login Now',
                                          style: TextStyle(
                                              color: defColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),

                              ],
                            ),
                          )),
                    ],
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
