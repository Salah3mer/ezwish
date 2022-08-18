
import 'dart:convert';
import 'dart:io';
import 'package:bee/model/user_model.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/style/icon_broken.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  Icon suffix = Icon(IconBroken.Hide);

  void changeRegisterEye() {
    isPassword = !isPassword;
    suffix = isPassword ? Icon(IconBroken.Hide) : Icon(IconBroken.Show);

    emit(ChangeEye());
  }

  UserModel? userModel;
  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    String image='',
  }) {
    emit(CreateUserLoadingState());
    UserData userData = UserData(name, email, phone, image, password);

    DioHelper.postData(url: registerUrl, sendDate: userData.toJson()).then((value) {
      userModel = UserModel.formjson(value.data);
      emit(CreateUserSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(CreateUserErrorState());
    });
  }

  File? imageFile;
  Future pickImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        List<int> imageBytes = imageFile!.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
        emit(pickImageSuccessState());
    }
  }
}