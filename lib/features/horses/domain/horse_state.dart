part of 'horse_cubit.dart';

@immutable
abstract class HorseState {}

class HorseInitial extends HorseState {}

class AddHorseSuccessfully extends HorseState{
  final String message;
  AddHorseSuccessfully({required this.message});
}
class AddHorseLoading extends HorseState{}
class AddHorseError extends HorseState{
  final String? message;
  AddHorseError({this.message});
}
class UpdateHorseSuccessfully extends HorseState{
  final String message;
  UpdateHorseSuccessfully({required this.message});
}
class UpdateHorseLoading extends HorseState{}
class UpdateHorseError extends HorseState{
  final String? message;
  UpdateHorseError({this.message});
}

class UpdateHorseConditionSuccessfully extends HorseState{
  final String message;
  UpdateHorseConditionSuccessfully({required this.message});
}
class UpdateHorseConditionLoading extends HorseState{}
class UpdateHorseConditionError extends HorseState{
  final String? message;
  UpdateHorseConditionError({this.message});
}

class GetUserHorsesSuccessfully extends HorseState{
  final GetAllHorsesResponseModel getAllHorsesResponseModel;
  GetUserHorsesSuccessfully({required this.getAllHorsesResponseModel});
}
class GetUserHorsesLoading extends HorseState{}
class GetUserHorsesError extends HorseState{
  final String? message;
  GetUserHorsesError({this.message});
}

