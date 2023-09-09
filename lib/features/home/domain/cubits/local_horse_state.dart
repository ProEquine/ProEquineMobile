part of 'local_horse_cubit.dart';

@immutable
abstract class LocalHorseState {}

class LocalHorseInitial extends LocalHorseState {}

class AddHorseSuccessfully extends LocalHorseState {
  final Horse item;

  AddHorseSuccessfully({required this.item});
}

class AddHorseLoading extends LocalHorseState {}

class AddHorseError extends LocalHorseState {
  final String? message;

  AddHorseError({required this.message});
}
class GetHorsesSuccessfully extends LocalHorseState {
  final List<Horse> items;

  GetHorsesSuccessfully({required this.items});
}

class GetHorsesLoading extends LocalHorseState {}

class GetHorsesError extends LocalHorseState {
  final String? message;

  GetHorsesError({required this.message});
}
