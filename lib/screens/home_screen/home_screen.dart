import 'package:bee/model/category_model.dart';
import 'package:bee/model/home_model.dart';
import 'package:bee/screens/cart_screen/cart_screen.dart';
import 'package:bee/screens/category_screen/category_screen.dart';
import 'package:bee/screens/favorites_screen/favorites_screen.dart';
import 'package:bee/screens/product_details/product_details_screen.dart';
import 'package:bee/screens/profile/profile.dart';
import 'package:bee/screens/search_screen/search_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreen extends StatelessWidget {

  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              elevation: .5,
              backgroundColor: Colors.grey[50],
              leading:IconButton(
                onPressed: () => c.toggleDrawer(),
                icon: Icon(IconBroken.Filter,color: defColor,),
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
                    'ezwish',
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
                     c.getCart();
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
              condition: c.homeModel != null&&c.favoritesModel!=null&&c.cartModel!=null,
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: defColor,
              )),
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: InkWell(
                              onTap: () {
                                isDrawar=false;
                                navegatTo(context, ProfileScreen());
                              },
                              child: CircleAvatar(
                                radius: 26,
                                child: cachedImage( userModel.userData!.image, (context, imageProvider) =>  CircleAvatar(
                                  radius: 25,
                                  backgroundImage: imageProvider,
                                ),)
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          Text(
                            'Hi,${userModel.userData!.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
//
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 30),
                        child: Text(
                          'Find Your\nFavorites Products',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: defColor),
                        ),
                      ),
                      myFormField(
                          myColor: Colors.grey[200],
                          controller: search,
                          label: 'Find Your Products ',
                          suffix: const Icon(IconBroken.Search, color: Colors.white),
                          suffixColor: defColor,
                          readonly: true,
                        onTap: ()
                            {
                              isDrawar=false;
                              navegatTo(context, SearchScreen());

                        }
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider.builder(
                          itemCount: c.homeModel!.homeData!.banners.length,
                          itemBuilder: (context, index, i) =>  cachedImage(
                              c.homeModel!.homeData!.banners[index].image, (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.06),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover
                                ),
                          ),)),
                          options: CarouselOptions(
                            autoPlay: true,
                            height: 175,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              isDrawar=false;
                              print(isDrawar);
                              navegatTo(context, CategoryScreen());
                            },
                            child: const Text('View More'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                                focusColor: defColor,
                                highlightColor: defColor,
                                hoverColor: defColor,
                                onTap: () {},
                                child: category(
                                    c.categoryModel.categoryData!, index)),
                            separatorBuilder: (context, index) => Container(
                                  width: 20,
                                  color: Colors.grey[50],
                                ),
                            itemCount: c.categoryModel.categoryData!
                                .singleCategoryData.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pepular Products',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View More',
                              ))
                        ],
                      ),
                      StaggeredGridView.countBuilder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                            focusColor: defColor,
                            highlightColor: defColor,
                            hoverColor: defColor,
                            onTap: () {
                              c.getProduct(c.homeModel!.homeData!.products[index].id);
                              navegatTo(context, ProductScreen());
                            },
                            child: homeGrid(c.homeModel!.homeData!, index,context)),
                        itemCount: c.homeModel!.homeData!.products.length,
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget category(CategoryData categoryData, index) => Container(
        height: 50,
        width: 150,
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
              child: cachedImage( categoryData.singleCategoryData[index].image, (context, imageProvider) => Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
              ),)
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

  Widget homeGrid(HomeData home, index,context) => Container(
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
             cachedImage( home.products[index].image, (context, imageProvider) =>  Image(
               image: NetworkImage(
                 home.products[index].image,
               ),
               fit: BoxFit.cover,
             ),),
              if (home.products[index].discount != 0)
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(18))),
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
          const SizedBox(
            height: 5,
          ),
          Text(
            home.products[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          if (home.products[index].discount != 0)
            Text(
              '${home.products[index].oldPrice.toString()} EGP',
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${home.products[index].price.toString()} EGP',
                style: const TextStyle(
                    color: defColor, fontWeight: FontWeight.bold),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppCubit.get(context).favorites[home.products[index].id]!? defColor:Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                      onPressed: () {
                      AppCubit.get(context).changeFavorites(home.products[index].id);
                      },
                      icon:  Icon(IconBroken.Heart, color: AppCubit.get(context).favorites[home.products[index].id]!?Colors.white:defColor)))
            ],
          )
        ]),
      );


}
