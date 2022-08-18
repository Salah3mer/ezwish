class ProductDetailesModel{
  bool? status;
  ProductDetailes? data;

  ProductDetailesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data =
    json['data'] != null ? ProductDetailes.fromJson(json['data']) : null;
  }

}

class ProductDetailes{
   int? id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   List<String> image=[];
   String? name;
   String? description;
   bool? inFavorites;
   bool? inCart;

  ProductDetailes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    json['images'].forEach((e){
      image.add(e);
    });
    name = json['name'];
    description = json['description'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}