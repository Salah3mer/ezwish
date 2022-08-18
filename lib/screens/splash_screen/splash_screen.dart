import 'dart:async';
import 'package:bee/screens/drawer/drawer.dart';
import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/screens/login_screen/login_screen.dart';
import 'package:bee/screens/on_boarding_screen/on_bording_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/network/local/cash_helper.dart';
import 'package:bee/shared/style/style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
{
  void initState(){

   bool? onBoarding = CashHelper.getCashedData(key: 'onBoarding');
    Widget widget;
    if(onBoarding!=null){
      if(token==null){
        widget = LoginScreen();
      }else{
        widget =HomeScreen();
      }
    }else{
      widget=OnBoardingScreen();
    }

    super.initState();
    Timer(const Duration(seconds:3),(){
      navegatToAndFinsh(context,widget);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Spacer(),
            Container (
                height: 290,
                width: double.infinity,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image:  AssetImage('assets/image/splashlogo.png'),
                  ),
                )
            ),
            Spacer(),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(defColor),
            ),
            const SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}