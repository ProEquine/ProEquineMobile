// import 'failures.dart';
//
// class ServerException implements Exception {
//   ServerFailure failure = ServerFailure();
// }
//
// class OfflineException implements Exception {
//   OfflineFailure failure = OfflineFailure();
// }
//
// class BadRequestException implements Exception {
//   BadRequestFailure failure = BadRequestFailure();
// }
//
// class ConnectionException implements Exception {
//   ConnectionFailure failure = ConnectionFailure();
// }
//
// class ForbiddenException implements Exception {
//   ForbiddenFailure failure = ForbiddenFailure();
// }
//
// class HttpMethodUnCorrectException implements Exception {
//   HttpMethodUnCorrectFailure failure = HttpMethodUnCorrectFailure();
// }
//
// class LoginRequiredException implements Exception {
//   LoginRequiredFailure failure = LoginRequiredFailure();
// }
//
// class TimeoutException implements Exception {
//   TimeoutFailure failure = TimeoutFailure();
// }
//
// class UnsupportedException implements Exception {
//   UnsupportedFailure failure = UnsupportedFailure();
// }


import 'failures.dart';

abstract class RebiException implements Exception {
  Failure get failure;
}

class ServerException implements RebiException {
  @override
  Failure get failure => ServerFailure();
}

class CustomException implements RebiException {
  final String? message;


  CustomException(this.message);

  @override
  Failure get failure => CustomFailure('$message');
}

class UnauthorizedException implements RebiException {
  @override
  Failure get failure => UnauthorizedFailure();
}

//
// class OfflineException implements RebiException {
//   @override
//   Failure get failure => OfflineFailure();
// }
//
// class BadRequestException implements RebiException {
//   @override
//   Failure get failure => BadRequestFailure();
// }
//

//
// class ConnectionException implements RebiException {
//   @override
//   Failure get failure => ConnectionFailure();
// }
//
// class ForbiddenException implements RebiException {
//   @override
//   Failure get failure => ForbiddenFailure();
// }
//
// class HttpMethodUnCorrectException implements RebiException {
//   @override
//   Failure get failure => HttpMethodUnCorrectFailure();
// }
//
// class LoginRequiredException implements RebiException {
//   @override
//   Failure get failure => LoginRequiredFailure();
// }
//
// class TimeoutException implements RebiException {
//   @override
//   Failure get failure => TimeoutFailure();
// }
//
// class UnsupportedException implements RebiException {
//   @override
//   Failure get failure => UnsupportedFailure();
// }
