import 'package:bee/model/favorites/favorites_model.dart';
import 'package:bee/screens/cart_screen/cart_screen.dart';
import 'package:bee/screens/product_details/product_details_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
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
                    'my wishes',
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
              condition: c.favoritesModel!.data!.data.isNotEmpty,
              fallback: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    IconBroken.Heart,
                    size: 100,
                    color: defColor,
                  ),
                  Center(
                      child: Text(
                    'Add Products To Favorites ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                    itemBuilder: (context, index) =>c.favorites[c.favoritesModel!.data!.data[index].product!.id]==true?favoritesDesign(c.favoritesModel!.data!, index, context):const SizedBox(height: .001,),
                    separatorBuilder: (context, index) => Container(
                          height: 10,
                        ),
                    itemCount: c.favoritesModel!.data!.data.length),
              ),
            ),
          );
        });
  }

  favoritesDesign(Data data, index, context) => InkWell(
    onTap: (){
      AppCubit.get(context).getProduct(data.data[index].product!.id!);
      navegatTo(context, ProductScreen());
    },
    child: Container(
          height: 150,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    cachedImage(
                      data.data[index].product!.image!,
                      (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (data.data[index].product!.discount != 0)
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(18))),
                        child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Text(
                            'Discount',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.data[index].product!.name!,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            if (data.data[index].product!.discount != 0)
                              Text(
                                '${data.data[index].product!.oldPrice.toString()} EGP',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              '${data.data[index].product!.price.toString()} EGP',
                              style: const TextStyle(
                                  color: defColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                            decoration: BoxDecoration(
                              color: AppCubit.get(context)
                                      .favorites[data.data[index].product!.id]!
                                  ? defColor
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context).changeFavorites(
                                      data.data[index].product!.id!);
                                },
                                icon: Icon(IconBroken.Delete,
                                    color: AppCubit.get(context).favorites[
                                            data.data[index].product!.id]!
                                        ? Colors.white
                                        : defColor))),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
  );
}
