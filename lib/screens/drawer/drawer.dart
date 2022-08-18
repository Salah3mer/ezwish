import 'package:bee/screens/drawer/menu.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class DrawerScreenWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder:(context,state) {
        var c= AppCubit.get(context);
        return ZoomDrawer(
        borderRadius: 40,
        showShadow: true,
          controller: c.zoomDrawerController,
          androidCloseOnBackTap:true ,
        menuBackgroundColor: Colors.indigo,
        slideWidth: MediaQuery.of(context).size.width * .6,
        mainScreen: c.screens[c.currentItem],
        menuScreen:Builder(
          builder: (context) {
            return MenuScreen();
          }
        ),

      );

      },
    );
  }
}
