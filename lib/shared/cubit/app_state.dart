part of 'app_cubit.dart';
abstract class AppState {}

class AppInitial extends AppState {}
class GetHomeLoadingState extends AppState {}
class GetUserLoadingState extends AppState {}
class GetUserSuccessState extends AppState {}
class GetUserErrorState extends AppState {}
class GetHomeSuccessState extends AppState {}
class GetHomeErrorState extends AppState {}
class GetCategoryLoadingState extends AppState {}
class GetCategorySucssesState extends AppState {}
class GetCategoryErrorState extends AppState {}
class ChangeFavoritesState extends AppState {}
class ChangeFavoritesSuccessState extends AppState {}
class ChangeFavoritesErrorState extends AppState {}
class GetFavoritesErrorState extends AppState {
  final String e;

  GetFavoritesErrorState(this.e);
}
class GetFavoritesSuccessState extends AppState {}
class GetFavoritesLoadingState extends AppState {}
class GetProductLoadingState extends AppState {}
class GetProductSuccessState extends AppState {}
class GetProductErrorState extends AppState {}
class AddOrRemoveFromCartLoadingState extends AppState {}
class AddOrRemoveFromCartSuccessState extends AppState {
  final String massage;
  AddOrRemoveFromCartSuccessState(this.massage);
}
class AddOrRemoveFromCartErrorState extends AppState {}
class GetCartLoadingState extends AppState {}
class GetCartSuccessState extends AppState {}
class GetCartErrorState extends AppState {}
class SendQuantitySuccessState extends AppState {}
class SendQuantityErrorState extends AppState {}

class DeleteFromCartSuccessState extends AppState {}
class DeleteFromCartErrorState extends AppState {}
class PickImageSuccessState extends AppState {}
class UpdateUserSuccessState extends AppState {}
class UpdateUserErrorState extends AppState {}
class UpdateUserLoadingStateState extends AppState {}

class SearchSuccessState extends AppState {}
class SearchErrorState extends AppState {}
class SearchLoadingStateState extends AppState {}
class AddAddreessSuccessState extends AppState {
}
class AddAddreessErrorState extends AppState {}
class AddAddreessLoadingState extends AppState {}

class GetAddreessSuccessState extends AppState {
  final GetAddressModel? getAddressModel;

  GetAddreessSuccessState(this.getAddressModel);
}
class GetAddreessErrorState extends AppState {}
class GetAddreessLoadingState extends AppState {}
class UpdateAddreessSuccessState extends AppState {}
class UpdateAddreessErrorState extends AppState {}
class UpdateAddreessLoadingState extends AppState {}
class AddOrdarSuccessState extends AppState {
  final String s;
  final bool state;
  AddOrdarSuccessState( this.s, this.state);
}
class AddOrdarErrorState extends AppState {}
class AddOrdarLoadingState extends AppState {}
class GetFAQSuccessState extends AppState {}
class GetFAQErrorState extends AppState {}
class GetFAQLoadingState extends AppState {}
class GetPrivacySuccessState extends AppState {}
class GetPrivacyErrorState extends AppState {}
class GetPrivacyLoadingState extends AppState {}
class GetOrdarsSuccessState extends AppState {}
class GetOrdarsErrorState extends AppState {}

class CancelOrdarsSuccessState extends AppState {}
class CancelOrdarsErrorState extends AppState {}
class GetOrdarsLoadingState extends AppState {}

class ChangePasswordSuccessState extends AppState {
  final bool state;
  final String msg;

  ChangePasswordSuccessState(this.state, this.msg);
}
class ChangePasswordErrorState extends AppState {}
class ChangePasswordLoadingState extends AppState {}
class changeState extends AppState {}
class  toggle extends AppState {}
class  StepperState extends AppState {}
class  CurrentSelectedItem extends AppState {}
class  ChangeExppension extends AppState {}
class  ChangeEye extends AppState {}

