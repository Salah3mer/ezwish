class CategoryModel {
  late bool status;
  CategoryData? categoryData;
  CategoryModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
   categoryData= json['data']!=null?CategoryData.fromJson(json['data']):null;
  }

}
class CategoryData{
  late int currentpage;
  List<SingleCategoryData> singleCategoryData=[];
  CategoryData.fromJson(Map<String,dynamic>json){
    currentpage =json['current_page'];
    json['data'].forEach((e){
    singleCategoryData.add(SingleCategoryData.fromJson(e));
    });
  }

}

class SingleCategoryData{
  late int id;
  late String name;
  late String image;

  SingleCategoryData.fromJson(Map<String,dynamic>json){
    id =json['id'];
    name=json['name'];
    image=json['image'];
  }
}