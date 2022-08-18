import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/screens/ordar/ordar_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  var noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = userModel.userData!.name;

    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey[50],
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2,color: defColor,size: 30,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/logo.png',
                      width: 35,
                      fit: BoxFit.fitHeight,
                      height: 75,
                    ),
                    const Text(
                      'Address',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        Expanded(child: Container(color: defColor,height: 1,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Enter Your Address',style: TextStyle(color: defColor),),
                        ),
                        Expanded(child: Container(color: defColor,height: 1,)),
                      ],),
                      SizedBox(
                        height: 20,
                      ),
                      myFormField(
                          controller: nameController,
                          label: 'name',
                          prefix: IconBroken.Profile,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                      ),
                      myFormField(
                          controller: cityController,
                          label: 'City',
                          type: TextInputType.text,
                          prefix: IconBroken.Location,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Enter Your City';
                            }
                            return null;
                          },
                      ),
                      myFormField(
                          controller: regionController,
                          label: 'Region',
                          type: TextInputType.text,
                          prefix: IconBroken.Location,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Enter Your Region';
                            }
                            return null;
                          },
                      ),
                      myFormField(
                        controller: detailsController,
                        label: 'Details',
                        type: TextInputType.text,
                        prefix: IconBroken.Paper,
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Enter Your Details ';
                          }
                          return null;
                        },
                      ),

                      myFormField(
                          controller: noteController,
                          label: 'Note',
                          type: TextInputType.text,
                          prefix: IconBroken.Paper,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
              ),
            ),
           bottomSheet:  Material(
              color: Colors.white,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              borderOnForeground: true,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
                child: ConditionalBuilder(
                     condition: state is! AddAddreessLoadingState,
                     fallback: (context) =>
                     const Center(
                       child:  CircularProgressIndicator(
                         color: defColor,
                       ),
                     ),
                     builder: (context) {
                       return defaultButton(
                           text: 'Confirm',
                           function: () {
                             if (formKey.currentState!.validate()) {
                               c.addAddress(name: nameController.text,
                                   city: cityController.text,
                                   region: regionController.text,
                                   note: noteController.text,
                                   details: detailsController.text
                               );
                             }

                             c.getAddress();
                             if(c.fromOrdar) {
                               navegatTo(context, OrdarScreen());
                               c.getAddress();
                             }else{
                               navegatTo(context, HomeScreen());
                             }
                           });
                     }),
              ),
            ),
          );
        });
  }
}
