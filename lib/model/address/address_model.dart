class AddressModel{
bool? status;
String?massage;
AddressDetails? addressDetails;

AddressModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  massage=json['massage'];
  addressDetails = json['data'] != null ? AddressDetails.fromJson(json['data']) : null;

}
}



class AddressDetails{
  int? id;
  String? name;
  String? city;
  String? region;
  String? note;
  String? details;
  dynamic lat;
  dynamic log;


  AddressDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    city=json['city'];
    region=json['region'];
    note=json['notes'];
    details=json['details'];
    lat=json['latitude'];
    log=json['longitude'];
  }
}