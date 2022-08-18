import 'package:bee/screens/cart_screen/cart_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrdarsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              elevation: .5,
              backgroundColor: Colors.grey[50],
              leading:isDrawar? IconButton(
                onPressed: () {
                  c.toggleDrawer();
                },
                icon: Icon(IconBroken.Filter,color: defColor,),
              ):IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2,color: defColor,  size: 30,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    width: 35,
                    fit: BoxFit.fitHeight,
                    height: 75,
                  ),
                  const Text(
                    'my Ordars',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      isDrawar=false;
                      navegatTo(context, CartScreen());
                    },
                    icon: const Icon(
                      IconBroken.Bag_2,
                      size: 30,
                      color: defColor,
                    )),
              ],
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: c.ordars!=null,
              fallback: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/image/empty_cart.png')),
                  Center(
                      child: Text(
                        'Ordar Now ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                    itemBuilder: (context, index) =>ordarDesign(c, index, context),
                    separatorBuilder: (context, index) => Container(
                      height: 10,
                    ),
                    itemCount: c.ordars!.data!.ordar.length),
              ),
            ),
          );
        });
  }

  ordarDesign(AppCubit c, index, context) => c.ordars!.data!.ordar[index].state=='Cancelled'? Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(30) ,
    color: Colors.grey[100],
    child: Container(
      height: 120,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text('Date :' ,style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Text(c.ordars!.data!.ordar[index].date! ,style: TextStyle(color: defColor),),
              ],
            ),SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(c.ordars!.data!.ordar[index].state! ,style: TextStyle(color:c.ordars!.data!.ordar[index].total==0?Colors.red: defColor),),
              ],
            ),SizedBox(height: 5,),
            Row(
              children: [
                Text('Total :' ,style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Text(c.ordars!.data!.ordar[index].total.toString() ,style: TextStyle(color: defColor),),
              ],
            ),
          ],
        ),
      ),
    ),
  ):Slidable(
    key: Key(c.ordars!.data!.ordar[index].id.toString()),
    useTextDirection: true,
    endActionPane: ActionPane(
      motion: BehindMotion(),
      extentRatio: 0.25,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              decoration: BoxDecoration(
                color: defColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                  onPressed: () {
                   c.cancelOrder(id: c.ordars!.data!.ordar[index].id!);
                   c.getOrdars();
                  },
                  icon: Icon(IconBroken.Delete, color: Colors.white))),
        ),
      ],
    ),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30) ,
      color: Colors.grey[100],
      child: Container(
        height: 120,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Date :' ,style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Text(c.ordars!.data!.ordar[index].date! ,style: TextStyle(color: defColor),),
                ],
              ),SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(c.ordars!.data!.ordar[index].state! ,style: TextStyle(color:c.ordars!.data!.ordar[index].total==0?Colors.red: defColor),),
                ],
              ),SizedBox(height: 5,),
              Row(
                children: [
                  Text('Total :' ,style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Text(c.ordars!.data!.ordar[index].total.toString() ,style: TextStyle(color: defColor),),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
