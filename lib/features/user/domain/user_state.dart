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
class SendVerificationSuccessful extends UserState{
  final String? message;
  SendVerificationSuccessful({required this.message});
}
class SendVerificationLoading extends UserState{}
class SendVerificationError extends UserState{
  final String? message;
  SendVerificationError({this.message});
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

