part of 'support_cubit.dart';

@immutable
abstract class SupportState {}

class SupportInitial extends SupportState {}

class ContactSupportSuccessful extends SupportState{
  final String? message;
  ContactSupportSuccessful({required this.message});
}
class ContactSupportLoading extends SupportState{}
class ContactSupportError extends SupportState{
  final String? message;
  ContactSupportError({this.message});
}