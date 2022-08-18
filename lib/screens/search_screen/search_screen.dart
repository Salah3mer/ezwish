import 'package:bee/model/search_model.dart';
import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/screens/product_details/product_details_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Material(
                            color: Colors.grey[100],
                            elevation: 2,
                            shadowColor: Colors.indigo.shade200,
                            borderRadius: BorderRadius.circular(15),
                            child:isDrawar? IconButton(
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
                          ),

                          Expanded(
                            child: myFormField(
                                controller: search,
                                label: 'search',
                                suffixOnPressed: (){
                                  search.text='';
                                  c.search(text: search.text);
                                },
                                onChange: (String? value){
                                  c.search(text: value!);
                                },
                                prefix: IconBroken.Search,
                                suffix: Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                )
                            ),
                          ),
                        ],
                      ),


                      ConditionalBuilder(
                        condition: c.searchModel!=null,
                        fallback: (context) => const Center( heightFactor:1.5, child: Image(image: AssetImage('assets/image/searching.png'),)),
                        builder: (context) => ListView.separated(
                          physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => SearchDesign(
                                c.searchModel!.data!, index, context),
                            separatorBuilder: (context, index) => Container(
                                  height: 10,
                                ),
                            itemCount: c.searchModel!.data!.product.length),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  SearchDesign(Data data, index, context) => InkWell(
    onTap: (){
      AppCubit.get(context)
          .getProduct(data.product[index].id!);
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
                      data.product[index].image!,
                      (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
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
                      data.product[index].name!,
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
                            Text(
                              '${data.product[index].price.toString()} EGP',
                              style: const TextStyle(
                                  color: defColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                            decoration: BoxDecoration(
                              color: defColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .getProduct(data.product[index].id!);
                                  navegatTo(context, ProductScreen());

                                },
                                icon: Icon(IconBroken.Arrow___Right_2,
                                    color: Colors.white))),
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
