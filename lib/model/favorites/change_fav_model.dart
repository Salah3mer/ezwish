class ChangeFavModel{
  late bool status ;
  late String massage ;
  ChangeFavModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    massage=json['message'];
  }

}