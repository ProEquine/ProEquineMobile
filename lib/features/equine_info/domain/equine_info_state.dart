part of 'equine_info_cubit.dart';

@immutable
abstract class EquineInfoState {}

class EquineInfoInitial extends EquineInfoState {}
class GetUserDisciplineSuccessful extends EquineInfoState{
  final GetUserDisciplinesResponseModel? model;
  GetUserDisciplineSuccessful({required this.model});
}
class GetUserDisciplineLoading extends EquineInfoState{}
class GetUserDisciplineError extends EquineInfoState{
  final String? message;
  GetUserDisciplineError({this.message});
}

class GetUserStablesSuccessful extends EquineInfoState{
  final GetUserStablesResponseModel? model;
  GetUserStablesSuccessful({required this.model});
}
class GetUserStablesLoading extends EquineInfoState{}
class GetUserStablesError extends EquineInfoState{
  final String? message;
  GetUserStablesError({this.message});
}

class GetUserRolesSuccessful extends EquineInfoState{
  final GetUserRolesResponseModel? model;
  GetUserRolesSuccessful({required this.model});
}
class GetUserRolesLoading extends EquineInfoState{}
class GetUserRolesError extends EquineInfoState{
  final String? message;
  GetUserRolesError({this.message});
}

class UpdateMainDisciplineSuccessful extends EquineInfoState{
  final String? message;
  UpdateMainDisciplineSuccessful({required this.message});
}
class UpdateMainDisciplineLoading extends EquineInfoState{}
class UpdateMainDisciplineError extends EquineInfoState{
  final String? message;
  UpdateMainDisciplineError({this.message});
}

class UpdateMainStableSuccessful extends EquineInfoState{
  final String? message;
  UpdateMainStableSuccessful({required this.message});
}
class UpdateMainStableLoading extends EquineInfoState{}
class UpdateMainStableError extends EquineInfoState{
  final String? message;
  UpdateMainStableError({this.message});
}

class AddSecondaryDisciplineSuccessful extends EquineInfoState{
  final String? message;
  AddSecondaryDisciplineSuccessful({required this.message});
}
class AddSecondaryDisciplineLoading extends EquineInfoState{}
class AddSecondaryDisciplineError extends EquineInfoState{
  final String? message;
  AddSecondaryDisciplineError({this.message});
}
class AddSecondaryRoleSuccessful extends EquineInfoState{
  final String? message;
  AddSecondaryRoleSuccessful({required this.message});
}
class AddSecondaryRoleLoading extends EquineInfoState{}
class AddSecondaryRoleError extends EquineInfoState{
  final String? message;
  AddSecondaryRoleError({this.message});
}
class DeleteRoleSuccessful extends EquineInfoState{
  final String? message;
  DeleteRoleSuccessful({required this.message});
}
class DeleteRoleLoading extends EquineInfoState{}
class DeleteRoleError extends EquineInfoState{
  final String? message;
  DeleteRoleError({this.message});
}
class AddSecondaryStableSuccessful extends EquineInfoState{
  final String? message;
  AddSecondaryStableSuccessful({required this.message});
}
class AddSecondaryStableLoading extends EquineInfoState{}
class AddSecondaryStableError extends EquineInfoState{
  final String? message;
  AddSecondaryStableError({this.message});
}

class UpdateSecondaryDisciplineSuccessful extends EquineInfoState{
  final String? message;
  UpdateSecondaryDisciplineSuccessful({required this.message});
}
class UpdateSecondaryDisciplineLoading extends EquineInfoState{}
class UpdateSecondaryDisciplineError extends EquineInfoState{
  final String? message;
  UpdateSecondaryDisciplineError({this.message});
}

class DeleteSecondaryDisciplineSuccessful extends EquineInfoState{
  final String? message;
  DeleteSecondaryDisciplineSuccessful({required this.message});
}
class DeleteSecondaryDisciplineLoading extends EquineInfoState{}
class DeleteSecondaryDisciplineError extends EquineInfoState{
  final String? message;
  DeleteSecondaryDisciplineError({this.message});
}

class DeleteSecondaryStableSuccessful extends EquineInfoState{
  final String? message;
  DeleteSecondaryStableSuccessful({required this.message});
}
class DeleteSecondaryStableLoading extends EquineInfoState{}
class DeleteSecondaryStableError extends EquineInfoState{
  final String? message;
  DeleteSecondaryStableError({this.message});
}