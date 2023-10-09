part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

/// successful state to emit when server return success status
/// in our case we just need to show message login successfully
class LoginSuccessful extends UserState{
  final String? message;
  LoginSuccessful({required this.message});
}
/// loading state to emit when calling the server
class LoginLoading extends UserState{}

/// error state to emit when server return error
/// to show message return from server
/// for example the password is incorrect
class LoginError extends UserState{
  final String? message;
  LoginError({this.message});
}

class RegisterSuccessful extends UserState{
  final String? message;
  RegisterSuccessful({required this.message});
}
class RegisterLoading extends UserState{}
class RegisterError extends UserState{
  final String? message;
  RegisterError({this.message});
}
class CheckUsernameSuccessful extends UserState{
  final String? message;
  CheckUsernameSuccessful({required this.message});
}
class CheckUsernameLoading extends UserState{}
class CheckUsernameError extends UserState{
  final String? message;
  CheckUsernameError({this.message});
}
class SendVerificationSuccessful extends UserState{
  final String? message;
  SendVerificationSuccessful({required this.message});
}
class SendVerificationLoading extends UserState{}
class SendVerificationError extends UserState{
  final String? message;
  SendVerificationError({this.message});
}

class GetStablesSuccessful extends UserState{
  final List<Stable> getStablesResponseModel;
  GetStablesSuccessful({required this.getStablesResponseModel});
}
class GetStablesLoading extends UserState{}
class GetStablesError extends UserState{
  final String? message;
  GetStablesError({this.message});
}

class CheckVerificationSuccessful extends UserState{
  final String? message;
  CheckVerificationSuccessful({required this.message});
}
class CheckVerificationLoading extends UserState{}
class CheckVerificationError extends UserState{
  final String? message;
  CheckVerificationError({this.message});
}

class ForgotPasswordSuccessful extends UserState{
  final ForgotPasswordResponseModel? model;
  ForgotPasswordSuccessful({required this.model});
}
class ForgotPasswordLoading extends UserState{}
class ForgotPasswordError extends UserState{
  final String? message;
  ForgotPasswordError({this.message});
}

class ResetPasswordSuccessful extends UserState{
  final String? message;
  ResetPasswordSuccessful({required this.message});
}
class ResetPasswordLoading extends UserState{}
class ResetPasswordError extends UserState{
  final String? message;
  ResetPasswordError({this.message});
}

class SelectInterestsSuccessful extends UserState{
  final String? message;
  SelectInterestsSuccessful({required this.message});
}
class SelectInterestsLoading extends UserState{}
class SelectInterestsError extends UserState{
  final String? message;
  SelectInterestsError({this.message});
}

class SendMailVerificationSuccessful extends UserState{
  final String? message;
  SendMailVerificationSuccessful({required this.message});
}
class SendMailVerificationLoading extends UserState{}
class SendMailVerificationError extends UserState{
  final String? message;
  SendMailVerificationError({this.message});
}

class CheckMailVerificationSuccessful extends UserState{
  final String? message;
  CheckMailVerificationSuccessful({required this.message});
}
class CheckMailVerificationLoading extends UserState{}
class CheckMailVerificationError extends UserState{
  final String? message;
  CheckMailVerificationError({this.message});
}

class UpdateMailSuccessful extends UserState{
  final String? message;
  UpdateMailSuccessful({required this.message});
}
class UpdateMailLoading extends UserState{}
class UpdateMailError extends UserState{
  final String? message;
  UpdateMailError({this.message});
}
class CheckUpdateMailSuccessful extends UserState{
  final String? message;
  CheckUpdateMailSuccessful({required this.message});
}
class CheckUpdateMailLoading extends UserState{}
class CheckUpdateMailError extends UserState{
  final String? message;
  CheckUpdateMailError({this.message});
}
class DeleteAccountSuccessful extends UserState {
  final String? message;
  DeleteAccountSuccessful({required this.message});
}

class DeleteAccountLoading extends UserState {}

class DeleteAccountError extends UserState {
  final String? message;
  DeleteAccountError({this.message});
}

