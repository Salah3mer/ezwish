class GetAddressModel{
  bool? status;
  GetAddressData? addressData;

  GetAddressModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    addressData = json['data'] != null ? GetAddressData.fromJson(json['data']) : null;

  }
}

class GetAddressData{
  int? currentPage;
  List<AddressDetails> address=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;
  GetAddressData.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((e){
      address.add(AddressDetails.fromJson(e));
    });
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}
class AddressDetails{
  dynamic id;
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