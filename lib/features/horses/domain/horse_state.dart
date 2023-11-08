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
class RemoveHorseSuccessfully extends HorseState{
  final String message;
  RemoveHorseSuccessfully({required this.message});
}
class RemoveHorseLoading extends HorseState{}
class RemoveHorseError extends HorseState{
  final String? message;
  RemoveHorseError({this.message});
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

class AddHorseDocumentSuccessfully extends HorseState{
  final String message;
  AddHorseDocumentSuccessfully({required this.message});
}
class AddHorseDocumentLoading extends HorseState{}
class AddHorseDocumentError extends HorseState{
  final String? message;
  AddHorseDocumentError({this.message});
}
class RemoveHorseDocumentSuccessfully extends HorseState{
  final String message;
  RemoveHorseDocumentSuccessfully({required this.message});
}
class RemoveHorseDocumentLoading extends HorseState{}
class RemoveHorseDocumentError extends HorseState{
  final String? message;
  RemoveHorseDocumentError({this.message});
}
class EditHorseDocumentSuccessfully extends HorseState{
  final String message;
  EditHorseDocumentSuccessfully({required this.message});
}
class EditHorseDocumentLoading extends HorseState{}
class EditHorseDocumentError extends HorseState{
  final String? message;
  EditHorseDocumentError({this.message});
}

class VerifyHorseSuccessfully extends HorseState{
  final String message;
  VerifyHorseSuccessfully({required this.message});
}
class VerifyHorseLoading extends HorseState{}
class VerifyHorseError extends HorseState{
  final String? message;
  VerifyHorseError({this.message});
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

class GetHorsesDocumentsSuccessfully extends HorseState{
  final AllHorsesDocumentsResponseModel responseModel;
  GetHorsesDocumentsSuccessfully({required this.responseModel});
}
class GetHorsesDocumentsLoading extends HorseState{}
class GetHorsesDocumentsError extends HorseState{
  final String? message;
  GetHorsesDocumentsError({this.message});
}

