import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable {
  final int code;
  final String message;

 const AppException({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}

class BadRequestException extends AppException {
 const BadRequestException({int code = 400, String message = 'Bad Request'})
      : super(code:code, message: message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({int code = 401, String message = 'Unauthorized'})
      : super(code:code, message: message);
}

class ForbiddenException extends AppException {
  ForbiddenException({int code = 403, String message = 'Forbidden'})
      : super(code:code, message: message);
}

class NotFoundException extends AppException {
  const NotFoundException({int code = 404, String message = 'Not Found'})
      : super(code:code, message: message);
}

class MethodNotAllowedException extends AppException {
  const MethodNotAllowedException({int code = 405, String message = 'Method Not Allowed'})
      : super(code:code, message: message);
}

class InternalServerErrorException extends AppException {
 const InternalServerErrorException({int code = 500, String message = 'Internal Server Error'})
      : super(code:code, message: message);
}

class ServiceUnavailableException extends AppException {
 const ServiceUnavailableException({int code = 503, String message = 'Service Unavailable'})
      : super(code:code, message: message);
}