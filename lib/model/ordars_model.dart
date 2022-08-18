class Ordars{
  bool? status;
  OrdarsData ?data;
  Ordars.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=json['data']!=null? OrdarsData.fromJson(json['data']):null;

  }

}

class OrdarsData{
  int? currentPage;
  List<Ordar> ordar=[];
  OrdarsData.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((e){
      ordar.add(Ordar.fromJson(e));
    });
  }
}

class Ordar{
  int? id;
  dynamic total;
 String? date;
 String? state;

 Ordar.fromJson(Map<String,dynamic>json){
   id=json['id'];
   total=json['total'];
   date=json['date'];
   state=json['status'];
 }
}