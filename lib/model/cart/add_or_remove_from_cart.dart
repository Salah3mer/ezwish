class AddOrRemoveFromCartModel{
  bool? status;
  String? massage;

  AddOrRemoveFromCartModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    massage=json['message'];
  }
}