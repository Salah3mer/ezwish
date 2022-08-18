
import 'package:bee/model/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class UserLoginLoadinState extends LoginState {}
class UserLoginSucsessState extends LoginState {
  final UserModel userModel;
  UserLoginSucsessState(this.userModel);
}
class UserLoginErrorState extends LoginState {
  final String massage;
  UserLoginErrorState(this.massage);
}
class loginChangeEye extends LoginState {}
