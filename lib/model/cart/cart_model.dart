class CartModel{
  bool? status;
  String? massage;
  Data? data;

  CartModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    massage=json['message'];
    data =json['data']!=null? Data.fromJson(json['data']):null;
  }
}

class Data{

  List<CartItem> cartItems=[];
  dynamic subTotal;
  dynamic total;

  Data.fromJson(Map<String,dynamic>json){
    json['cart_items'].forEach((e){
      cartItems.add(CartItem.fromJson(e));
    });
    subTotal=json['sub_total'];
    total=json['total'];
  }

}

class CartItem {
  int? id;
  late int quantity;
  CartProduct? product;
  CartItem.fromJson(Map<String,dynamic>json){
    id= json['id'];
    quantity=json['quantity'];
    product= json['product']!=null?CartProduct.fromJson(json['product']):null;
  }
}

class CartProduct{
  int? id ;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inCart;

  CartProduct.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inCart=json['in_cart'];
  }

}