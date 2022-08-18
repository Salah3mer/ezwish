import 'dart:ui';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void>openLink(String link)async{
  var urlink=link;
  if(await canLaunch((urlink))){
    await launch (urlink);
  }
  else{
    await launch (urlink);
  }
}

void ContactMeBottomSheet(context,AppCubit c,state)=>showModalBottomSheet(
  context: context,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )
  ),
  builder: (context)=>Container(
    height: 250,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('Contect ME',style: TextStyle(color:defColor,fontWeight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  final url ='https://www.instagram.com/sa1ah_amer/';
                  openLink(url);

                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:AssetImage('assets/image/instagram.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  final url ='https://www.facebook.com/salah.amer.5245961';
                  openLink(url);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:AssetImage('assets/image/facebook.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  final url ='http://wa.me/201069446531';
                  openLink(url);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage('assets/image/whatsapp.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),


            ],
          ),
          Spacer(),

          defaultButton(
              text: 'Back',
              function: (){
                Navigator.pop(context);
              }
          )
        ],
      ),
    ),
  ),
);