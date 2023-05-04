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
/// loading state to emit when calling the server
class RegisterLoading extends UserState{}

/// error state to emit when server return error
/// to show message return from server
/// for example the password is incorrect
class RegisterError extends UserState{
  final String? message;
  RegisterError({this.message});
}
