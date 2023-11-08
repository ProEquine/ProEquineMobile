part of 'manage_account_cubit.dart';

@immutable
abstract class ManageAccountState {}

class ManageAccountInitial extends ManageAccountState {}

class ChangePasswordSuccessful extends ManageAccountState{
  final String? message;
  ChangePasswordSuccessful({required this.message});
}
class ChangePasswordLoading extends ManageAccountState{}
class ChangePasswordError extends ManageAccountState{
  final String? message;
  ChangePasswordError({this.message});
}

class SendPhoneSuccessful extends ManageAccountState{
  final String? message;
  SendPhoneSuccessful({required this.message});
}
class SendPhoneLoading extends ManageAccountState{}
class SendPhoneError extends ManageAccountState{
  final String? message;
  SendPhoneError({this.message});
}
class UpdatePhoneSuccessful extends ManageAccountState{
  final String? message;
  UpdatePhoneSuccessful({required this.message});
}
class UpdatePhoneLoading extends ManageAccountState{}
class UpdatePhoneError extends ManageAccountState{
  final String? message;
  UpdatePhoneError({this.message});
}
class UpdatePhoneSecondarySuccessful extends ManageAccountState{
  final String? message;
  UpdatePhoneSecondarySuccessful({required this.message});
}
class UpdateSecondaryPhoneLoading extends ManageAccountState{}
class UpdatePhoneSecondaryError extends ManageAccountState{
  final String? message;
  UpdatePhoneSecondaryError({this.message});
}

class AddAddressSuccessfully extends ManageAccountState{
  final String? message;
  AddAddressSuccessfully({required this.message});
}
class AddAddressLoading extends ManageAccountState{}
class AddAddressError extends ManageAccountState{
  final String? message;
  AddAddressError({this.message});
}
class AddSecondaryPhoneSuccessful extends ManageAccountState{
  final AddSecondaryNumberResponseModel? responseModel;
  AddSecondaryPhoneSuccessful({required this.responseModel});
}
class AddSecondaryPhoneLoading extends ManageAccountState{}
class AddSecondaryPhoneError extends ManageAccountState{
  final String? message;
  AddSecondaryPhoneError({this.message});
}


class GetUserSuccessful extends ManageAccountState{
  final UserDataResponseModel? responseModel;
  GetUserSuccessful({required this.responseModel});
}
class GetUserLoading extends ManageAccountState{}
class GetUserError extends ManageAccountState{
  final String? message;
  GetUserError({this.message});
}

class DeleteAccountSuccessful extends ManageAccountState {
  final String? message;
  DeleteAccountSuccessful({required this.message});
}

class DeleteAccountLoading extends ManageAccountState {}

class DeleteAccountError extends ManageAccountState {
  final String? message;
  DeleteAccountError({this.message});
}

class UpdateNameSuccessful extends ManageAccountState {
  final String? message;
  UpdateNameSuccessful({required this.message});
}

class UpdateNameLoading extends ManageAccountState {}

class UpdateNameError extends ManageAccountState {
  final String? message;
  UpdateNameError({this.message});
}

class UpdateNationalitySuccessful extends ManageAccountState {
  final String? message;
  UpdateNationalitySuccessful({required this.message});
}

class UpdateNationalityLoading extends ManageAccountState {}

class UpdateNationalityError extends ManageAccountState {
  final String? message;
  UpdateNationalityError({this.message});
}

class UpdateDOBSuccessful extends ManageAccountState {
  final String? message;
  UpdateDOBSuccessful({required this.message});
}

class UpdateDOBLoading extends ManageAccountState {}

class UpdateDOBError extends ManageAccountState {
  final String? message;
  UpdateDOBError({this.message});
}
class AddBioSuccessful extends ManageAccountState {
  final String? message;
  AddBioSuccessful({required this.message});
}

class AddBioLoading extends ManageAccountState {}

class AddBioError extends ManageAccountState {
  final String? message;
  AddBioError({this.message});
}

class UploadImageSuccessful extends ManageAccountState {
  final String? message;
  UploadImageSuccessful({required this.message});
}

class UploadImageLoading extends ManageAccountState {}

class UploadImageError extends ManageAccountState {
  final String? message;
  UploadImageError({this.message});
}

class GetAllStatesSuccessfully extends ManageAccountState {
  final GetAllStatesResponseModel? responseModel;
  GetAllStatesSuccessfully({required this.responseModel});
}

class GetAllStatesLoading extends ManageAccountState {}

class GetAllStatesError extends ManageAccountState {
  final String? message;
  GetAllStatesError({this.message});
}
class GetAllCitiesSuccessfully extends ManageAccountState {
  final GetALlCitiesResponseModel? responseModel;
  GetAllCitiesSuccessfully({required this.responseModel});
}

class GetAllCitiesLoading extends ManageAccountState {}

class GetAllCitiesError extends ManageAccountState {
  final String? message;
  GetAllCitiesError({this.message});
}
