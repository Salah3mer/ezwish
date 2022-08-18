import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

var passwordController = TextEditingController();
var newPasswordController = TextEditingController();
var rePasswordController = TextEditingController();
var formKey = GlobalKey<FormState>();

void ChangePasswordBottomSheet(context,AppCubit c,state)=>showModalBottomSheet(
    context: context,
      isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )
    ),
    builder: (context)=>Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

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
                  c.changePasswordEye();
                },
              ),
              myFormField(
                controller: newPasswordController,
                label: 'New Password',
                prefix: IconBroken.Lock,
                suffix: c.suffix,
                isPassword: c.isPassword,
                validate: (String? val) {
                  if (val!.length < 6) {
                    return 'can\'t be less than 6';
                  }
                },
                suffixOnPressed: () {
                  c.changePasswordEye();
                },
              ),
              myFormField(
                controller: rePasswordController,
                label: 'Re Password',
                prefix: IconBroken.Lock,
                suffix: c.suffix,
                isPassword: c.isPassword,
                validate: (String? val) {
                  if (newPasswordController.text != val) {
                    return 'not Correct';
                  }
                },
                suffixOnPressed: () {
                  c.changePasswordEye();
                },

              ),

          ConditionalBuilder(
              condition: AppState is !ChangePasswordLoadingState,
              fallback:(context)=>const CircularProgressIndicator(color: defColor,) ,
              builder: (context) {
                return defaultButton(
                    text: 'Change Password',
                    function: (){
                      if(formKey.currentState!.validate()){
                          c.changePassword(passwordController.text, newPasswordController.text);
                        }


                    }
                );
              }
          ),

            ],
          ),
        ),
      ),
    ),
);