import 'package:bee/model/cart/cart_model.dart';
import 'package:bee/screens/address_screen/address_screen.dart';
import 'package:bee/screens/favorites_screen/favorites_screen.dart';
import 'package:bee/screens/ordar/ordar_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
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
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/image/logo.png',
                  width: 35,
                  fit: BoxFit.fitHeight,
                  height: 75,
                ),
                const Text(
                  'myCart',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ]),
              actions: [
                IconButton(
                    onPressed: () {
                      isDrawar = false;
                      navegatTo(context, FavoritesScreen());
                    },
                    icon: const Icon(
                      IconBroken.Heart,
                      size: 30,
                      color: defColor,
                    )),
              ],
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: c.cartModel!.data!.cartItems.isNotEmpty,
              fallback: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/image/empty_cart.png')),
                  Center(
                      child: Text(
                    'Add Products To Cart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: MediaQuery.of(context).size.height / 7,
                    top: 15),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        c.cartModel!.data!.cartItems[index].product!.inCart ==
                                true
                            ? cartDesign(c.cartModel!, index, context)
                            : const SizedBox(
                                height: 0.001,
                              ),
                    separatorBuilder: (context, index) => Container(
                          height: 10,
                        ),
                    itemCount: c.cartModel!.data!.cartItems.length),
              ),
            ),
            bottomSheet: Material(
              color: Colors.white,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              borderOnForeground: true,
              elevation: 5,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Spacer(),
                            Text(c.cartModel!.data!.total.toString(),
                                style: TextStyle(
                                    color: defColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                          condition: state is! AddAddreessLoadingState,
                          fallback: (context) =>
                              const CircularProgressIndicator(
                                color: defColor,
                              ),
                          builder: (context) {
                            return defaultButton(
                                text: 'ChekOut',
                                function: () {
                                  c.getAddress();
                                  navegatTo(context, OrdarScreen());
                                });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  cartDesign(CartModel data, index, context) => Slidable(
        key: Key(data.data!.cartItems[index].id.toString()),
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
                        AppCubit.get(context)
                            .removeFromCart(data.data!.cartItems[index].id);
                      },
                      icon: Icon(IconBroken.Delete, color: Colors.white))),
            ),
          ],
        ),
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
                      data.data!.cartItems[index].product!.image!,
                      (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (data.data!.cartItems[index].product!.discount != 0)
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                      data.data!.cartItems[index].product!.name!,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
                            if (data.data!.cartItems[index].product!.discount !=
                                0)
                              Text(
                                '${data.data!.cartItems[index].product!.oldPrice.toString()} EGP',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              '${data.data!.cartItems[index].product!.price.toString()} EGP',
                              style: const TextStyle(
                                  color: defColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).quantity(
                                data.data!.cartItems[index].quantity,
                                data.data!.cartItems[index].id,
                                data.data!.cartItems[index].id,
                                index);
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.remove,
                              color: defColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                              data.data!.cartItems[index].quantity.toString(),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).quantity(
                                data.data!.cartItems[index].quantity,
                                data.data!.cartItems[index].id,
                                data.data!.cartItems[index].id,
                                index,
                                isPluse: true);
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.add,
                              color: defColor,
                            ),
                          ),
                        ),
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
