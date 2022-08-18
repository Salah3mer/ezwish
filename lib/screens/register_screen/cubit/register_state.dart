part of 'register_cubit.dart';

abstract class RegisterState{}

class RegisterInitial extends RegisterState {}
class CreateUserLoadingState extends RegisterState {}
class ChangeEye extends RegisterState {}
class pickImageSuccessState extends RegisterState {}
class CreateUserSuccessState extends RegisterState {}
class CreateUserErrorState extends RegisterState {}
