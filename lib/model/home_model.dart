class HomeModel {
  bool? status;
  HomeData? homeData;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    homeData =json['data']!=null?HomeData.fromjson(json['data']):null;
  }
}

class HomeData {
   List<BannerModel> banners=[];
   List<ProductModel> products=[];

  HomeData.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((e) {
      banners.add(BannerModel.fromJson(e));
    });
    json['products'].forEach((e) {
      products.add(ProductModel.fromJson(e));
    });
  }
}

class BannerModel {
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
