class UserModel {
  late bool status;
  late String massage;
  UserData? userData;

  UserModel.formjson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    massage = json['message'] ?? '';
    userData = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String password;
  late String token;

  UserData(this.name, this.email, this.phone, this.image, this.password);

  UserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }

  Map<String , dynamic> toJson(){
    return{
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'image':image,
    };
  }
}
