import 'package:bee/model/category_model.dart';
import 'package:bee/screens/cart_screen/cart_screen.dart';
import 'package:bee/screens/favorites_screen/favorites_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  var search = TextEditingController();
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
                icon: Icon(IconBroken.Arrow___Left_2,color: defColor,),
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
                    'Categories',
                    style:  TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      isDrawar=false;
                      navegatTo(context, FavoritesScreen());
                    },
                    splashColor: defColor,
                    icon: const Icon(
                      IconBroken.Heart,
                      color: defColor,
                      size: 30,
                    )),
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
              condition: c.homeModel != null,
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: defColor,
                  )),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>category(
                    c.categoryModel.categoryData!, index),
                    separatorBuilder: (context,index)=>Container(height: 10,),
                    itemCount: c.categoryModel.categoryData!.singleCategoryData.length),
              ),
            ),
          );
        });
  }

  Widget category(CategoryData categoryData, index) => Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.15),
          blurRadius: 5,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: cachedImage(categoryData.singleCategoryData[index].image, (context, imageProvider) => Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                )),
          )),
        ),
        Expanded(
          flex: 2,
          child: Text(
            categoryData.singleCategoryData[index].name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

}
