import 'package:bee/model/user_model.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/const.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  Icon suffix = Icon(IconBroken.Hide);

  void changeLoginEye() {
    isPassword = !isPassword;
    suffix = isPassword ? Icon(IconBroken.Hide) : Icon(IconBroken.Show);
    emit(loginChangeEye());
  }

  Future<void> login({
    required String userEmail,
    required String password,
  }) async {
    emit(UserLoginLoadinState());
    await DioHelper.postData(url: loginUrl, sendDate: {
      loginEmail: userEmail,
      loginPassword: password,
    }).then((value) {
      userModel = UserModel.formjson(value.data);
       token=userModel.userData!.token;

      print(userModel.userData!.name);
      emit(UserLoginSucsessState(userModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(UserLoginErrorState(onError.toString()));
    });
  }
}
