import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MenuScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder:(context,state) {
        var c=AppCubit.get(context);
        return Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: Theme(
            data: ThemeData.dark(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTileTheme(
                        selectedColor: Colors.white,
                        child: ListTile(
                          leading: Icon(c.all[index].icon),
                          selectedTileColor: Colors.black26,
                          selected: c.currentItem==index,
                          title: Text(c.all[index].name),
                          onTap: () => c.onSelect(index,context),
                        ),
                      ),

                      itemCount: c.all.length,
                    ),
                  ),

                  ListTileTheme(
                    selectedColor: Colors.white,
                    child: ListTile(
                      leading: Icon(IconBroken.Logout),
                      title: Text('LogOut',style: TextStyle(color: Colors.white),),
                      onTap: () => c.logOut(context),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
      },
    );
  }

}
