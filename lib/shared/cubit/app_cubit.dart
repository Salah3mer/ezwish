import 'dart:convert';
import 'dart:io';
import 'package:bee/model/address/address.dart';
import 'package:bee/model/cart/add_or_remove_from_cart.dart';
import 'package:bee/model/cart/cart_model.dart';
import 'package:bee/model/category_model.dart';
import 'package:bee/model/drawer_menu.dart';
import 'package:bee/model/faq_model.dart';
import 'package:bee/model/favorites/change_fav_model.dart';
import 'package:bee/model/favorites/favorites_model.dart';
import 'package:bee/model/home_model.dart';
import 'package:bee/model/ordars_model.dart';
import 'package:bee/model/product_model.dart';
import 'package:bee/model/search_model.dart';
import 'package:bee/model/user_model.dart';
import 'package:bee/screens/cart_screen/cart_screen.dart';
import 'package:bee/screens/category_screen/category_screen.dart';
import 'package:bee/screens/favorites_screen/favorites_screen.dart';
import 'package:bee/screens/home_screen/home_screen.dart';
import 'package:bee/screens/login_screen/login_screen.dart';
import 'package:bee/screens/ordars_screen/ordars_screen.dart';
import 'package:bee/screens/profile/profile.dart';
import 'package:bee/screens/search_screen/search_screen.dart';
import 'package:bee/screens/setting_screen/setting_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/network/local/cash_helper.dart';
import 'package:bee/shared/network/remote/dio_helper.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {


  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  late CategoryModel categoryModel;

  void getUser() {
    emit(GetUserLoadingState());
    DioHelper.getData(url: profile, token: token).then((value) {
      emit(GetUserSuccessState());
      userModel = UserModel.formjson(value.data);
    }).catchError((e) {
      emit(GetUserErrorState());
    });
  }

  Map<int, bool> favorites = {};

  void getHome() {
    emit(GetHomeLoadingState());
    DioHelper.getData(url: homeUrl, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.homeData!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(GetHomeSuccessState());
    }).catchError((e) {
      print('Error is ${e.toString()}');
      emit(GetHomeErrorState());
    });
  }

  ChangeFavModel? changeFavModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesState());
    DioHelper.postData(
        url: favoritesUrl,
        token: token,
        sendDate: {favoritesProductId: productId}).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      if (!changeFavModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      print(changeFavModel!.massage);
      emit(ChangeFavoritesSuccessState());
    }).catchError((e) {
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState());
    });
  }

  void getCategory() {
    emit(GetCategoryLoadingState());
    DioHelper.getData(url: categoryUrl, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(GetCategorySucssesState());
    }).catchError((e) {
      emit(GetCategoryErrorState());
      print(e.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: favoritesUrl, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((e) {
      emit(GetFavoritesErrorState(e.toString()));
      print(e.toString());
    });
  }

  ProductDetailesModel? productDetailesModel;

  void getProduct(int id) {
    emit(GetProductLoadingState());
    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value) {
      productDetailesModel = ProductDetailesModel.fromJson(value.data);
      print(productDetailesModel!.data!.name);
      emit(GetProductSuccessState());
    }).catchError((e) {
      emit(GetProductErrorState());
      print('getProduct error is $e');
    });
  }

  AddOrRemoveFromCartModel? addOrRemoveFromCartModel;

  void addOrRemoveFromCart(int productId) {
    emit(AddOrRemoveFromCartLoadingState());
    DioHelper.postData(
            url: cartUrl, sendDate: {cartProductId: productId}, token: token)
        .then((value) {
      addOrRemoveFromCartModel = AddOrRemoveFromCartModel.fromJson(value.data);
      emit(AddOrRemoveFromCartSuccessState(addOrRemoveFromCartModel!.massage!));
    }).catchError((e) {
      emit(AddOrRemoveFromCartErrorState());
      print('cart error is $e');
    });
  }

  CartModel? cartModel;

  void getCart() {
    emit(GetCartLoadingState());
    DioHelper.getData(url: cartUrl, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(cartModel!.data!.total);
      emit(GetCartSuccessState());
    }).catchError((e) {
      emit(GetCartErrorState());
      print('cart error is $e');
    });
  }

  void quantity(int quantity, cartId, productId, index,
      {bool isPluse = false}) {
    if (isPluse) {
      quantity++;
      cartModel!.data!.cartItems[index].quantity++;
    } else {
      quantity--;
      cartModel!.data!.cartItems[index].quantity--;
    }
    if (quantity > 1) {
      DioHelper.putData(
              url: 'carts/$cartId',
              sendDate: {'quantity': quantity},
              token: token)
          .then((value) {
        getCart();
        emit(SendQuantitySuccessState());
      }).catchError((e) {
        emit(SendQuantityErrorState());
        print('pluse $e');
      });
    } else if (quantity == 0) {
      removeFromCart(cartId);
    }
  }

  void removeFromCart(cartId) {
    DioHelper.remove(url: 'carts/$cartId', token: token).then((value) {
      getCart();
      emit(DeleteFromCartSuccessState());
    }).catchError((e) {
      emit(DeleteFromCartErrorState());
    });
  }

  File? imageFile;

  Future pickImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      List<int> imageBytes = imageFile!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      emit(PickImageSuccessState());
    }
  }

  void updateProfile(
      {required String name,
      required String email,
      required String image,
      required String phone}) {
    emit(UpdateUserLoadingStateState());
    DioHelper.putData(
            url: updateProfileUrl,
            sendDate: {
              'name': name,
              'email': email,
              'phone': phone,
              'image': image,
            },
            token: token)
        .then((value) {
      userModel = UserModel.formjson(value.data);
      emit(UpdateUserSuccessState());
    }).catchError((e) {
      emit(UpdateUserErrorState());
    });
  }

  SearchModel? searchModel;

  void search({required String text}) {
    emit(SearchLoadingStateState());
    DioHelper.postData(url: searchUrl, sendDate: {'text': text}).then((value) {
      emit(SearchSuccessState());
      searchModel = SearchModel.fromJson(value.data);
    }).catchError((e) {
      emit(SearchErrorState());
    });
  }

  int currentItem = 0;
  var all = <MenuModel>[
    MenuModel('Home', IconBroken.Home),
    MenuModel('Category', IconBroken.Category),
    MenuModel('Favorites', IconBroken.Heart),
    MenuModel('Cart', IconBroken.Buy),
    MenuModel('Ordars', IconBroken.Bag_2),
    MenuModel('Search', IconBroken.Search),
    MenuModel('Profile', IconBroken.Profile),
    MenuModel('Setting', IconBroken.Setting),
  ];

  List screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    CartScreen(),
    OrdarsScreen(),
    SearchScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  bool isPassword = true;
  Icon suffix = Icon(IconBroken.Hide);

  void changePasswordEye() {
    isPassword = !isPassword;
    suffix = isPassword ? Icon(IconBroken.Hide) : Icon(IconBroken.Show);

    emit(ChangeEye());
  }

  void onSelect(int item, context) {
    currentItem = item;
    isDrawar = true;
    print(isDrawar);
    ZoomDrawer.of(context)!.toggle();
    emit(changeState());
  }

  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    emit(toggle());
  }
  void addAddress({
    required String name,
    required String city,
    required String region,
    required String note,
    required String details,
  }) {
    emit(AddAddreessLoadingState());
    DioHelper.postData(url: addressUrl, sendDate: {
      "name": name,
      "city": city,
      "region": region,
      "details":details,
      "latitude": 30.0616863,
      "longitude": 31.3260088,
      "notes": note
    },token: token).then((value) {
      emit(AddAddreessSuccessState());
    }).catchError((e) {
      emit(AddAddreessErrorState());
      print(e);
    });
  } void updateAddress({
    id,
    required String name,
    required String city,
    required String region,
    required String note,
  }) {
    emit(UpdateAddreessLoadingState());
    DioHelper.putData(url: 'addresses/$id', sendDate: {
      "name": name,
      "city": city,
      "region": region,
      "note": note,
      "details": "no",
      "latitude": 0,
      "longitude": 0,
    },token: token).then((value) {
      emit(UpdateAddreessSuccessState());
    }).catchError((e) {
      emit(UpdateAddreessErrorState());
      print('erorr is $e');
    });
  }

  GetAddressModel? getAddressModel;
  void getAddress() {
    emit(GetAddreessLoadingState());
    DioHelper.getData(url: addressUrl, token: token)
        .then((value) {
      getAddressModel = GetAddressModel.fromJson(value.data);
      emit(GetAddreessSuccessState(getAddressModel));
    })
        .catchError((e) {
      emit(GetAddreessErrorState());

    });
  }

  bool fromOrdar=false;

  var currentStep =0;
  void stepper(index) {
   currentStep=index;
    emit(StepperState());
  }
  void stepperPluse() {
    if (currentStep != 1) {
      currentStep+=1;
    }
    if(currentStep==1){
      ordarNow(addressId: getAddressModel!.addressData!.address[currentSelected].id);
    }
    emit(StepperState());
  } void steppermin() {
    print(currentStep);
    if (currentStep != 0) {
      currentStep-=1;
    }
    emit(StepperState());
  }
  var currentSelected=0;
 void currentSelectedItem(index){
   currentSelected=index;
   emit(CurrentSelectedItem());
 }


 void ordarNow({
  required int addressId,
  }){
   DioHelper.postData(url: ordarUrl, sendDate: {
     "address_id": addressId,
     "payment_method": 1,
     "use_points": false,
     "promo_code_id": 0
   },token: token).then((value) {
    var s= value.data['message'].toString();
    var status= value.data['status'];
     emit(AddOrdarSuccessState(s,status));
   }).catchError((e){
     emit((AddOrdarErrorState()));
     print(e);
   });
 }
 bool isOpen=false;
 void changeExppension( value){
   isOpen=value;
   emit(ChangeExppension());
 }
 FAQModel? faqModel;
 void getQuestions(){
   emit(GetFAQLoadingState());
   DioHelper.getData(url: FAQUrl,).then((value) {
     faqModel=FAQModel.fromJson(value.data);
     emit(GetFAQSuccessState());
   }).catchError((e){
     print('eeee$e');
     emit(GetFAQErrorState());
   });
 }
 void changePassword(String pass, String newPass){
   emit(ChangePasswordLoadingState());
   DioHelper.postData(url:changePasswordUrl ,token: token,sendDate: {
     "current_password": pass,
     "new_password": newPass
   }).then((value) {
     String msg= value.data['message'].toString();
     bool status= value.data['status'];
     emit(ChangePasswordSuccessState(status,msg));
   }).catchError((e){
     print('eeee$e');
     emit(ChangePasswordErrorState());
   });
 }

String about ='';
 String term='';
 void aboutUS(){
   emit(GetPrivacyLoadingState());
   DioHelper.getData(url: aboutUSUrl).then((value) {
     about= value.data['data']['about'];
     term= value.data['data']['terms'];
     print(about);
     emit(GetPrivacySuccessState());

   }).catchError((e){
     emit(GetPrivacyErrorState());
   });
 }
 Ordars? ordars;
 void getOrdars(){
   emit(GetOrdarsLoadingState());
   DioHelper.getData(url: OrdarsUrl,token: token).then((value) {
     emit(GetOrdarsSuccessState());
     ordars =Ordars.fromJson(value.data);
   }).catchError((e){
     emit(GetOrdarsErrorState());

   });
 }

  void cancelOrder({required int id}) {
    DioHelper.getData(
      url: 'orders/${id}/cancel',
      token: token,
    ).then((value) {
      emit(CancelOrdarsSuccessState());
    }).catchError((error) {
      emit(CancelOrdarsErrorState());
    });
  }

  void logOut(context) {
    CashHelper.removeToken(key: 'token').then((value) {
      if (value) {
        navegatToAndFinsh(context, LoginScreen());
      }
    });
  }
}
