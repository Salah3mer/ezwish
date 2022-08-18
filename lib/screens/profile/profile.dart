import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = userModel.userData!.name;
    emailController.text = userModel.userData!.email;
    phoneController.text = userModel.userData!.phone;
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: .5,
              backgroundColor: Colors.grey[50],
              leading: isDrawar
                  ? IconButton(
                      onPressed: () {
                        c.toggleDrawer();
                      },
                      icon: Icon(
                        IconBroken.Filter,
                        color: defColor,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        IconBroken.Arrow___Left_2,
                        color: defColor,
                        size: 30,
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
                      'EditProfile',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    )
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
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              c.pickImage().then((value) {
                                print(base64Image);
                              });
                            },
                            child: Stack(
                              children: [
                                c.imageFile != null
                                    ? CircleAvatar(
                                        radius: 72,
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundColor: Colors.white,
                                          backgroundImage: c.imageFile != null
                                              ? FileImage(c.imageFile!)
                                              : null,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 72,
                                        child: cachedImage(
                                          userModel.userData!.image,
                                          (context, imageProvider) =>
                                              CircleAvatar(
                                                  radius: 70,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage:
                                                      imageProvider),
                                        )),
                                Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[100],
                                      child: const Icon(
                                        IconBroken.Camera,
                                        color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                              suffix: Icon(
                                IconBroken.Edit,
                                color: Colors.white,
                              )),
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
                              },
                              suffix: Icon(
                                IconBroken.Edit,
                                color: Colors.white,
                              )),
                          myFormField(
                              controller: phoneController,
                              label: 'phone',
                              type: TextInputType.phone,
                              prefix: IconBroken.Call,
                              maxleanth: 11,
                              isNumber: true,
                              validate: (String? val) {
                                if (val!.length < 11) {
                                  return 'can\'t be less than 11';
                                }
                              },
                              suffix: Icon(
                                IconBroken.Edit,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                              condition: state is! UpdateUserLoadingStateState,
                              fallback: (context) =>
                                  const CircularProgressIndicator(
                                    color: defColor,
                                  ),
                              builder: (context) {
                                return defaultButton(
                                    text: 'Update Now',
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        if (base64Image.isNotEmpty) {
                                          c.updateProfile(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              image: base64Image.toString());
                                          myToast(
                                              mas: userModel.massage,
                                              color: userModel.status
                                                  ? Colors.green
                                                  : Colors.red);
                                        } else {
                                          c.updateProfile(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              image: userModel.userData!.image);
                                          myToast(
                                              mas: userModel.massage,
                                              color: userModel.status
                                                  ? Colors.green
                                                  : Colors.red);
                                        }
                                      }
                                    });
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
