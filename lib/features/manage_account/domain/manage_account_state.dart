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
