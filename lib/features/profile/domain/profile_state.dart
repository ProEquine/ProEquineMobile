part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ChangePasswordSuccessful extends ProfileState{
  final String? message;
  ChangePasswordSuccessful({required this.message});
}
class ChangePasswordLoading extends ProfileState{}
class ChangePasswordError extends ProfileState{
  final String? message;
  ChangePasswordError({this.message});
}
class SendPhoneSuccessful extends ProfileState{
  final String? message;
  SendPhoneSuccessful({required this.message});
}
class SendPhoneLoading extends ProfileState{}
class SendPhoneError extends ProfileState{
  final String? message;
  SendPhoneError({this.message});
}


class UpdatePhoneSuccessful extends ProfileState{
  final String? message;
  UpdatePhoneSuccessful({required this.message});
}
class UpdatePhoneLoading extends ProfileState{}
class UpdatePhoneError extends ProfileState{
  final String? message;
  UpdatePhoneError({this.message});
}

class ContactSupportSuccessful extends ProfileState{
  final String? message;
  ContactSupportSuccessful({required this.message});
}
class ContactSupportLoading extends ProfileState{}
class ContactSupportError extends ProfileState{
  final String? message;
  ContactSupportError({this.message});
}

class GetUserSuccessful extends ProfileState{
  final UserDataResponseModel? responseModel;
  GetUserSuccessful({required this.responseModel});
}
class GetUserLoading extends ProfileState{}
class GetUserError extends ProfileState{
  final String? message;
  GetUserError({this.message});
}
