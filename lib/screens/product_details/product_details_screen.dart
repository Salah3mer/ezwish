import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:bee/shared/style/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if(state is AddOrRemoveFromCartSuccessState){
            myToast(mas: state.massage, color: Colors.green);
          }
        },
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.indigo.shade100,
              body: SafeArea(
                child: ConditionalBuilder(
                    condition: state is !GetProductLoadingState,
                    builder: (context)=> Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade100,

                                ),
                                child: PageView.builder(
                                  controller:pageController ,
                                  itemCount:c.productDetailesModel!.data!.image.length ,
                                  itemBuilder: (context,index)=>  cachedImage(c.productDetailesModel!.data!.image[index], (context, imageProvider) => Image(
                                      image:imageProvider
                                  ),
                                  ),),
                              ),
                              Positioned(
                                top: 5,
                                left: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        IconBroken.Arrow___Left_2,
                                        color: Colors.black,
                                        size: 30,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SmoothPageIndicator(
                                    controller: pageController,
                                    count: c.productDetailesModel!.data!.image.length,
                                    effect: ExpandingDotsEffect(
                                      dotColor: Colors.grey.shade300,
                                      activeDotColor: defColor,
                                    )),
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey[100],
                                child: Padding(
                                  padding:  EdgeInsets.only(right: 15,left: 15,bottom: MediaQuery.of(context).size.height / 10,top: 15),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color:c.favorites[c.productDetailesModel!.data!.id!]!? defColor:Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      c.changeFavorites(c.productDetailesModel!.data!.id!);
                                                    },
                                                    icon:  Icon(IconBroken.Heart, color: c.favorites[c.productDetailesModel!.data!.id!]!?Colors.white:defColor)))
                                          ],
                                        ),
                                       const SizedBox(height: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex:2,
                                                    child: Text(c.productDetailesModel!.data!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                                                Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        if (c.productDetailesModel!.data!.discount != 0)
                                                          Text(
                                                            '${c.productDetailesModel!.data!.oldPrice.toString()} EGP',
                                                            style: const TextStyle(
                                                              color: Colors.grey,
                                                              decoration: TextDecoration.lineThrough,
                                                            ),
                                                          ),
                                                        Text('${c.productDetailesModel!.data!.price.toString()} EGP',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),textAlign: TextAlign.end,),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                            const  SizedBox(height: 5,),
                                            const Text('Description',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.indigo)),
                                            const  SizedBox(height: 5,),
                                            Text(c.productDetailesModel!.data!.description!,style:TextStyle(fontSize: 15,color: Colors.indigo.shade300),),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))),
                      ],
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator(),))
              ),
              bottomSheet:BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                notchMargin: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.indigo)),
                        height: 60,
                        child: MaterialButton(
                          onPressed: () {
                            c.addOrRemoveFromCart(c.productDetailesModel!.data!.id!);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Add To Cart  ',style: TextStyle(color: Colors.indigo),),
                              Icon(IconBroken.Bag,color: Colors.indigo,),
                            ],
                          ),
                        ),
                      ),
                    ),
                   const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: defaultButton(
                          function: () {}, text: 'Buy'),
                    )
                  ],
                ),
              ),


          );

        });
  }
}
