import 'dart:ui';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/style.dart';
import 'package:flutter/material.dart';
void PrivacyBottomSheet(context,AppCubit c,state)=>showModalBottomSheet(
  context: context,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )
  ),
  builder: (context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('About',style: TextStyle(color:defColor,fontWeight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 5,),
          Text(c.about,style: TextStyle(fontSize: 18),),
          SizedBox(height: 10,),
          Text('Terms',style: TextStyle(color:defColor,fontWeight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 10,),
          Text(c.term,style: TextStyle(fontSize: 18),),
          SizedBox(height: 5,),
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