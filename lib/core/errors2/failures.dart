import 'package:equatable/equatable.dart';
import 'package:proequine/core/utils/extensions.dart';

//
abstract class Failure extends Equatable {
  abstract final String message;
}

//
// class OfflineFailure extends Failure {
//   @override
//   List<Object?> get props => [];
//
//   @override
//   String get message => 'Please Check Your Internet Connection'.tra;
// }
//
class CustomFailure extends Failure {
  @override
  List<Object?> get props => [];

  final String failureMessage;

  @override
  String get message => failureMessage;

  CustomFailure(this.failureMessage);
}


class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => 'Please try again later .'.tra;
}

class UnauthorizedFailure extends Failure {
  @override
  String get message => 'Unauthorized'.tra;

  @override
  List<Object?> get props => [];
}


//
// class BadRequestFailure extends Failure {
//   @override
//   String get message => 'Bad request error'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
//

//
// class ConnectionFailure extends Failure {
//   @override
//   String get message => 'Connection error, try again later'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
//
// class ForbiddenFailure extends Failure {
//   @override
//   String get message => 'You don\'t have permission to reach this'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
//
// class HttpMethodUnCorrectFailure extends Failure {
//   @override
//   String get message => 'HTTP method un correct'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
//
// class LoginRequiredFailure extends Failure {
//   @override
//   String get message => 'Login required'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
//
// class TimeoutFailure extends Failure {
//   @override
//   String get message => 'Time out'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
//
// class UnsupportedFailure extends Failure {
//   @override
//   String get message => 'Unsupported Media Type'.tra;
//
//   @override
//   List<Object?> get props => [];
// }
