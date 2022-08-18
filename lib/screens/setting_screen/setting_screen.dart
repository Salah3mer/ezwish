
import 'package:bee/screens/change_password_bottom_sheet/change_password_buttom_sheet.dart';
import 'package:bee/screens/contact_me_bottom_sheet/contact_me_bottom_sheet.dart';
import 'package:bee/screens/ordars_screen/ordars_screen.dart';
import 'package:bee/screens/privacy_bottom_sheet/privacy_bottom_sheet.dart';
import 'package:bee/screens/profile/profile.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState){
            myToast(mas: state.msg, color: state.state?Colors.green:Colors.red);
            if(state.state){
              passwordController.text='';
              rePasswordController.text='';
              newPasswordController.text='';
              Navigator.pop(context);

            }
          }
        },
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
                      'Settings',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account',
                      style:
                          TextStyle(color: defColor, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileTheme(
                      iconColor: defColor,
                      textColor: Colors.black,
                      child: ListTile(
                        onTap: (){
                          isDrawar=false;
                          navegatTo(context, ProfileScreen());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        dense: true,
                        tileColor: Colors.grey[100],
                        leading: Icon(IconBroken.Profile),
                        title: Text('Edit Profile',style: TextStyle(fontSize: 16)),
                        trailing: Icon(IconBroken.Arrow___Right_2),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTileTheme(
                      iconColor: defColor,
                      textColor: Colors.black,
                      child: ListTile(
                        onTap: (){
                        ChangePasswordBottomSheet(context, c, state);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        dense: true,
                        tileColor: Colors.grey[100],
                        leading: Icon(IconBroken.Password),
                        title: Text('Change Password',style: TextStyle(fontSize: 16),),
                        trailing: Icon(IconBroken.Arrow___Right_2),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTileTheme(
                      iconColor: defColor,
                      textColor: Colors.black,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onTap: (){
                          isDrawar=false;
                          navegatTo(context, OrdarsScreen());
                        },
                        dense: true,
                        tileColor: Colors.grey[100],
                        leading: Icon(IconBroken.Buy),
                        title: Text('Ordar',style: TextStyle(fontSize: 16),),
                        trailing: Icon(IconBroken.Arrow___Right_2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child:  Text(
                        'Legal',
                        style:
                        TextStyle(color: defColor,fontSize: 16 ,fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTileTheme(
                      iconColor: defColor,
                      textColor: Colors.black,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onTap: (){
                          c.aboutUS();
                        PrivacyBottomSheet(context, c, state);
                        },
                        dense: true,
                        tileColor: Colors.grey[100],
                        leading: Icon(IconBroken.Shield_Done),
                        title: Text('Privacy Policy',style: TextStyle(fontSize: 16),),
                        trailing: Icon(IconBroken.Arrow___Right_2),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTileTheme(
                      iconColor: defColor,
                      textColor: Colors.black,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        onTap: (){
                          ContactMeBottomSheet(context, c, state);
                        },
                        dense: true,
                        tileColor: Colors.grey[100],
                        leading: Icon(IconBroken.Activity),
                        title: Text('Contact Me',style: TextStyle(fontSize: 16),),
                        trailing: Icon(IconBroken.Arrow___Right_2),
                      ),
                    ),
                    const Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12.0),
                      child:  Text(
                        'FAQ',
                        style:
                        TextStyle(color: defColor,fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemBuilder: (context,index)=>bulidFAQ(c,index), separatorBuilder:(context,index)=> SizedBox(height: 5,), itemCount: c.faqModel!.data!.question.length)



                  ],
                ),
              ),
            ),
          );
        });
  }

Widget bulidFAQ(AppCubit c,index)=>  ClipRRect(
  borderRadius: BorderRadius.circular(15),
  clipBehavior: Clip.antiAlias,
  child: ExpansionTile(
    backgroundColor: Colors.grey[100],
    collapsedBackgroundColor: Colors.grey[100],

    childrenPadding: EdgeInsets.all(10),
    onExpansionChanged: (value){
      c.changeExppension(value);
    },
    leading: Icon(IconBroken.Info_Square,color: defColor,),
    title: Text(c.faqModel!.data!.question[index].question!,style: TextStyle(fontSize: 16),),
    trailing:c.isOpen?Icon(IconBroken.Arrow___Up_2,color: defColor,) :Icon(IconBroken.Arrow___Down_2,color: defColor,),
    children:  [
      Text(c.faqModel!.data!.question[index].answer!,style: TextStyle(fontSize: 16),)
    ],
  ),
);
}


